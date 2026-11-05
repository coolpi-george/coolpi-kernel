// SPDX-License-Identifier: GPL-2.0
/*
 * Copyright (c) 2021 Rockchip Electronics Co. Ltd.
 *
 * Author: Dingxian Wen <shawn.wen@rock-chips.com>
 */

#include <linux/clk.h>
#include <linux/compat.h>
#include <linux/debugfs.h>
#include <linux/delay.h>
#include <linux/extcon-provider.h>
#include <linux/gpio/consumer.h>
#include <linux/i2c.h>
#include <linux/interrupt.h>
#include <linux/irq.h>
#include <linux/kernel.h>
#include <linux/math64.h>
#include <linux/module.h>
#include <linux/of_graph.h>
#include <linux/platform_device.h>
#include <linux/reset.h>
#include <linux/rk-camera-module.h>
#include <linux/slab.h>
#include <linux/timer.h>
#include <linux/v4l2-dv-timings.h>
#include <linux/version.h>
#include <linux/videodev2.h>
#include <linux/workqueue.h>
#include <linux/rk_hdmirx_class.h>
#include <media/v4l2-controls_rockchip.h>
#include <media/v4l2-ctrls.h>
#include <media/v4l2-device.h>
#include <media/v4l2-dv-timings.h>
#include <media/v4l2-event.h>
#include <media/v4l2-fwnode.h>
#include <video/videomode.h>
#include <linux/rk_hdmirx_config.h>

#include "rk628.h"
#include "rk628_combrxphy.h"
#include "rk628_combtxphy.h"
#include "rk628_csi.h"
#include "rk628_cru.h"
#include "rk628_dsi.h"
#include "rk628_hdmirx.h"
#include "rk628_mipi_dphy.h"
#include "rk628_post_process.h"

static int debug;
module_param(debug, int, 0644);
MODULE_PARM_DESC(debug, "debug level (0-3)");

#define DRIVER_VERSION			KERNEL_VERSION(0, 0x1, 0x0)
#define RK628_BT1120_CSI_NAME			"rk628-bt1120-csi"

enum tx_mode_type {
	CSI_MODE,
	DSI_MODE,
};

struct rk628_plat_data {
	int bus_fmt;
	int tx_mode;
	int rx_mode;
};

struct rk628_bt1120_csi {
	struct device *dev;
	struct i2c_client *i2c_client;
	struct rk628 *rk628;
	struct media_pad pad;
	struct v4l2_subdev sd;
	struct v4l2_dv_timings src_timings;
	struct v4l2_dv_timings timings;
	struct v4l2_ctrl_handler hdl;
	struct v4l2_ctrl *detect_tx_5v_ctrl;
	struct v4l2_ctrl *link_freq;
	struct v4l2_ctrl *pixel_rate;
	struct gpio_desc *enable_gpio;
	struct gpio_desc *reset_gpio;
	struct gpio_desc *power_gpio;
	struct clk *soc_24M;
	struct clk *clk_vop;
	struct clk *clk_rx_read;
	struct delayed_work delayed_work_res_change;
	struct mutex confctl_mutex;
	const struct rk628_bt1120_csi_mode *cur_mode;
	const char *module_facing;
	const char *module_name;
	const char *len_name;
	u32 module_index;
	u64 lane_mbps;
	u8 csi_lanes_in_use;
	u32 mbus_fmt_code;
	u8 fps;
	bool rxphy_pwron;
	bool txphy_pwron;
	bool scaler_en;
	bool continues_clk;
	struct rk628_combtxphy *txphy;
	struct rk628_dsi dsi;
	const struct rk628_plat_data *plat_data;
	bool is_streaming;
	bool dual_mipi_use;
	bool bt1120_dual_edge;
	bool bt1120_yc_swap;
	bool bt1120_uv_swap;
};

struct rk628_bt1120_csi_mode {
	u32 width;
	u32 height;
	struct v4l2_fract max_fps;
	u32 hts_def;
	u32 vts_def;
	u32 exp_def;
};

static const s64 link_freq_menu_items[] = {
	RK628_CSI_LINK_FREQ_LOW,
	RK628_CSI_LINK_FREQ_HIGH,
};

static const struct v4l2_dv_timings_cap rk628_bt1120_csi_timings_cap = {
	.type = V4L2_DV_BT_656_1120,
	/* keep this initialization for compatibility with GCC < 4.4.6 */
	.reserved = { 0 },
	V4L2_INIT_BT_TIMINGS(1, 10000, 1, 10000, 0, 600000000,
			V4L2_DV_BT_STD_CEA861 | V4L2_DV_BT_STD_DMT |
			V4L2_DV_BT_STD_GTF | V4L2_DV_BT_STD_CVT,
			V4L2_DV_BT_CAP_PROGRESSIVE | V4L2_DV_BT_CAP_INTERLACED |
			V4L2_DV_BT_CAP_REDUCED_BLANKING |
			V4L2_DV_BT_CAP_CUSTOM)
};

static const struct mipi_timing rk628d_csi_mipi = {
	0x0b, 0x53, 0x10, 0x5b, 0x0b, 0x43, 0x2c, 0x50, 0x0f
};

static const struct mipi_timing rk628f_csi0_mipi = {
	0x0b, 0x53, 0x10, 0x5b, 0x0b, 0x43, 0x2c, 0x50, 0x0f
};

static const struct mipi_timing rk628f_csi1_mipi = {
//data_lp, data-pre, data-zero, data-trail, clk_lp, clk-pre, clk-zero, clk-trail, clk-post
	0x0b, 0x53, 0x10, 0x5b, 0x0b, 0x43, 0x2c, 0x50, 0x0f
};

static const struct mipi_timing rk628f_dsi0_mipi = {
	0x10, 0x70, 0x1c, 0x7f, 0x10, 0x70, 0x3f, 0x7f, 0x1f
};

static struct rkmodule_csi_dphy_param rk3588_dcphy_param = {
	.vendor = PHY_VENDOR_SAMSUNG,
	.lp_vol_ref = 0,
	.lp_hys_sw = {3, 0, 0, 0},
	.lp_escclk_pol_sel = {1, 0, 0, 0},
	.skew_data_cal_clk = {0, 3, 3, 3},
	.clk_hs_term_sel = 2,
	.data_hs_term_sel = {2, 2, 2, 2},
	.reserved = {0},
};

static const struct rk628_bt1120_csi_mode supported_modes[] = {
	{
		.width = 1920,
		.height = 1080,
		.max_fps = {
			.numerator = 10000,
			.denominator = 600000,
		},
		.hts_def = 2200,
		.vts_def = 1125,
	}, {
		.width = 1280,
		.height = 720,
		.max_fps = {
			.numerator = 10000,
			.denominator = 600000,
		},
		.hts_def = 1650,
		.vts_def = 750,
	}, {
		.width = 720,
		.height = 576,
		.max_fps = {
			.numerator = 10000,
			.denominator = 500000,
		},
		.hts_def = 864,
		.vts_def = 625,
	}, {
		.width = 720,
		.height = 480,
		.max_fps = {
			.numerator = 10000,
			.denominator = 600000,
		},
		.hts_def = 858,
		.vts_def = 525,
	},
};

static struct v4l2_dv_timings dst_timing = {
	.type = V4L2_DV_BT_656_1120,
	.bt = {
		.interlaced = V4L2_DV_PROGRESSIVE,
		.width = 1920,
		.height = 1080,
		.hfrontporch = 88,
		.hsync = 44,
		.hbackporch = 148,
		.vfrontporch = 4,
		.vsync = 5,
		.vbackporch = 36,
		.pixelclock = 148500000,
	},
};

static void rk628_post_process_setup(struct v4l2_subdev *sd);
static int rk628_bt1120_csi_s_ctrl_detect_tx_5v(struct v4l2_subdev *sd);
static int rk628_bt1120_csi_s_dv_timings(struct v4l2_subdev *sd,
				 struct v4l2_dv_timings *timings);
static int mipi_dphy_power_on(struct rk628_bt1120_csi *csi);
static void mipi_dphy_power_off(struct rk628_bt1120_csi *csi);
static int rk628_bt1120_csi_format_change(struct v4l2_subdev *sd);
static void enable_stream(struct v4l2_subdev *sd, bool enable);
static void rk628_bt1120_csi_set_csi(struct v4l2_subdev *sd);
static void rk628_bt1120_csi_disable_stream(struct v4l2_subdev *sd);

static inline struct rk628_bt1120_csi *to_csi(struct v4l2_subdev *sd)
{
	return container_of(sd, struct rk628_bt1120_csi, sd);
}

static bool tx_5v_power_present(struct v4l2_subdev *sd)
{
	return true;
}

static int rk628_bt1120_csi_get_detected_timings(struct v4l2_subdev *sd,
				     struct v4l2_dv_timings *timings)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);
	struct v4l2_bt_timings *bt = &timings->bt;
	struct v4l2_dv_timings default_timing =
				V4L2_DV_BT_CEA_1920X1080P60;

	*timings = default_timing;

	v4l2_dbg(1, debug, sd, "hfp:%d, hs:%d, hbp:%d, vfp:%d, vs:%d, vbp:%d, interlace:%d\n",
		 bt->hfrontporch, bt->hsync, bt->hbackporch, bt->vfrontporch, bt->vsync,
		 bt->vbackporch, bt->interlaced);

	csi->src_timings = *timings;
	if (csi->scaler_en)
		*timings = csi->timings;

	return 0;

}

static int rk628_bt1120_csi_s_ctrl_detect_tx_5v(struct v4l2_subdev *sd)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);

	return v4l2_ctrl_s_ctrl(csi->detect_tx_5v_ctrl,
			tx_5v_power_present(sd));
}

static int rk628_bt1120_csi_update_controls(struct v4l2_subdev *sd)
{
	return rk628_bt1120_csi_s_ctrl_detect_tx_5v(sd);
}

static void rk628_bt1120_csi0_cru_reset(struct v4l2_subdev *sd)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);

	rk628_control_assert(csi->rk628, RGU_CSI);
	udelay(10);
	rk628_control_deassert(csi->rk628, RGU_CSI);
}

static void rk628_bt1120_csi1_cru_reset(struct v4l2_subdev *sd)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);

	rk628_control_assert(csi->rk628, RGU_CSI1);
	udelay(10);
	rk628_control_deassert(csi->rk628, RGU_CSI1);
}

static void rk628_bt1120_mipi_txdata_reset(struct v4l2_subdev *sd)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);

	rk628_control_assert(csi->rk628, RGU_TXDATA);
	rk628_control_assert(csi->rk628, RGU_TXBYTEHS);
	usleep_range(1000, 1100);
	rk628_control_deassert(csi->rk628, RGU_TXDATA);
	rk628_control_deassert(csi->rk628, RGU_TXBYTEHS);
}

static void rk628_bt1120_csi_soft_reset(struct v4l2_subdev *sd)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);

	rk628_i2c_write(csi->rk628, CSITX_SYS_CTRL0_IMD, 0x1);
	if (csi->rk628->version >= RK628F_VERSION)
		rk628_i2c_write(csi->rk628, CSITX1_SYS_CTRL0_IMD, 0x1);

	rk628_bt1120_mipi_txdata_reset(sd);
	rk628_i2c_write(csi->rk628, CSITX_SYS_CTRL0_IMD, 0x0);
	if (csi->rk628->version >= RK628F_VERSION)
		rk628_i2c_write(csi->rk628, CSITX1_SYS_CTRL0_IMD, 0x0);
}

static void enable_csitx(struct v4l2_subdev *sd)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);

	//enable dphy1 and split mode
	rk628_i2c_update_bits(csi->rk628, GRF_SYSTEM_CON3, GRF_DPHY_CH1_EN_MASK,
			     csi->rk628->dual_mipi ? GRF_DPHY_CH1_EN(1) : 0);
	rk628_i2c_update_bits(csi->rk628, GRF_POST_PROC_CON, SW_SPLIT_EN,
			     csi->rk628->dual_mipi ? SW_SPLIT_EN : 0);
	rk628_bt1120_csi_set_csi(sd);

	rk628_bt1120_csi_soft_reset(sd);
	usleep_range(5000, 5500);
	//disabled csi state ints
	rk628_i2c_write(csi->rk628, CSITX_INTR_EN_IMD, 0x0fff0000);
	if (csi->rk628->version >= RK628F_VERSION)
		rk628_i2c_write(csi->rk628, CSITX1_INTR_EN_IMD, 0x0fff0000);

	rk628_i2c_update_bits(csi->rk628, CSITX_CSITX_EN,
					DPHY_EN_MASK |
					CSITX_EN_MASK,
					DPHY_EN(1) |
					CSITX_EN(1));
	rk628_i2c_write(csi->rk628, CSITX_CONFIG_DONE, CONFIG_DONE_IMD);
	if (csi->rk628->version >= RK628F_VERSION) {
		rk628_i2c_update_bits(csi->rk628, CSITX1_CSITX_EN,
					DPHY_EN_MASK |
					CSITX_EN_MASK,
					DPHY_EN(1) |
					CSITX_EN(1));
		rk628_i2c_write(csi->rk628, CSITX1_CONFIG_DONE, CONFIG_DONE_IMD);
	}

	rk628_i2c_write(csi->rk628, CSITX_ERR_INTR_CLR_IMD, 0xffffffff);
	if (csi->rk628->version <= RK628D_VERSION)
		rk628_i2c_update_bits(csi->rk628, CSITX_SYS_CTRL1,
				BYPASS_SELECT_MASK, BYPASS_SELECT(0));
	rk628_i2c_write(csi->rk628, CSITX_CONFIG_DONE, CONFIG_DONE_IMD);

	if (csi->rk628->version >= RK628F_VERSION) {
		rk628_i2c_write(csi->rk628, CSITX1_ERR_INTR_CLR_IMD, 0xffffffff);
		rk628_i2c_write(csi->rk628, CSITX1_CONFIG_DONE, CONFIG_DONE_IMD);
	}
	csi->is_streaming = true;
}

static void rk628_bt1120_csi_disable_stream(struct v4l2_subdev *sd)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);

	rk628_i2c_update_bits(csi->rk628, CSITX_CSITX_EN,
				DPHY_EN_MASK | CSITX_EN_MASK,
				DPHY_EN(0) | CSITX_EN(0));
	rk628_i2c_update_bits(csi->rk628, CSITX_SYS_CTRL3_IMD, CONT_MODE_CLK_CLR_MASK,
			csi->continues_clk ? CONT_MODE_CLK_CLR(1) : CONT_MODE_CLK_CLR(0));
	rk628_i2c_write(csi->rk628, CSITX_CONFIG_DONE, CONFIG_DONE_IMD);

	if (csi->rk628->version >= RK628F_VERSION) {
		rk628_i2c_update_bits(csi->rk628, CSITX1_CSITX_EN,
					DPHY_EN_MASK | CSITX_EN_MASK,
					DPHY_EN(0) | CSITX_EN(0));
		rk628_i2c_update_bits(csi->rk628, CSITX1_SYS_CTRL3_IMD, CONT_MODE_CLK_CLR_MASK,
				csi->continues_clk ? CONT_MODE_CLK_CLR(1) : CONT_MODE_CLK_CLR(0));
		rk628_i2c_write(csi->rk628, CSITX1_CONFIG_DONE, CONFIG_DONE_IMD);
	}
	mipi_dphy_power_off(csi);
	csi->txphy_pwron = false;
	csi->is_streaming = false;
}

static void rk628_bt1120_decoder_timing_cfg(struct v4l2_subdev *sd)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);

	u32 src_hsync_len, src_hback_porch, src_hfront_porch, src_hactive;
	u32 src_vsync_len, src_vback_porch, src_vfront_porch, src_vactive;
	u32 dsp_htotal, dsp_hs_end, dsp_hact_st;
	u32 dsp_vtotal, dsp_vs_end, dsp_vact_st;
	u32 dsp_hbor_st, dsp_vbor_st;
	u16 bor_left = 0, bor_up = 0;

	src_hactive = csi->timings.bt.width;
	src_hsync_len = csi->timings.bt.hsync;
	src_hback_porch = csi->timings.bt.hbackporch;
	src_hfront_porch = csi->timings.bt.hfrontporch;
	src_vsync_len = csi->timings.bt.vsync;
	src_vback_porch = csi->timings.bt.vbackporch;
	src_vfront_porch = csi->timings.bt.vfrontporch;
	src_vactive = csi->timings.bt.height;

	dsp_htotal = src_hsync_len + src_hback_porch +
		     src_hactive + src_hfront_porch;
	dsp_vtotal = src_vsync_len + src_vback_porch +
		     src_vactive + src_vfront_porch;
	dsp_hs_end = src_hsync_len;
	dsp_vs_end = src_vsync_len;
	dsp_hbor_st = src_hsync_len + src_hback_porch;
	dsp_vbor_st = src_vsync_len + src_vback_porch;
	dsp_hact_st = dsp_hbor_st + bor_left;
	dsp_vact_st = dsp_vbor_st + bor_up;

	if (csi->rk628->version == RK628F_VERSION)
		rk628_i2c_update_bits(csi->rk628, GRF_RGB_RX_DBG_MEAS0,
				      RGB_RX_MODET_EN | RGB_RX_DCLK_EN,
				      RGB_RX_MODET_EN | RGB_RX_DCLK_EN);

	rk628_i2c_write(csi->rk628, GRF_BT1120_TIMING_CTRL0, BT1120_DSP_HS_END(dsp_hs_end) |
			BT1120_DSP_HTOTAL(dsp_htotal));
	rk628_i2c_write(csi->rk628, GRF_BT1120_TIMING_CTRL1, BT1120_DSP_HACT_ST(dsp_hact_st));
	rk628_i2c_write(csi->rk628, GRF_BT1120_TIMING_CTRL2, BT1120_DSP_VS_END(dsp_vs_end) |
			BT1120_DSP_VTOTAL(dsp_vtotal));
	rk628_i2c_write(csi->rk628, GRF_BT1120_TIMING_CTRL3, BT1120_DSP_VACT_ST(dsp_vact_st));
}

static void rk628_bt1120_decoder_enable(struct v4l2_subdev *sd)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);
	unsigned long dec_clk_rate;

	// rk628_set_input_bus_format(csi->rk628, BUS_FMT_YUV422);

	/* pinctrl for vop pin */
	rk628_i2c_write(csi->rk628, GRF_GPIO2AB_SEL_CON, 0xffffffff);
	rk628_i2c_write(csi->rk628, GRF_GPIO2C_SEL_CON, 0xffff5555);
	rk628_i2c_write(csi->rk628, GRF_GPIO3AB_SEL_CON, 0x10b010b);

	/* config sw_input_mode bt1120 */
	rk628_i2c_update_bits(csi->rk628, GRF_SYSTEM_CON0, SW_INPUT_MODE_MASK,
			      SW_INPUT_MODE(INPUT_MODE_BT1120));

	if (csi->rk628->version == RK628F_VERSION)
		rk628_bt1120_decoder_timing_cfg(sd);

	/* operation resetn_bt1120dec */
	rk628_i2c_write(csi->rk628, CRU_SOFTRST_CON00, 0x10001000);
	rk628_i2c_write(csi->rk628, CRU_SOFTRST_CON00, 0x10000000);

	//set clk
	rk628_clk_set_rate(csi->rk628, CGU_BT1120DEC, csi->timings.bt.pixelclock);
	dec_clk_rate = rk628_clk_get_rate(csi->rk628, CGU_BT1120DEC);
	if (dec_clk_rate < csi->timings.bt.pixelclock)
		rk628_clk_set_rate(csi->rk628, CGU_BT1120DEC, csi->timings.bt.pixelclock / 1000 * 1020);

	if (csi->bt1120_dual_edge) {
		rk628_i2c_update_bits(csi->rk628, GRF_RGB_DEC_CON0,
				DEC_DUALEDGE_EN, DEC_DUALEDGE_EN);
		rk628_i2c_write(csi->rk628, GRF_BT1120_DCLK_DELAY_CON0, 0x10000000);
		rk628_i2c_write(csi->rk628, GRF_BT1120_DCLK_DELAY_CON1, 0);
	} else {
		if (csi->rk628->version == RK628F_VERSION) {
			rk628_i2c_write(csi->rk628, GRF_BT1120_DCLK_DELAY_CON0,
					0x10000);
			rk628_i2c_write(csi->rk628, GRF_BT1120_DCLK_DELAY_CON1, 0);
		}
	}

	rk628_i2c_update_bits(csi->rk628, GRF_RGB_DEC_CON1, SW_SET_X_MASK,
			      SW_SET_X(csi->timings.bt.width));
	rk628_i2c_update_bits(csi->rk628, GRF_RGB_DEC_CON2, SW_SET_Y_MASK,
			      SW_SET_Y(csi->timings.bt.height));

	rk628_i2c_update_bits(csi->rk628, GRF_SYSTEM_CON0,
			      SW_BT_DATA_OEN_MASK | SW_INPUT_MODE_MASK,
			      SW_BT_DATA_OEN | SW_INPUT_MODE(INPUT_MODE_BT1120));

	rk628_i2c_update_bits(csi->rk628, GRF_RGB_DEC_CON0,
			      SW_CAP_EN_PSYNC | SW_CAP_EN_ASYNC |
			      SW_PROGRESS_EN |
			      SW_BT1120_YC_SWAP |
			      SW_BT1120_UV_SWAP,
			      SW_CAP_EN_PSYNC | SW_CAP_EN_ASYNC |
			      SW_PROGRESS_EN |
			      (csi->bt1120_yc_swap ? SW_BT1120_YC_SWAP : 0) |
			      (csi->bt1120_uv_swap ? SW_BT1120_UV_SWAP : 0));
}

static void rk628_bt1120_rx_enable(struct v4l2_subdev *sd)
{
	rk628_bt1120_decoder_enable(sd);
}

static void enable_stream(struct v4l2_subdev *sd, bool en)
{
	// struct rk628_bt1120_csi *csi = to_csi(sd);

	v4l2_dbg(1, debug, sd, "%s: %sable\n", __func__, en ? "en" : "dis");
	if (en) {
		enable_csitx(sd);
		rk628_bt1120_rx_enable(sd);
	} else {
		rk628_bt1120_csi_disable_stream(sd);
	}
}

static void rk628_post_process_setup(struct v4l2_subdev *sd)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);
	struct v4l2_bt_timings *bt = &csi->src_timings.bt;
	struct v4l2_bt_timings *dst_bt = &csi->timings.bt;
	struct videomode src, dst;
	u64 dst_pclk;

	src.hactive = bt->width;
	src.hfront_porch = bt->hfrontporch;
	src.hsync_len = bt->hsync;
	src.hback_porch = bt->hbackporch;
	src.vactive = bt->height;
	src.vfront_porch = bt->vfrontporch;
	src.vsync_len = bt->vsync;
	src.vback_porch = bt->vbackporch;
	src.pixelclock = bt->pixelclock;
	src.flags = 0;
	if (bt->interlaced == V4L2_DV_INTERLACED)
		src.flags |= DISPLAY_FLAGS_INTERLACED;
	if (!src.pixelclock) {
		enable_stream(sd, false);
		return;
	}

	dst.hactive = dst_bt->width;
	dst.hfront_porch = dst_bt->hfrontporch;
	dst.hsync_len = dst_bt->hsync;
	dst.hback_porch = dst_bt->hbackporch;
	dst.vactive = dst_bt->height;
	dst.vfront_porch = dst_bt->vfrontporch;
	dst.vsync_len = dst_bt->vsync;
	dst.vback_porch = dst_bt->vbackporch;
	dst.pixelclock = dst_bt->pixelclock;

	rk628_post_process_en(csi->rk628, &src, &dst, &dst_pclk);
	dst_bt->pixelclock = dst_pclk;
}

static void rk628_bt1120_csi_set_csi(struct v4l2_subdev *sd)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);
	u8 lanes = csi->csi_lanes_in_use;
	u8 lane_num;
	u32 wc_usrdef;

	lane_num = lanes - 1;
	csi->rk628->dphy_lane_en = (1 << (lanes + 1)) - 1;
	wc_usrdef = csi->timings.bt.width * 2;
	if (csi->rk628->dual_mipi)
		wc_usrdef = csi->timings.bt.width;
	v4l2_info(sd, "%s mipi mode, word count user define: %d\n",
			csi->rk628->dual_mipi ? "dual" : "single", wc_usrdef);
	rk628_bt1120_csi_disable_stream(sd);
	usleep_range(5000, 5500);
	rk628_bt1120_csi0_cru_reset(sd);
	if (csi->rk628->version >= RK628F_VERSION)
		rk628_bt1120_csi1_cru_reset(sd);
	rk628_post_process_setup(sd);

	if (csi->txphy_pwron) {
		v4l2_dbg(1, debug, sd,
			"%s: txphy already power on, power off\n", __func__);
		mipi_dphy_power_off(csi);
		csi->txphy_pwron = false;
	}

	mipi_dphy_power_on(csi);
	csi->txphy_pwron = true;
	v4l2_dbg(2, debug, sd, "%s: txphy power on!\n", __func__);
	usleep_range(1000, 1500);

	if (csi->rk628->version <= RK628D_VERSION) {
		rk628_i2c_update_bits(csi->rk628, CSITX_CSITX_EN,
			VOP_UV_SWAP_MASK |
			VOP_YUV422_EN_MASK |
			VOP_P2_EN_MASK |
			LANE_NUM_MASK |
			DPHY_EN_MASK |
			CSITX_EN_MASK,
			VOP_UV_SWAP(1) |
			VOP_YUV422_EN(1) |
			VOP_P2_EN(1) |
			LANE_NUM(lane_num) |
			DPHY_EN(0) |
			CSITX_EN(0));
		rk628_i2c_update_bits(csi->rk628, CSITX_SYS_CTRL1,
			BYPASS_SELECT_MASK,
			BYPASS_SELECT(1));
	} else {
		rk628_i2c_update_bits(csi->rk628, CSITX_CSITX_EN,
			VOP_UV_SWAP_MASK |
			VOP_YUV422_EN_MASK |
			VOP_YUV422_MODE_MASK |
			VOP_P2_EN_MASK |
			LANE_NUM_MASK |
			DPHY_EN_MASK |
			CSITX_EN_MASK,
			VOP_UV_SWAP(0) |
			VOP_YUV422_EN(1) |
			VOP_YUV422_MODE(2) |
			VOP_P2_EN(1) |
			LANE_NUM(lane_num) |
			DPHY_EN(0) |
			CSITX_EN(0));
		rk628_i2c_update_bits(csi->rk628, CSITX_SYS_CTRL1,
			BYPASS_SELECT_MASK,
			BYPASS_SELECT(0));
	}

	rk628_i2c_write(csi->rk628, CSITX_CONFIG_DONE, CONFIG_DONE_IMD);
	rk628_i2c_write(csi->rk628, CSITX_SYS_CTRL2, VOP_WHOLE_FRM_EN | VSYNC_ENABLE);
	if (csi->continues_clk)
		rk628_i2c_update_bits(csi->rk628, CSITX_SYS_CTRL3_IMD,
			CONT_MODE_CLK_CLR_MASK |
			CONT_MODE_CLK_SET_MASK |
			NON_CONTINUOUS_MODE_MASK,
			CONT_MODE_CLK_CLR(0) |
			CONT_MODE_CLK_SET(1) |
			NON_CONTINUOUS_MODE(0));
	else
		rk628_i2c_update_bits(csi->rk628, CSITX_SYS_CTRL3_IMD,
			CONT_MODE_CLK_CLR_MASK |
			CONT_MODE_CLK_SET_MASK |
			NON_CONTINUOUS_MODE_MASK,
			CONT_MODE_CLK_CLR(0) |
			CONT_MODE_CLK_SET(0) |
			NON_CONTINUOUS_MODE(1));

	rk628_i2c_write(csi->rk628, CSITX_VOP_PATH_CTRL,
			VOP_WC_USERDEFINE(wc_usrdef) |
			VOP_DT_USERDEFINE(YUV422_8BIT) |
			VOP_PIXEL_FORMAT(0) |
			VOP_WC_USERDEFINE_EN(1) |
			VOP_DT_USERDEFINE_EN(1) |
			VOP_PATH_EN(1));
	rk628_i2c_update_bits(csi->rk628, CSITX_DPHY_CTRL,
				CSI_DPHY_EN_MASK,
				CSI_DPHY_EN(csi->rk628->dphy_lane_en));
	rk628_i2c_update_bits(csi->rk628, CSITX_VOP_FILTER_CTRL,
				VOP_FILTER_EN_MASK | VOP_FILTER_MASK,
				VOP_FILTER_EN(1) | VOP_FILTER(3));
	rk628_i2c_write(csi->rk628, CSITX_CONFIG_DONE, CONFIG_DONE_IMD);
	v4l2_dbg(1, debug, sd, "%s csi config done\n", __func__);

	if (csi->rk628->version >= RK628F_VERSION) {
		rk628_i2c_update_bits(csi->rk628, CSITX1_CSITX_EN,
				VOP_UV_SWAP_MASK |
				VOP_YUV422_EN_MASK |
				VOP_YUV422_MODE_MASK |
				VOP_P2_EN_MASK |
				LANE_NUM_MASK |
				DPHY_EN_MASK |
				CSITX_EN_MASK,
				VOP_UV_SWAP(0) |
				VOP_YUV422_EN(1) |
				VOP_YUV422_MODE(2) |
				VOP_P2_EN(1) |
				LANE_NUM(lane_num) |
				DPHY_EN(0) |
				CSITX_EN(0));
		rk628_i2c_update_bits(csi->rk628, CSITX1_SYS_CTRL1,
				BYPASS_SELECT_MASK,
				BYPASS_SELECT(0));
		rk628_i2c_write(csi->rk628, CSITX1_CONFIG_DONE, CONFIG_DONE_IMD);
		rk628_i2c_write(csi->rk628, CSITX1_SYS_CTRL2, VOP_WHOLE_FRM_EN | VSYNC_ENABLE);
		if (csi->continues_clk)
			rk628_i2c_update_bits(csi->rk628, CSITX1_SYS_CTRL3_IMD,
				CONT_MODE_CLK_CLR_MASK |
				CONT_MODE_CLK_SET_MASK |
				NON_CONTINUOUS_MODE_MASK,
				CONT_MODE_CLK_CLR(0) |
				CONT_MODE_CLK_SET(1) |
				NON_CONTINUOUS_MODE(0));
		else
			rk628_i2c_update_bits(csi->rk628, CSITX1_SYS_CTRL3_IMD,
				CONT_MODE_CLK_CLR_MASK |
				CONT_MODE_CLK_SET_MASK |
				NON_CONTINUOUS_MODE_MASK,
				CONT_MODE_CLK_CLR(0) |
				CONT_MODE_CLK_SET(0) |
				NON_CONTINUOUS_MODE(1));

		rk628_i2c_write(csi->rk628, CSITX1_VOP_PATH_CTRL,
				VOP_WC_USERDEFINE(wc_usrdef) |
				VOP_DT_USERDEFINE(YUV422_8BIT) |
				VOP_PIXEL_FORMAT(0) |
				VOP_WC_USERDEFINE_EN(1) |
				VOP_DT_USERDEFINE_EN(1) |
				VOP_PATH_EN(1));
		rk628_i2c_update_bits(csi->rk628, CSITX1_DPHY_CTRL,
					CSI_DPHY_EN_MASK,
					CSI_DPHY_EN(csi->rk628->dphy_lane_en));
		rk628_i2c_update_bits(csi->rk628, CSITX1_VOP_FILTER_CTRL,
				VOP_FILTER_EN_MASK | VOP_FILTER_MASK,
				VOP_FILTER_EN(1) | VOP_FILTER(3));
		rk628_i2c_write(csi->rk628, CSITX1_CONFIG_DONE, CONFIG_DONE_IMD);
		v4l2_dbg(1, debug, sd, "%s csi1 config done\n", __func__);
	}

	if (csi->rk628->version == RK628D_VERSION) {
		/* yuv data: cfg SW_YUV2VYU_SWP */
		rk628_i2c_write(csi->rk628, GRF_CSC_CTRL_CON,
				SW_YUV2VYU_SWP(1) |
				SW_R2Y_EN(0));
	} else {
		rk628_i2c_write(csi->rk628, GRF_CSC_CTRL_CON, SW_YUV2VYU_SWP(1));
		rk628_post_process_csc_en(csi->rk628, true);
	}
}

static void rk628_bt1120_csi_initial(struct v4l2_subdev *sd)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);
	u32 mask = SW_OUTPUT_MODE_MASK;
	u32 val = SW_OUTPUT_MODE(OUTPUT_MODE_CSI);

	udelay(10);
	rk628_control_assert(csi->rk628, RGU_BT1120DEC);
	rk628_control_assert(csi->rk628, RGU_CSI);
	if (csi->rk628->version >= RK628F_VERSION)
		rk628_control_assert(csi->rk628, RGU_CSI1);
	udelay(10);
	rk628_control_deassert(csi->rk628, RGU_BT1120DEC);
	rk628_control_deassert(csi->rk628, RGU_CSI);
	if (csi->rk628->version >= RK628F_VERSION)
		rk628_control_deassert(csi->rk628, RGU_CSI1);
	udelay(10);

	if (csi->rk628->version >= RK628F_VERSION) {
		mask = SW_OUTPUT_COMBTX_MODE_MASK;
		val = SW_OUTPUT_COMBTX_MODE(OUTPUT_MODE_CSI - 1);
	}
	rk628_i2c_update_bits(csi->rk628, GRF_SYSTEM_CON0,
			SW_INPUT_MODE_MASK |
			mask |
			SW_I2S_DATA_OEN_MASK,
			SW_INPUT_MODE(INPUT_MODE_BT1120) |
			val |
			SW_I2S_DATA_OEN(0));
}

static void rk628_bt1120_csi_initial_setup(struct v4l2_subdev *sd)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);

	rk628_bt1120_csi_initial(sd);
	if (csi->rk628->version >= RK628F_VERSION) {
		csi->rk628->mipi_timing[0] = rk628f_csi0_mipi;
		csi->rk628->mipi_timing[1] = rk628f_csi1_mipi;
	} else {
		csi->rk628->mipi_timing[0] = rk628d_csi_mipi;
	}

	if (csi->plat_data->tx_mode == DSI_MODE) {
		csi->rk628->mipi_timing[0] = rk628f_dsi0_mipi;
		csi->rk628->mipi_timing[1] = rk628f_dsi0_mipi;
	}

	csi->rk628->dphy_lane_en = 0x1f;
	csi->txphy_pwron = true;
}

static int rk628_bt1120_csi_format_change(struct v4l2_subdev *sd)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);
	struct v4l2_dv_timings timings;
	const struct v4l2_event rk628_bt1120_csi_ev_fmt = {
		.type = V4L2_EVENT_SOURCE_CHANGE,
		.u.src_change.changes = V4L2_EVENT_SRC_CH_RESOLUTION,
	};
	int ret;

	ret = rk628_bt1120_csi_get_detected_timings(sd, &timings);
	if (ret) {
		v4l2_dbg(1, debug, sd, "%s: get timing fail\n", __func__);
		return false;
	}
	if (!v4l2_match_dv_timings(&csi->timings, &timings, 0, false)) {
		/* automatically set timing rather than set by userspace */
		rk628_bt1120_csi_s_dv_timings(sd, &timings);
		v4l2_print_dv_timings(sd->name,
				"rk628_bt1120_csi_format_change: New format: ",
				&timings, false);
	}

	if (sd->devnode)
		v4l2_subdev_notify_event(sd, &rk628_bt1120_csi_ev_fmt);

	return true;
}

static int rk628_bt1120_csi_subscribe_event(struct v4l2_subdev *sd, struct v4l2_fh *fh,
				    struct v4l2_event_subscription *sub)
{
	switch (sub->type) {
	case V4L2_EVENT_SOURCE_CHANGE:
		return v4l2_src_change_event_subdev_subscribe(sd, fh, sub);
	case V4L2_EVENT_CTRL:
		return v4l2_ctrl_subdev_subscribe_event(sd, fh, sub);
	case RK_HDMIRX_V4L2_EVENT_SIGNAL_LOST:
		return v4l2_event_subscribe(fh, sub, 0, NULL);
	default:
		return -EINVAL;
	}
}

static int rk628_bt1120_csi_s_dv_timings(struct v4l2_subdev *sd,
		struct v4l2_dv_timings *timings)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);

	if (!timings)
		return -EINVAL;

	if (debug)
		v4l2_print_dv_timings(sd->name, "rk628_bt1120_csi_s_dv_timings: ",
				timings, false);

	if (v4l2_match_dv_timings(&csi->timings, timings, 0, false)) {
		v4l2_dbg(1, debug, sd, "%s: no change\n", __func__);
		return 0;
	}

	if (!v4l2_valid_dv_timings(timings, &rk628_bt1120_csi_timings_cap, NULL,
				NULL)) {
		v4l2_dbg(1, debug, sd, "%s: timings out of range\n", __func__);
		return -ERANGE;
	}

	csi->timings = *timings;
	enable_stream(sd, false);

	return 0;
}

static int rk628_bt1120_csi_g_dv_timings(struct v4l2_subdev *sd,
		struct v4l2_dv_timings *timings)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);

	*timings = csi->timings;

	return 0;
}

static int rk628_bt1120_csi_enum_dv_timings(struct v4l2_subdev *sd,
		struct v4l2_enum_dv_timings *timings)
{
	if (timings->pad != 0)
		return -EINVAL;

	return v4l2_enum_dv_timings_cap(timings, &rk628_bt1120_csi_timings_cap, NULL,
			NULL);
}

static int rk628_bt1120_csi_query_dv_timings(struct v4l2_subdev *sd,
		struct v4l2_dv_timings *timings)
{
	int ret;
	struct rk628_bt1120_csi *csi = to_csi(sd);

	mutex_lock(&csi->confctl_mutex);
	ret = rk628_bt1120_csi_get_detected_timings(sd, timings);
	mutex_unlock(&csi->confctl_mutex);
	if (ret)
		return ret;

	if (debug)
		v4l2_print_dv_timings(sd->name, "rk628_bt1120_csi_query_dv_timings: ",
				timings, false);

	if (!v4l2_valid_dv_timings(timings, &rk628_bt1120_csi_timings_cap, NULL,
				NULL)) {
		v4l2_dbg(1, debug, sd, "%s: timings out of range\n", __func__);
		return -ERANGE;
	}

	return 0;
}

static int rk628_bt1120_csi_dv_timings_cap(struct v4l2_subdev *sd,
		struct v4l2_dv_timings_cap *cap)
{
	if (cap->pad != 0)
		return -EINVAL;

	*cap = rk628_bt1120_csi_timings_cap;

	return 0;
}

static int rk628_bt1120_csi_g_mbus_config(struct v4l2_subdev *sd, unsigned int pad,
			     struct v4l2_mbus_config *cfg)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);

	cfg->type = V4L2_MBUS_CSI2_DPHY;
	cfg->bus.mipi_csi2.num_data_lanes = csi->csi_lanes_in_use;

	return 0;
}

static inline unsigned int fps_calc(const struct v4l2_bt_timings *t)
{
	if (!V4L2_DV_BT_FRAME_HEIGHT(t) || !V4L2_DV_BT_FRAME_WIDTH(t))
		return 0;

	return DIV_ROUND_CLOSEST((unsigned int)t->pixelclock,
			V4L2_DV_BT_FRAME_HEIGHT(t) * V4L2_DV_BT_FRAME_WIDTH(t));
}

static int rk628_bt1120_csi_s_stream(struct v4l2_subdev *sd, int enable)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);

	enable_stream(sd, enable);

	v4l2_info(sd, "%s: on: %d, %dx%d@%d\n", __func__, enable,
				csi->timings.bt.width,
				csi->timings.bt.height,
				fps_calc(&csi->timings.bt));

	return 0;
}

static int rk628_bt1120_csi_enum_mbus_code(struct v4l2_subdev *sd,
		struct v4l2_subdev_state *sd_state,
		struct v4l2_subdev_mbus_code_enum *code)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);

	switch (code->index) {
	case 0:
		code->code = csi->plat_data->bus_fmt;
		break;

	default:
		return -EINVAL;
	}

	return 0;
}

static int rk628_bt1120_csi_enum_frame_sizes(struct v4l2_subdev *sd,
				   struct v4l2_subdev_state *sd_state,
				   struct v4l2_subdev_frame_size_enum *fse)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);

	if (fse->index >= ARRAY_SIZE(supported_modes))
		return -EINVAL;

	if (fse->code != csi->plat_data->bus_fmt)
		return -EINVAL;

	fse->min_width  = supported_modes[fse->index].width;
	fse->max_width  = supported_modes[fse->index].width;
	fse->max_height = supported_modes[fse->index].height;
	fse->min_height = supported_modes[fse->index].height;

	return 0;
}

static int rk628_bt1120_csi_enum_frame_interval(struct v4l2_subdev *sd,
		struct v4l2_subdev_state *sd_state,
		struct v4l2_subdev_frame_interval_enum *fie)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);

	if (fie->index >= ARRAY_SIZE(supported_modes))
		return -EINVAL;

	fie->code = csi->plat_data->bus_fmt;

	fie->width = supported_modes[fie->index].width;
	fie->height = supported_modes[fie->index].height;
	fie->interval = supported_modes[fie->index].max_fps;
	return 0;
}

static int rk628_bt1120_csi_get_fmt(struct v4l2_subdev *sd,
		struct v4l2_subdev_state *sd_state,
		struct v4l2_subdev_format *format)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);

	mutex_lock(&csi->confctl_mutex);
	format->format.code = csi->mbus_fmt_code;
	format->format.width = ALIGN_DOWN(csi->timings.bt.width, 8);
	format->format.height = csi->timings.bt.height;
	format->format.field = csi->timings.bt.interlaced ?
		V4L2_FIELD_INTERLACED : V4L2_FIELD_NONE;

	if (csi->timings.bt.pixelclock > 150000000 || csi->csi_lanes_in_use <= 2) {
		v4l2_dbg(1, debug, sd,
			"%s res wxh:%dx%d, link freq:%llu, pixrate:%u\n",
			__func__, csi->timings.bt.width, csi->timings.bt.height,
			link_freq_menu_items[1], RK628_CSI_PIXEL_RATE_HIGH);
		__v4l2_ctrl_s_ctrl(csi->link_freq, 1);
		__v4l2_ctrl_s_ctrl_int64(csi->pixel_rate,
				RK628_CSI_PIXEL_RATE_HIGH);
	} else {
		v4l2_dbg(1, debug, sd,
			"%s res wxh:%dx%d, link freq:%llu, pixrate:%u\n",
			__func__, csi->timings.bt.width, csi->timings.bt.height,
			link_freq_menu_items[0], RK628_CSI_PIXEL_RATE_LOW);
		__v4l2_ctrl_s_ctrl(csi->link_freq, 0);
		__v4l2_ctrl_s_ctrl_int64(csi->pixel_rate,
				RK628_CSI_PIXEL_RATE_LOW);
	}

	mutex_unlock(&csi->confctl_mutex);
	v4l2_dbg(1, debug, sd, "%s: fmt code:%d, w:%d, h:%d, field code:%d\n",
			__func__, format->format.code, format->format.width,
			format->format.height, format->format.field);

	return 0;
}

static int rk628_bt1120_csi_get_reso_dist(const struct rk628_bt1120_csi_mode *mode,
		struct v4l2_mbus_framefmt *framefmt)
{
	return abs(mode->width - framefmt->width) +
	       abs(mode->height - framefmt->height);
}

static const struct rk628_bt1120_csi_mode *
rk628_bt1120_csi_find_best_fit(struct v4l2_subdev_format *fmt)
{
	struct v4l2_mbus_framefmt *framefmt = &fmt->format;
	int dist;
	int cur_best_fit = 0;
	int cur_best_fit_dist = -1;
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(supported_modes); i++) {
		dist = rk628_bt1120_csi_get_reso_dist(&supported_modes[i], framefmt);
		if (cur_best_fit_dist == -1 || dist < cur_best_fit_dist) {
			cur_best_fit_dist = dist;
			cur_best_fit = i;
		}
	}

	return &supported_modes[cur_best_fit];
}

static int rk628_bt1120_csi_set_fmt(struct v4l2_subdev *sd,
		struct v4l2_subdev_state *sd_state,
		struct v4l2_subdev_format *format)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);
	const struct rk628_bt1120_csi_mode *mode;

	u32 code = format->format.code; /* is overwritten by get_fmt */
	int ret = rk628_bt1120_csi_get_fmt(sd, sd_state, format);

	format->format.code = code;

	if (ret)
		return ret;

	switch (code) {
	case MEDIA_BUS_FMT_UYVY8_2X8:
		if (csi->plat_data->bus_fmt == MEDIA_BUS_FMT_UYVY8_2X8)
			break;
		return -EINVAL;
	case MEDIA_BUS_FMT_RGB888_1X24:
		if (csi->plat_data->bus_fmt == MEDIA_BUS_FMT_RGB888_1X24)
			break;
		return -EINVAL;
	default:
		return -EINVAL;
	}

	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
		if (csi->plat_data->bus_fmt == MEDIA_BUS_FMT_UYVY8_2X8)
			return 0;

		*v4l2_subdev_get_try_format(sd, sd_state, format->pad) = format->format;
	}

	csi->mbus_fmt_code = format->format.code;
	mode = rk628_bt1120_csi_find_best_fit(format);
	csi->cur_mode = mode;

	enable_stream(sd, false);

	return 0;
}

static int rk628_bt1120_csi_g_frame_interval(struct v4l2_subdev *sd,
				    struct v4l2_subdev_frame_interval *fi)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);
	const struct rk628_bt1120_csi_mode *mode = csi->cur_mode;

	fi->interval = mode->max_fps;

	return 0;
}

static void rk628_bt1120_csi_get_module_inf(struct rk628_bt1120_csi *rk628_bt1120_csi,
				  struct rkmodule_inf *inf)
{
	memset(inf, 0, sizeof(*inf));
	strscpy(inf->base.sensor, RK628_BT1120_CSI_NAME, sizeof(inf->base.sensor));
	strscpy(inf->base.module, rk628_bt1120_csi->module_name,
		sizeof(inf->base.module));
	strscpy(inf->base.lens, rk628_bt1120_csi->len_name, sizeof(inf->base.lens));
}

static void rk628_delayed_work_res_change(struct work_struct *work)
{
	struct delayed_work *dwork = to_delayed_work(work);
	struct rk628_bt1120_csi *csi = container_of(dwork, struct rk628_bt1120_csi,
			delayed_work_res_change);
	struct v4l2_subdev *sd = &csi->sd;

	rk628_bt1120_csi_format_change(sd);
}

static long rk628_bt1120_csi_ioctl(struct v4l2_subdev *sd, unsigned int cmd, void *arg)
{
	struct rk628_bt1120_csi *csi = to_csi(sd);
	long ret = 0;
	struct rkmodule_csi_dphy_param *dphy_param;

	switch (cmd) {
	case RKMODULE_GET_MODULE_INFO:
		rk628_bt1120_csi_get_module_inf(csi, (struct rkmodule_inf *)arg);
		break;
	case RKMODULE_GET_HDMI_MODE:
		*(int *)arg = RKMODULE_HDMIIN_MODE;
		break;
	case RKMODULE_SET_CSI_DPHY_PARAM:
		dphy_param = (struct rkmodule_csi_dphy_param *)arg;
		if (dphy_param->vendor == PHY_VENDOR_SAMSUNG)
			rk3588_dcphy_param = *dphy_param;
		v4l2_dbg(1, debug, sd,
			"sensor set dphy param\n");
		break;
	case RKMODULE_GET_CSI_DPHY_PARAM:
		dphy_param = (struct rkmodule_csi_dphy_param *)arg;
		*dphy_param = rk3588_dcphy_param;

		v4l2_dbg(1, debug, sd,
			"sensor get dphy param\n");
		break;
	case RKMODULE_GET_CSI_DSI_INFO:
			*(int *)arg = RKMODULE_CSI_INPUT;
		break;
	case RK_HDMIRX_CMD_GET_FPS:
		*(int *)arg = fps_calc(&csi->timings.bt);
		break;
	case RKMODULE_GET_DSI_MODE:
		*(int *)arg = csi->dsi.vid_mode;
		break;
	default:
		ret = -ENOIOCTLCMD;
		break;
	}

	return ret;
}

static int mipi_dphy_power_on(struct rk628_bt1120_csi *csi)
{
	unsigned int val;
	u32 bus_width, mask;
	struct v4l2_subdev *sd = &csi->sd;
	int ret;

	if (csi->timings.bt.pixelclock > 150000000 || csi->csi_lanes_in_use <= 2) {
		csi->lane_mbps = MIPI_DATARATE_MBPS_HIGH;
	} else {
		csi->lane_mbps = MIPI_DATARATE_MBPS_LOW;
	}
	if (csi->rk628->dual_mipi)
		csi->lane_mbps = MIPI_DATARATE_MBPS_HIGH;
	bus_width =  csi->lane_mbps << 8;
	bus_width |= COMBTXPHY_MODULEA_EN;
	if (csi->rk628->version >= RK628F_VERSION)
		bus_width |= COMBTXPHY_MODULEB_EN;
	v4l2_dbg(1, debug, sd, "%s mipi bitrate:%llu mbps\n", __func__,
			csi->lane_mbps);
	rk628_txphy_set_bus_width(csi->rk628, bus_width);
	rk628_txphy_set_mode(csi->rk628, PHY_MODE_VIDEO_MIPI);

	rk628_mipi_dphy_reset_assert(csi->rk628);
	rk628_mipi_dphy_init_hsfreqrange(csi->rk628, csi->lane_mbps, 0);
	if (csi->rk628->version >= RK628F_VERSION)
		rk628_mipi_dphy_init_hsfreqrange(csi->rk628, csi->lane_mbps, 1);

	if (csi->rk628->dual_mipi) {
		rk628_mipi_dphy_init_hsmanual(csi->rk628, true, 0);
		rk628_mipi_dphy_init_hsmanual(csi->rk628, true, 1);
	} else if (csi->lane_mbps == MIPI_DATARATE_MBPS_HIGH && !csi->rk628->dual_mipi) {
		rk628_mipi_dphy_init_hsmanual(csi->rk628, true, 0);
		if (csi->rk628->version >= RK628F_VERSION)
			rk628_mipi_dphy_init_hsmanual(csi->rk628, false, 1);
	} else {
		rk628_mipi_dphy_init_hsmanual(csi->rk628, false, 0);
		if (csi->rk628->version >= RK628F_VERSION)
			rk628_mipi_dphy_init_hsmanual(csi->rk628, false, 1);
	}
	rk628_mipi_dphy_reset_deassert(csi->rk628);
	usleep_range(1500, 2000);
	rk628_txphy_power_on(csi->rk628);

	usleep_range(1500, 2000);
	mask = DPHY_PLL_LOCK;
	rk628_i2c_read(csi->rk628, CSITX_CSITX_STATUS1, &val);
	if ((val & mask) != mask) {
		dev_err(csi->dev, "PHY is not locked\n");
		return -1;
	}
	if (csi->rk628->version >= RK628F_VERSION) {
		rk628_i2c_read(csi->rk628, CSITX1_CSITX_STATUS1, &val);
		if ((val & mask) != mask) {
			dev_err(csi->dev, "PHY1 is not locked\n");
			return -1;
		}
	}
	udelay(10);

	mask = STOPSTATE_CLK | STOPSTATE_LANE0;
	ret = regmap_read_poll_timeout(csi->rk628->regmap[RK628_DEV_CSI],
				       CSITX_CSITX_STATUS1,
				       val, (val & mask) == mask,
				       0, 1000);
	if (ret < 0)
		dev_err(csi->rk628->dev, "csi0 lane module is not in stop state, val: 0x%x\n", val);

	if (csi->rk628->version >= RK628F_VERSION) {
		ret = regmap_read_poll_timeout(csi->rk628->regmap[RK628_DEV_CSI1],
				       CSITX1_CSITX_STATUS1,
				       val, (val & mask) == mask,
				       0, 1000);
		if (ret < 0)
			dev_err(csi->rk628->dev,
				"csi1 lane module is not in stop state, val: 0x%x\n", val);
	}

	return 0;
}

static void mipi_dphy_power_off(struct rk628_bt1120_csi *csi)
{
	rk628_txphy_power_off(csi->rk628);
}

#ifdef CONFIG_COMPAT
static long rk628_bt1120_csi_compat_ioctl32(struct v4l2_subdev *sd,
				  unsigned int cmd, unsigned long arg)
{
	void __user *up = compat_ptr(arg);
	struct rkmodule_inf *inf;
	long ret;
	int *seq;
	struct rkmodule_csi_dphy_param *dphy_param;

	switch (cmd) {
	case RKMODULE_GET_MODULE_INFO:
		inf = kzalloc(sizeof(*inf), GFP_KERNEL);
		if (!inf) {
			ret = -ENOMEM;
			return ret;
		}

		ret = rk628_bt1120_csi_ioctl(sd, cmd, inf);
		if (!ret) {
			ret = copy_to_user(up, inf, sizeof(*inf));
			if (ret)
				ret = -EFAULT;
		}
		kfree(inf);
		break;
	case RKMODULE_GET_HDMI_MODE:
		seq = kzalloc(sizeof(*seq), GFP_KERNEL);
		if (!seq) {
			ret = -ENOMEM;
			return ret;
		}

		ret = rk628_bt1120_csi_ioctl(sd, cmd, seq);
		if (!ret) {
			ret = copy_to_user(up, seq, sizeof(*seq));
			if (ret)
				ret = -EFAULT;
		}
		kfree(seq);
		break;
	case RKMODULE_SET_CSI_DPHY_PARAM:
		dphy_param = kzalloc(sizeof(*dphy_param), GFP_KERNEL);
		if (!dphy_param) {
			ret = -ENOMEM;
			return ret;
		}

		ret = copy_from_user(dphy_param, up, sizeof(*dphy_param));
		if (!ret)
			ret = rk628_bt1120_csi_ioctl(sd, cmd, dphy_param);
		else
			ret = -EFAULT;
		kfree(dphy_param);
		break;
	case RKMODULE_GET_CSI_DPHY_PARAM:
		dphy_param = kzalloc(sizeof(*dphy_param), GFP_KERNEL);
		if (!dphy_param) {
			ret = -ENOMEM;
			return ret;
		}

		ret = rk628_bt1120_csi_ioctl(sd, cmd, dphy_param);
		if (!ret) {
			ret = copy_to_user(up, dphy_param, sizeof(*dphy_param));
			if (ret)
				ret = -EFAULT;
		}
		kfree(dphy_param);
		break;
	case RKMODULE_GET_CSI_DSI_INFO:
		seq = kzalloc(sizeof(*seq), GFP_KERNEL);
		if (!seq) {
			ret = -ENOMEM;
			return ret;
		}
		ret = rk628_bt1120_csi_ioctl(sd, cmd, seq);
		if (!ret) {
			ret = copy_to_user(up, seq, sizeof(*seq));
			if (ret)
				ret = -EFAULT;
		}
		kfree(seq);
		break;
	case RK_HDMIRX_CMD_GET_FPS:
		seq = kzalloc(sizeof(*seq), GFP_KERNEL);
		if (!seq) {
			ret = -ENOMEM;
			return ret;
		}
		ret = rk628_bt1120_csi_ioctl(sd, cmd, seq);
		if (!ret) {
			ret = copy_to_user(up, seq, sizeof(*seq));
			if (ret)
				ret = -EFAULT;
		}
		kfree(seq);
		break;
	case RKMODULE_GET_DSI_MODE:
		seq = kzalloc(sizeof(*seq), GFP_KERNEL);
		if (!seq) {
			ret = -ENOMEM;
			return ret;
		}
		ret = rk628_bt1120_csi_ioctl(sd, cmd, seq);
		if (!ret) {
			ret = copy_to_user(up, seq, sizeof(*seq));
			if (ret)
				ret = -EFAULT;
		}
		kfree(seq);
		break;
	default:
		ret = -ENOIOCTLCMD;
		break;
	}

	return ret;
}
#endif

static const struct v4l2_subdev_core_ops rk628_bt1120_csi_core_ops = {
	.subscribe_event = rk628_bt1120_csi_subscribe_event,
	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
	.ioctl = rk628_bt1120_csi_ioctl,
#ifdef CONFIG_COMPAT
	.compat_ioctl32 = rk628_bt1120_csi_compat_ioctl32,
#endif
};

static const struct v4l2_subdev_video_ops rk628_bt1120_csi_video_ops = {
	.s_dv_timings = rk628_bt1120_csi_s_dv_timings,
	.g_dv_timings = rk628_bt1120_csi_g_dv_timings,
	.query_dv_timings = rk628_bt1120_csi_query_dv_timings,
	.s_stream = rk628_bt1120_csi_s_stream,
	.g_frame_interval = rk628_bt1120_csi_g_frame_interval,
};

static const struct v4l2_subdev_pad_ops rk628_bt1120_csi_pad_ops = {
	.enum_mbus_code = rk628_bt1120_csi_enum_mbus_code,
	.enum_frame_size = rk628_bt1120_csi_enum_frame_sizes,
	.enum_frame_interval = rk628_bt1120_csi_enum_frame_interval,
	.set_fmt = rk628_bt1120_csi_set_fmt,
	.get_fmt = rk628_bt1120_csi_get_fmt,
	.enum_dv_timings = rk628_bt1120_csi_enum_dv_timings,
	.dv_timings_cap = rk628_bt1120_csi_dv_timings_cap,
	.get_mbus_config = rk628_bt1120_csi_g_mbus_config,
};

static const struct v4l2_subdev_ops rk628_bt1120_csi_ops = {
	.core = &rk628_bt1120_csi_core_ops,
	.video = &rk628_bt1120_csi_video_ops,
	.pad = &rk628_bt1120_csi_pad_ops,
};

static int rk628_bt1120_csi_power_on(struct rk628_bt1120_csi *csi)
{
	clk_prepare_enable(csi->soc_24M);
	if (csi->enable_gpio) {
		gpiod_set_value(csi->enable_gpio, 1);
		usleep_range(10000, 11000);
	}
	gpiod_set_value(csi->reset_gpio, 0);
	usleep_range(10000, 11000);
	gpiod_set_value(csi->reset_gpio, 1);
	usleep_range(10000, 11000);
	gpiod_set_value(csi->reset_gpio, 0);
	usleep_range(10000, 11000);

	if (csi->power_gpio) {
		gpiod_set_value(csi->power_gpio, 1);
		usleep_range(10000, 11000);
	}

	return 0;
}

static int rk628_bt1120_csi_power_off(struct rk628_bt1120_csi *csi)
{
	if (csi->enable_gpio) {
		gpiod_set_value(csi->enable_gpio, 0);
		usleep_range(10000, 11000);
	}
	gpiod_set_value(csi->reset_gpio, 1);
	usleep_range(10000, 11000);
	gpiod_set_value(csi->reset_gpio, 0);
	usleep_range(10000, 11000);
	gpiod_set_value(csi->reset_gpio, 1);
	usleep_range(10000, 11000);

	if (csi->power_gpio) {
		gpiod_set_value(csi->power_gpio, 0);
		usleep_range(10000, 11000);
	}
	clk_disable_unprepare(csi->soc_24M);

	return 0;
}

static int rk628_bt1120_csi_probe_of(struct rk628_bt1120_csi *csi)
{
	struct device *dev = csi->dev;
	struct v4l2_fwnode_endpoint endpoint = { .bus_type = 0 };
	struct device_node *ep;
	int ret = -EINVAL;
	bool scaler_en = false;
	bool continues_clk = false;

	csi->soc_24M = devm_clk_get(dev, "soc_24M");
	if (csi->soc_24M == ERR_PTR(-ENOENT))
		csi->soc_24M = NULL;
	if (IS_ERR(csi->soc_24M)) {
		ret = PTR_ERR(csi->soc_24M);
		dev_err(dev, "Unable to get soc_24M: %d\n", ret);
	}

	csi->enable_gpio = devm_gpiod_get_optional(dev, "enable",
						     GPIOD_OUT_LOW);
	if (IS_ERR(csi->enable_gpio)) {
		ret = PTR_ERR(csi->enable_gpio);
		dev_err(dev, "failed to request enable GPIO: %d\n", ret);
		return ret;
	}

	csi->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
	if (IS_ERR(csi->reset_gpio)) {
		ret = PTR_ERR(csi->reset_gpio);
		dev_err(dev, "failed to request reset GPIO: %d\n", ret);
		return ret;
	}

	csi->power_gpio = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_HIGH);
	if (IS_ERR(csi->power_gpio)) {
		dev_err(dev, "failed to get power gpio\n");
		ret = PTR_ERR(csi->power_gpio);
		return ret;
	}

	if (of_property_read_bool(dev->of_node, "scaler-en"))
		scaler_en = true;

	if (of_property_read_bool(dev->of_node, "continues-clk"))
		continues_clk = true;

	if (of_property_read_bool(dev->of_node, "bt1120-dual-edge"))
		csi->bt1120_dual_edge = true;

	if (of_property_read_bool(dev->of_node, "bt1120-yc-swap"))
		csi->bt1120_yc_swap = true;

	if (of_property_read_bool(dev->of_node, "bt1120-uv-swap"))
		csi->bt1120_uv_swap = true;

	ep = of_graph_get_next_endpoint(dev->of_node, NULL);
	if (!ep) {
		dev_err(dev, "missing endpoint node\n");
		ret = -EINVAL;
		return ret;
	}

	ret = v4l2_fwnode_endpoint_alloc_parse(of_fwnode_handle(ep), &endpoint);
	if (ret) {
		dev_err(dev, "failed to parse endpoint\n");
		goto put_node;
	}

	if (endpoint.bus_type != V4L2_MBUS_CSI2_DPHY ||
	    endpoint.bus.mipi_csi2.num_data_lanes == 0) {
		dev_err(dev, "missing CSI-2 properties in endpoint\n");
		goto free_endpoint;
	}

	csi->csi_lanes_in_use = endpoint.bus.mipi_csi2.num_data_lanes;
	csi->scaler_en = scaler_en;
	if (csi->scaler_en)
		csi->timings = dst_timing;
	csi->continues_clk = continues_clk;

	csi->rxphy_pwron = false;
	csi->txphy_pwron = false;

	ret = 0;

free_endpoint:
	v4l2_fwnode_endpoint_free(&endpoint);
put_node:
	of_node_put(ep);

	return ret;
}

static const struct rk628_plat_data rk628_bt1120_csi_data = {
	.bus_fmt = MEDIA_BUS_FMT_UYVY8_2X8,
	.tx_mode = CSI_MODE,
	.rx_mode = BT1120_MODE,
};

static const struct i2c_device_id rk628_bt1120_csi_i2c_id[] = {
	{ "rk628-bt1120-csi", 0 },
	{ }
};

MODULE_DEVICE_TABLE(i2c, rk628_bt1120_csi_i2c_id);

static const struct of_device_id rk628_bt1120_csi_of_match[] = {
	{ .compatible = "rockchip,rk628-bt1120-csi", .data = &rk628_bt1120_csi_data },
	{}
};
MODULE_DEVICE_TABLE(of, rk628_bt1120_csi_of_match);

static int rk628_bt1120_csi_probe(struct i2c_client *client,
			  const struct i2c_device_id *id)
{
	struct rk628_bt1120_csi *csi;
	struct v4l2_subdev *sd;
	struct device *dev = &client->dev;
	struct device_node *node = dev->of_node;
	char facing[2];
	int err;
	u32 val;
	struct rk628 *rk628;
	const struct of_device_id *match;
	struct v4l2_dv_timings default_timing =
				V4L2_DV_BT_CEA_1920X1080P60;

	dev_info(dev, "RK628 I2C driver version: %02x.%02x.%02x",
		DRIVER_VERSION >> 16,
		(DRIVER_VERSION & 0xff00) >> 8,
		DRIVER_VERSION & 0x00ff);

	if (!of_device_is_available(dev->of_node))
		return -ENODEV;

	csi = devm_kzalloc(dev, sizeof(*csi), GFP_KERNEL);
	if (!csi)
		return -ENOMEM;

	csi->dev = dev;
	csi->i2c_client = client;
	rk628 = rk628_i2c_register(client);
	if (!rk628)
		return -ENOMEM;

	match = of_match_node(rk628_bt1120_csi_of_match, dev->of_node);
	csi->plat_data = match->data;

	rk628->tx_mode = csi->plat_data->tx_mode;
	rk628->rx_mode = csi->plat_data->rx_mode;
	csi->rk628 = rk628;
	csi->dsi.rk628 = rk628;
	csi->cur_mode = &supported_modes[0];
	csi->timings = default_timing;
	sd = &csi->sd;
	sd->dev = dev;

	err = of_property_read_u32(node, RKMODULE_CAMERA_MODULE_INDEX,
				   &csi->module_index);
	err |= of_property_read_string(node, RKMODULE_CAMERA_MODULE_FACING,
				       &csi->module_facing);
	err |= of_property_read_string(node, RKMODULE_CAMERA_MODULE_NAME,
				       &csi->module_name);
	err |= of_property_read_string(node, RKMODULE_CAMERA_LENS_NAME,
				       &csi->len_name);
	if (err) {
		dev_err(dev, "could not get module information!\n");
		return -EINVAL;
	}

	err = rk628_bt1120_csi_probe_of(csi);
	if (err) {
		v4l2_err(sd, "rk628_bt1120_csi_probe_of failed! err:%d\n", err);
		return err;
	}

	rk628_bt1120_csi_power_on(csi);
	rk628_cru_initialize(csi->rk628);

	rk628_version_parse(rk628);
	if (rk628->version == RK628_UNKNOWN) {
		v4l2_err(sd, "can't get rk628 version\n");
		err = -ENODEV;
		goto power_off;
	}
	rk628_clk_set_rate(rk628, CGU_CLK_CPLL, CPLL_REF_CLK);

	v4l2_i2c_subdev_init(sd, client, &rk628_bt1120_csi_ops);
	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;

	/* i2c access, read chip id*/
	err = rk628_i2c_read(csi->rk628, CSITX_CSITX_VERSION, &val);
	if (err) {
		v4l2_err(sd, "i2c access failed! err:%d\n", err);
		err = -ENODEV;
		goto power_off;
	}
	v4l2_dbg(1, debug, sd, "CSITX VERSION: %#x\n", val);

	if (rk628->version >= RK628F_VERSION) {
		err = rk628_i2c_read(csi->rk628, CSITX1_CSITX_VERSION, &val);
		if (err) {
			v4l2_err(sd, "i2c access failed! err:%d\n", err);
			err = -ENODEV;
			goto power_off;
		}
		v4l2_dbg(1, debug, sd, "CSITX1 VERSION: %#x\n", val);
	}

	mutex_init(&csi->confctl_mutex);

	csi->txphy = rk628_txphy_register(rk628);
	if (!csi->txphy) {
		v4l2_err(sd, "register txphy failed\n");
		err = -ENOMEM;
		goto power_off;
	}

	/* control handlers */
	v4l2_ctrl_handler_init(&csi->hdl, 4);
	csi->link_freq = v4l2_ctrl_new_int_menu(&csi->hdl, NULL,
			V4L2_CID_LINK_FREQ,
			ARRAY_SIZE(link_freq_menu_items) - 1,
			0, link_freq_menu_items);
	csi->pixel_rate = v4l2_ctrl_new_std(&csi->hdl, NULL,
			V4L2_CID_PIXEL_RATE, 0, RK628_CSI_PIXEL_RATE_HIGH, 1,
			RK628_CSI_PIXEL_RATE_HIGH);
	csi->detect_tx_5v_ctrl = v4l2_ctrl_new_std(&csi->hdl,
			NULL, V4L2_CID_DV_RX_POWER_PRESENT,
			0, 1, 0, 0);

	sd->ctrl_handler = &csi->hdl;
	if (csi->hdl.error) {
		err = csi->hdl.error;
		v4l2_err(sd, "cfg v4l2 ctrls failed! err:%d\n", err);
		goto err_hdl;
	}

	if (rk628_bt1120_csi_update_controls(sd)) {
		err = -ENODEV;
		v4l2_err(sd, "update v4l2 ctrls failed! err:%d\n", err);
		goto err_hdl;
	}

	csi->pad.flags = MEDIA_PAD_FL_SOURCE;
	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
	err = media_entity_pads_init(&sd->entity, 1, &csi->pad);
	if (err < 0) {
		v4l2_err(sd, "media entity init failed! err:%d\n", err);
		goto err_hdl;
	}

	if (csi->plat_data->tx_mode == CSI_MODE)
		csi->mbus_fmt_code = MEDIA_BUS_FMT_UYVY8_2X8;

	memset(facing, 0, sizeof(facing));
	if (strcmp(csi->module_facing, "back") == 0)
		facing[0] = 'b';
	else
		facing[0] = 'f';

	snprintf(sd->name, sizeof(sd->name), "m%02d_%s_%s %s",
		 csi->module_index, facing,
		 RK628_BT1120_CSI_NAME, dev_name(sd->dev));
	err = v4l2_async_register_subdev(sd);
	if (err < 0) {
		v4l2_err(sd, "v4l2 register subdev failed! err:%d\n", err);
		goto err_hdl;
	}

	INIT_DELAYED_WORK(&csi->delayed_work_res_change,
			rk628_delayed_work_res_change);

	rk628_bt1120_csi_initial_setup(sd);

	err = v4l2_ctrl_handler_setup(sd->ctrl_handler);
	if (err) {
		v4l2_err(sd, "v4l2 ctrl handler setup failed! err:%d\n", err);
		goto err_work_queues;
	}
	csi->rk628->dual_mipi = false;
	rk628_debugfs_create(csi->rk628);
	schedule_delayed_work(&csi->delayed_work_res_change, msecs_to_jiffies(100));
	v4l2_info(sd, "%s found @ 0x%x (%s)\n", client->name,
		  client->addr << 1, client->adapter->name);

	return 0;

err_work_queues:
	cancel_delayed_work(&csi->delayed_work_res_change);
err_hdl:
	mutex_destroy(&csi->confctl_mutex);
	media_entity_cleanup(&sd->entity);
	v4l2_ctrl_handler_free(&csi->hdl);
power_off:
	rk628_bt1120_csi_power_off(csi);

	return err;
}

#if KERNEL_VERSION(6, 1, 0) <= LINUX_VERSION_CODE
static void rk628_bt1120_csi_remove(struct i2c_client *client)
#else
static int rk628_bt1120_csi_remove(struct i2c_client *client)
#endif
{
	struct rk628_bt1120_csi *csi = i2c_get_clientdata(client);

	debugfs_remove_recursive(csi->rk628->debug_dir);

	cancel_delayed_work_sync(&csi->delayed_work_res_change);

	if (csi->rxphy_pwron)
		rk628_rxphy_power_off(csi->rk628);
	if (csi->txphy_pwron)
		mipi_dphy_power_off(csi);

	mutex_destroy(&csi->confctl_mutex);

	rk628_control_assert(csi->rk628, RGU_BT1120DEC);
	rk628_control_assert(csi->rk628, RGU_DECODER);
	rk628_control_assert(csi->rk628, RGU_CLK_RX);
	rk628_control_assert(csi->rk628, RGU_VOP);
	rk628_control_assert(csi->rk628, RGU_CSI);
	if (csi->rk628->version >= RK628F_VERSION)
		rk628_control_assert(csi->rk628, RGU_CSI1);
	rk628_bt1120_csi_power_off(csi);
#if KERNEL_VERSION(6, 1, 0) > LINUX_VERSION_CODE
	return 0;
#endif
}

static struct i2c_driver rk628_bt1120_csi_i2c_driver = {
	.driver = {
		.name = "rk628-bt1120-csi",
		.of_match_table = of_match_ptr(rk628_bt1120_csi_of_match),
	},
	.id_table = rk628_bt1120_csi_i2c_id,
	.probe	= rk628_bt1120_csi_probe,
	.remove = rk628_bt1120_csi_remove,
};

module_i2c_driver(rk628_bt1120_csi_i2c_driver);

MODULE_DESCRIPTION("Rockchip RK628 HDMI to MIPI CSI-2 bridge I2C driver");
MODULE_LICENSE("GPL");
