#include <linux/clk.h>
#include <linux/device.h>
#include <linux/delay.h>
#include <linux/gpio/consumer.h>
#include <linux/i2c.h>
#include <linux/module.h>
#include <linux/pm_runtime.h>
#include <linux/regulator/consumer.h>
#include <linux/sysfs.h>
#include <linux/slab.h>
#include <linux/version.h>
#include <linux/rk-camera-module.h>
#include <media/media-entity.h>
#include <media/v4l2-async.h>
#include <media/v4l2-ctrls.h>
#include <media/v4l2-subdev.h>
#include <linux/pinctrl/consumer.h>
#include <linux/rk-preisp.h>
#include <asm/io.h>
#include <asm/uaccess.h>
#include <linux/fs.h>
#include <linux/uaccess.h>
#include <linux/device.h>
#include <linux/miscdevice.h>

#define GS2971_VTS_MAX 0x7fff

#define DRIVER_VERSION		KERNEL_VERSION(0, 0x0, 0x01)
#define PIX_FORMAT			MEDIA_BUS_FMT_UYVY8_2X8
#define GS2971_NAME			"GS2971"
#define GS2971_DEVICE_NAME	"gs2971_bypass"

#define BUF_SIZE 16

#define CMD_GET_RESOLUTION  _IOR('G', 0, unsigned char)
/*gs2971获取分辨率寄存器地址：0x006, 最高位1为读，0为写*/
#define GS2971_GET_RESOLUTION_ADDR 0x8006

/*常见视频格式ID号定义，另外添加可以参考VESADMT或者CEA861标准*/
#define TV1080I50 0x0C
#define TV1080I60 0x0A
#define TV1080P25 0x0D
#define TV1080P30 0x0B
#define TV1080P50 0x2D
#define TV1080P60 0x2B
#define TV720P50  0x04
#define TV720P60  0x00

static struct class *gs2971_class;

struct regval {
	u16 addr;
	u8 val;
};

struct gs2971_mode {
	u32 width;
	u32 height;
	struct v4l2_fract max_fps;
	u32 hts_def;
	u32 vts_def;
	u32 exp_def;
	const struct regval *reg_list;
};

struct gs2971 {
    struct device   *dev;
	struct spi_device *spi;
	struct clk		*xvclk;
	struct gpio_desc	*reset_gpio;
	struct gpio_desc	*pwdn_gpio;

	struct v4l2_dv_timings timings;
	struct v4l2_subdev	subdev;
	struct media_pad	pad;
	struct v4l2_ctrl_handler ctrl_handler;
	struct v4l2_ctrl	*vblank;
	struct mutex		mutex;
	bool			streaming;
	bool			power_on;
	const struct gs2971_mode *cur_mode;
	u32			module_index;
	const char		*module_facing;
	const char		*module_name;
	const char		*len_name;

    dev_t gs2971_devno;
    struct cdev gs2971_cdev;
    char name[BUF_SIZE];

    struct device *classdev;
};

#define to_gs2971(sd) container_of(sd, struct gs2971, subdev)

static const struct gs2971_mode supported_modes[] = {
    {
        .width = 720,
        .height = 480,
        .max_fps = {
            .numerator = 10000,
            .denominator = 600000,
        },
        .hts_def = 858,
        .vts_def = 525,
    },
    {
        .width = 1280,
        .height = 720,
        .max_fps = {
            .numerator = 10000,
            .denominator = 600000,
        },
        .hts_def = 1650,
        .vts_def = 750,
    },
    {
        .width = 1280,
        .height = 720,
        .max_fps = {
            .numerator = 10000,
            .denominator = 500000,
        },
        .hts_def = 1650,
        .vts_def = 750,
    },
    {
		.width = 1920,
		.height = 1080,
		.max_fps = {
			.numerator = 10000,
			.denominator = 600000,
		},
		.exp_def = 0x0100,
		.hts_def = 0x044c * 2,
		.vts_def = 0x0465,
	},
    {
		.width = 1920,
		.height = 1080,
		.max_fps = {
			.numerator = 10000,
			.denominator = 500000,
		},
		.exp_def = 0x0100,
		.hts_def = 0x044c * 2,
		.vts_def = 0x0465,
	},
    {
		.width = 1920,
		.height = 1080,
		.max_fps = {
			.numerator = 10000,
			.denominator = 300000,
		},
		.exp_def = 0x0100,
		.hts_def = 0x044c * 2,
		.vts_def = 0x0465,
	},
    {
		.width = 1920,
		.height = 1080,
		.max_fps = {
			.numerator = 10000,
			.denominator = 250000,
		},
		.exp_def = 0x0100,
		.hts_def = 0x044c * 2,
		.vts_def = 0x0465,
	},
    {
		.width = 1920,
		.height = 540,
		.max_fps = {
			.numerator = 10000,
			.denominator = 600000,
		},
		.hts_def = 2200,
		.vts_def = 562,
    }
};

static unsigned char gs2971_get_resolution(struct gs2971* gs2971)
{
    int ret = -1;
    unsigned short addr = GS2971_GET_RESOLUTION_ADDR;
    u8 code[2];
    u8 val[2];
    struct spi_device* spi;
    
    spi = gs2971->spi;
    code[0] = addr >> 8;
    code[1] = addr;

    ret = spi_write_then_read(spi, code, 2, &val, 2);
    if(ret < 0)
    {
        printk("write and read val failed\n");
        return -EIO;
    }

    return val[0];
}

static int __gs2971_start_stream(struct gs2971 *gs2971)
{
	return 0;
}

static int __gs2971_stop_stream(struct gs2971 *gs2971)
{
	return 0;
}

static int gs2971_s_stream(struct v4l2_subdev *sd, int on)
{
	struct gs2971 *gs2971 = to_gs2971(sd);
	int ret = 0;

	mutex_lock(&gs2971->mutex);
	on = !!on;
	if (on == gs2971->streaming)
		goto unlock_and_return;

	if (on) {
		ret = pm_runtime_get_sync(&gs2971->spi->dev);
		if (ret < 0) {
			pm_runtime_put_noidle(&gs2971->spi->dev);
			goto unlock_and_return;
		}

		ret = __gs2971_start_stream(gs2971);
		if (ret) {
			v4l2_err(sd, "start stream failed while write regs\n");
			pm_runtime_put(&gs2971->spi->dev);
			goto unlock_and_return;
		}
	} else {
		__gs2971_stop_stream(gs2971);
		pm_runtime_put(&gs2971->spi->dev);
	}

	gs2971->streaming = on;
unlock_and_return:
	mutex_unlock(&gs2971->mutex);

	return ret;
}

#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
static int gs2971_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
{
	struct gs2971 *gs2971 = to_gs2971(sd);
	struct v4l2_mbus_framefmt *try_fmt =
				v4l2_subdev_get_try_format(sd, fh->state, 0);
	const struct gs2971_mode *def_mode = &supported_modes[0];

	mutex_lock(&gs2971->mutex);
	/* Initialize try_fmt */
	try_fmt->width = def_mode->width;
	try_fmt->height = def_mode->height;
	try_fmt->code = PIX_FORMAT;
	try_fmt->field = V4L2_FIELD_NONE;
	mutex_unlock(&gs2971->mutex);
	/* No crop or compose */

	return 0;
}
#endif

static int gs2971_g_mbus_config(struct v4l2_subdev *sd, unsigned int pad,
				struct v4l2_mbus_config *config)
{
    /*外同步设置为V4L2_MBUS_PARALLEL*/
	config->type = V4L2_MBUS_PARALLEL;
	//config->type = V4L2_MBUS_BT656;
	config->bus.parallel.flags = V4L2_MBUS_HSYNC_ACTIVE_HIGH |
			V4L2_MBUS_VSYNC_ACTIVE_HIGH |
			V4L2_MBUS_PCLK_SAMPLE_RISING;
	return 0;
}

static int gs2971_g_frame_interval(struct v4l2_subdev *sd,
				   struct v4l2_subdev_frame_interval *fi)
{
	struct gs2971 *gs2971 = to_gs2971(sd);
	//const struct gs2971_mode *mode = gs2971->cur_mode;
    unsigned char val = 0;

	mutex_lock(&gs2971->mutex);
    /*修改获取帧率函数，否则media-ctl无法获取到正确帧率*/
    val = gs2971_get_resolution(gs2971);
	//fi->interval = mode->max_fps;
    switch(val)
    {
        case TV720P60:
            fi->interval = supported_modes[1].max_fps;
            break;
        case TV720P50:
            fi->interval = supported_modes[2].max_fps;
            break;
        case TV1080P60:
        case TV1080I60:
            fi->interval = supported_modes[3].max_fps;
            break;
        case TV1080P50:
        case TV1080I50:
            fi->interval = supported_modes[4].max_fps;
            break;
        case TV1080P30:
            fi->interval = supported_modes[5].max_fps;
            break;
        case TV1080P25:
            fi->interval = supported_modes[6].max_fps;
            break;
        default:
            fi->interval = supported_modes[5].max_fps;
            break;
    }
	mutex_unlock(&gs2971->mutex);

	return 0;
}

static int gs2971_querystd(struct v4l2_subdev *sd, v4l2_std_id *std)
{
	*std = V4L2_STD_ATSC;
	return 0;
}

static int gs2971_enum_frame_interval(struct v4l2_subdev *sd,
				 struct v4l2_subdev_state *sd_state,
				       struct v4l2_subdev_frame_interval_enum *fie)
{
	if (fie->index >= ARRAY_SIZE(supported_modes))
		return -EINVAL;

	if (fie->code != PIX_FORMAT)
		return -EINVAL;

	fie->width = supported_modes[fie->index].width;
	fie->height = supported_modes[fie->index].height;
	fie->interval = supported_modes[fie->index].max_fps;
	return 0;
}

static int gs2971_enum_mbus_code(struct v4l2_subdev *sd,
				 struct v4l2_subdev_state *sd_state,
				 struct v4l2_subdev_mbus_code_enum *code)
{
	if (code->index != 0)
		return -EINVAL;
	code->code = PIX_FORMAT;

	return 0;
}

static int gs2971_enum_frame_sizes(struct v4l2_subdev *sd,
				 struct v4l2_subdev_state *sd_state,
				   struct v4l2_subdev_frame_size_enum *fse)
{
	if (fse->index >= ARRAY_SIZE(supported_modes))
		return -EINVAL;

	if (fse->code != PIX_FORMAT)
		return -EINVAL;

	fse->min_width  = supported_modes[fse->index].width;
	fse->max_width  = supported_modes[fse->index].width;
	fse->max_height = supported_modes[fse->index].height;
	fse->min_height = supported_modes[fse->index].height;

	return 0;
}

static int gs2971_set_fmt(struct v4l2_subdev *sd,
		struct v4l2_subdev_state *sd_state,
			  struct v4l2_subdev_format *fmt)
{
	struct gs2971 *gs2971 = to_gs2971(sd);
	const struct gs2971_mode *mode;
    u8 val = 0;

	mutex_lock(&gs2971->mutex);

	mode = gs2971->cur_mode;
	fmt->format.code = PIX_FORMAT;
	fmt->format.width = mode->width;
	fmt->format.height = mode->height;
	fmt->format.field = V4L2_FIELD_NONE;
	if (fmt->which == V4L2_SUBDEV_FORMAT_TRY) {
#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
		//*v4l2_subdev_get_try_format(sd, cfg, fmt->pad) = fmt->format;
#else
		mutex_unlock(&gs2971->mutex);
		return -ENOTTY;
#endif
	} else {
		gs2971->cur_mode = mode;
	}

    /*添加分辨率获取函数，否则无法正确获取分辨率信息*/
    val = gs2971_get_resolution(gs2971);
    if(TV1080P25 == val || TV1080P30 == val || TV1080P50 == val || TV1080P60 == val){
        fmt->format.width = 1920;
        fmt->format.height = 1080;
	    fmt->format.field = V4L2_FIELD_NONE;
    }else if(TV720P50 == val || TV720P60 == val){
        fmt->format.width = 1280;
        fmt->format.height = 720;
	    fmt->format.field = V4L2_FIELD_NONE;
    }
    /*隔行扫描实际为两帧组成一个画面，应用实际采集还是按照1080采*/
    else if(TV1080I50 == val || TV1080I60 == val){
        fmt->format.width = 1920;
        fmt->format.height = 1080;
	    fmt->format.field = V4L2_FIELD_INTERLACED;
    }else{
        fmt->format.width = 64;
        fmt->format.height = 64;
	    fmt->format.field = V4L2_FIELD_NONE;
    };

	mutex_unlock(&gs2971->mutex);

	return 0;
}

static int gs2971_get_fmt(struct v4l2_subdev *sd,
		struct v4l2_subdev_state *sd_state,
			  struct v4l2_subdev_format *fmt)
{
	struct gs2971 *gs2971 = to_gs2971(sd);
	const struct gs2971_mode *mode = gs2971->cur_mode;
    unsigned char val = 0;

	mutex_lock(&gs2971->mutex);
	if (fmt->which == V4L2_SUBDEV_FORMAT_TRY) {
#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
		//fmt->format = *v4l2_subdev_get_try_format(sd, cfg, fmt->pad);
#else
		mutex_unlock(&gs2971->mutex);
		return -ENOTTY;
#endif
	} else {
		fmt->format.width = mode->width;
		fmt->format.height = mode->height;
		fmt->format.code = PIX_FORMAT;
		fmt->format.field = V4L2_FIELD_NONE;
        
        /*添加分辨率获取函数，否则无法正确获取分辨率信息*/
        val = gs2971_get_resolution(gs2971);
        if(TV1080P25 == val || TV1080P30 == val || TV1080P50 == val || TV1080P60 == val)
        {
            fmt->format.width = 1920;
            fmt->format.height = 1080;
		    fmt->format.field = V4L2_FIELD_NONE;
        }else if(TV720P50 == val || TV720P60 == val)
        {
            fmt->format.width = 1280;
            fmt->format.height = 720;
		    fmt->format.field = V4L2_FIELD_NONE;
        }
        /*隔行扫描实际为两帧组成一个画面，应用实际采集还是按照1080采*/
        else if(TV1080I50 == val || TV1080I60 == val){
            fmt->format.width = 1920;
            fmt->format.height = 1080;
		    fmt->format.field = V4L2_FIELD_INTERLACED;
        }else{
            fmt->format.width = 64;
            fmt->format.height = 64;
		    fmt->format.field = V4L2_FIELD_NONE;
        };
	}
	mutex_unlock(&gs2971->mutex);

	return 0;
}

static int gs2971_s_power(struct v4l2_subdev *sd, int on)
{
	struct gs2971 *gs2971 = to_gs2971(sd);
	int ret = 0;

	mutex_lock(&gs2971->mutex);

	/* If the power state is not modified - no work to do. */
	if (gs2971->power_on == !!on)
		goto unlock_and_return;

	if (on) {
		ret = pm_runtime_get_sync(&gs2971->spi->dev);
		if (ret < 0) {
			pm_runtime_put_noidle(&gs2971->spi->dev);
			goto unlock_and_return;
		}

		gs2971->power_on = true;
	} else {
		pm_runtime_put(&gs2971->spi->dev);
		gs2971->power_on = false;
	}

unlock_and_return:
	mutex_unlock(&gs2971->mutex);

	return ret;
}

static int __gs2971_power_on(struct gs2971 *gs2971)
{
	return 0;
}

static void __gs2971_power_off(struct gs2971 *gs2971)
{
	return;
}

static int gs2971_runtime_resume(struct device *dev)
{
	//struct i2c_client *client = to_i2c_client(dev);
	//struct v4l2_subdev *sd = i2c_get_clientdata(client);
	//struct gs2971 *gs2971 = to_gs2971(sd);

	//return __gs2971_power_on(gs2971);
    return 0;
}

static int gs2971_runtime_suspend(struct device *dev)
{
	//struct i2c_client *client = to_i2c_client(dev);
	//struct v4l2_subdev *sd = i2c_get_clientdata(client);
	//struct gs2971 *gs2971 = to_gs2971(sd);

	//__gs2971_power_off(gs2971);

	return 0;
}

static const struct dev_pm_ops gs2971_pm_ops = {
	SET_RUNTIME_PM_OPS(gs2971_runtime_suspend,
			   gs2971_runtime_resume, NULL)
};

#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
static const struct v4l2_subdev_internal_ops gs2971_internal_ops = {
	.open = gs2971_open,
};
#endif

static const struct v4l2_subdev_core_ops gs2971_core_ops = {
	.s_power = gs2971_s_power,
};

static const struct v4l2_subdev_video_ops gs2971_video_ops = {
	.s_stream = gs2971_s_stream,
	//.g_mbus_config = gs2971_g_mbus_config,
	.g_frame_interval = gs2971_g_frame_interval,
	.querystd = gs2971_querystd,
};

static const struct v4l2_subdev_pad_ops gs2971_pad_ops = {
	.enum_mbus_code = gs2971_enum_mbus_code,
	.enum_frame_size = gs2971_enum_frame_sizes,
	.enum_frame_interval = gs2971_enum_frame_interval,
	.get_fmt = gs2971_get_fmt,
	.set_fmt = gs2971_set_fmt,
    .get_mbus_config = gs2971_g_mbus_config,
};

static const struct v4l2_subdev_ops gs2971_subdev_ops = {
	.core	= &gs2971_core_ops,
	.video	= &gs2971_video_ops,
	.pad	= &gs2971_pad_ops,
};

static int gs2971_set_ctrl(struct v4l2_ctrl *ctrl)
{
    switch(ctrl->id) {
        /*添加V4L2_CID_VBLANK防止内核段错误，里面不需要做处理*/
        case V4L2_CID_VBLANK:
            break;
        default:
            break;
    }

    return 0;
}

static const struct v4l2_ctrl_ops gs2971_ctrl_ops = {
    .s_ctrl = gs2971_set_ctrl,
};

static int gs2971_reset(struct gs2971* gs2971)
{
	gpiod_set_value(gs2971->reset_gpio, 1);
	usleep_range(300*1000, 310*1000);
	gpiod_set_value(gs2971->reset_gpio, 0);
	usleep_range(500*1000, 510*1000);
	gpiod_set_value(gs2971->reset_gpio, 1);
	usleep_range(300*1000, 310*1000);
    
    return 0;
}

static int gs2971_fops_open(struct inode* inode, struct file* file){
    int minor;
    struct gs2971 *gs2971;

    minor = MINOR(inode->i_rdev);
    gs2971 = container_of(inode->i_cdev, struct gs2971, gs2971_cdev);

    dev_info(gs2971->dev, "%s\n", __func__);
    return 0;
}

static int gs2971_close(struct inode* inode, struct file* file){
    int minor;
    struct gs2971 *gs2971;

    minor = MINOR(inode->i_rdev);
    gs2971 = container_of(inode->i_cdev, struct gs2971, gs2971_cdev);

    dev_info(gs2971->dev, "%s\n", __func__);
    return 0;
}

static long gs2971_ioctl(struct file* file, unsigned int cmd, unsigned long arg)
{
    void __user *argp = (void __user*)arg;
    
    int ret = -1;
    unsigned char val;
    struct inode *inode;
    int minor;
    struct gs2971 *gs2971;

    inode = file->f_path.dentry->d_inode;
    minor = MINOR(inode->i_rdev);
    gs2971 = container_of(inode->i_cdev, struct gs2971, gs2971_cdev);

    switch(cmd)
    {
        case CMD_GET_RESOLUTION:
            val = gs2971_get_resolution(gs2971);
            ret = copy_to_user(argp, (const void*)&val, sizeof(unsigned char));
            if(ret)
            {
                dev_err(gs2971->dev, "gs2971 copy_to_user failed\n");
                return -EIO;
            }
            break;
        default:
            break;
    }

    return 0;
}

static struct file_operations gs2971_fops = {
    .owner = THIS_MODULE,
    .open = gs2971_fops_open,
    .release = gs2971_close,
    .unlocked_ioctl = gs2971_ioctl,
};

static int gs2971_probe(struct spi_device* spi)
{
	struct device *dev = &spi->dev;
	struct gs2971 *gs2971;
	struct v4l2_subdev *sd;
	char facing[2];
	s64 vblank_def;
    struct v4l2_ctrl_handler *handler;
	int ret;

	dev_info(dev, "gs2971a driver version: %02x.%02x.%02x",
		DRIVER_VERSION >> 16,
		(DRIVER_VERSION & 0xff00) >> 8,
		DRIVER_VERSION & 0x00ff);

	gs2971 = devm_kzalloc(dev, sizeof(*gs2971), GFP_KERNEL);
	if (!gs2971)
		return -ENOMEM;

	gs2971->spi = spi;
    gs2971->dev = &spi->dev;
	gs2971->cur_mode = &supported_modes[5];
    handler = &gs2971->ctrl_handler;

	gs2971->xvclk = devm_clk_get(dev, "xvclk");
	if (IS_ERR(gs2971->xvclk)) {
		dev_err(dev, "Failed to get xvclk\n");
		return -EINVAL;
	}

	gs2971->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
	if (IS_ERR(gs2971->reset_gpio))
		dev_warn(dev, "Failed to get reset-gpios\n");

	gs2971->pwdn_gpio = devm_gpiod_get(dev, "pwdn", GPIOD_OUT_LOW);
	if (IS_ERR(gs2971->pwdn_gpio))
		dev_warn(dev, "Failed to get pwdn-gpios\n");

	mutex_init(&gs2971->mutex);

	sd = &gs2971->subdev;
	v4l2_spi_subdev_init(sd, spi, &gs2971_subdev_ops);

    ret = v4l2_ctrl_handler_init(handler, 8);
    if(ret)
        return ret;
    handler->lock = &gs2971->mutex;

	vblank_def = gs2971->cur_mode->vts_def - gs2971->cur_mode->height;
	gs2971->vblank = v4l2_ctrl_new_std(handler, &gs2971_ctrl_ops,
				V4L2_CID_VBLANK, vblank_def,
				GS2971_VTS_MAX - gs2971->cur_mode->height,
				1, vblank_def);
    if(handler->error){
        ret = handler->error;
        dev_err(dev, "gs2971 failed to init controls(%d)\n", ret);
        goto err_free_handler;
    }
    gs2971->subdev.ctrl_handler = handler;

	ret = __gs2971_power_on(gs2971);
	if (ret)
		goto err_free_handler;

#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
	sd->internal_ops = &gs2971_internal_ops;
	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
		     V4L2_SUBDEV_FL_HAS_EVENTS;
#endif

#if defined(CONFIG_MEDIA_CONTROLLER)
	gs2971->pad.flags = MEDIA_PAD_FL_SOURCE;
	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
	ret = media_entity_pads_init(&sd->entity, 1, &gs2971->pad);
	if (ret < 0)
		goto err_power_off;
#endif

	memset(facing, 0, sizeof(facing));

	if (!sd->dev)
		dev_err(dev, "sd dev is null\n");

	snprintf(sd->name, sizeof(sd->name), "m%02d_%s_%s %s",
		 gs2971->module_index, facing,
		 GS2971_NAME, dev_name(sd->dev));

	ret = v4l2_async_register_subdev_sensor(sd);
	if (ret) {
		dev_err(dev, "v4l2 async register subdev failed\n");
		goto err_clean_entity;
	}

	ret = spi_setup(spi);
	if (ret < 0) {
		dev_err(dev, "ERR: fail to setup spi\n");
		return -1;
	}

	dev_info(dev, "%s:name=%s,bus_num=%d,cs=%d,mode=%d,speed=%d\n", __func__, spi->modalias, spi->master->bus_num, spi->chip_select, spi->mode, spi->max_speed_hz);

    /*字符设备创建*/
    ret = alloc_chrdev_region(&gs2971->gs2971_devno, 0, 1, GS2971_DEVICE_NAME);
    if(ret){
        dev_err(dev, "alloc_chrdev_region failed\n");
        goto err_clean_entity;
    }
    cdev_init(&gs2971->gs2971_cdev, &gs2971_fops);
    gs2971->gs2971_cdev.owner = THIS_MODULE;
    ret = cdev_add(&gs2971->gs2971_cdev, gs2971->gs2971_devno, 1);
    if(ret){
        dev_err(dev, "cdev_add failed ret:%d\n ", ret);
        goto err_cdev_add;
    }
    if(!gs2971_class){
        gs2971_class = class_create(THIS_MODULE, GS2971_DEVICE_NAME);
        if(IS_ERR(gs2971_class)){
            dev_err(dev, "class_create failed!\n");
            goto err_cdev_add;
        }
    }
    gs2971->classdev = device_create(gs2971_class,
            dev, gs2971->gs2971_devno,
            0,
            "%s", GS2971_DEVICE_NAME);
    if (IS_ERR(gs2971->classdev)) {
        dev_err(dev, "failed to device_create_with_groups\n");
        goto err_class_destroy;
    }

	//芯片复位
    dev_info(dev, "gs2971 reset\n");
	gs2971_reset(gs2971);

    spi_set_drvdata(spi, gs2971);

	pm_runtime_set_active(dev);
	pm_runtime_enable(dev);
	pm_runtime_idle(dev);

	return 0;

err_class_destroy:
    class_destroy(gs2971_class);

err_cdev_add:
    unregister_chrdev_region(gs2971->gs2971_devno, 1);
err_clean_entity:
#if defined(CONFIG_MEDIA_CONTROLLER)
	media_entity_cleanup(&sd->entity);
#endif
err_power_off:
	__gs2971_power_off(gs2971);
err_free_handler:
	v4l2_ctrl_handler_free(&gs2971->ctrl_handler);

	mutex_destroy(&gs2971->mutex);

	return ret;
}

static void gs2971_remove(struct spi_device* spi)
{
	struct v4l2_subdev *sd = spi_get_drvdata(spi);
	struct gs2971 *gs2971 = to_gs2971(sd);

	v4l2_async_unregister_subdev(sd);
#if defined(CONFIG_MEDIA_CONTROLLER)
	media_entity_cleanup(&sd->entity);
#endif
	v4l2_ctrl_handler_free(&gs2971->ctrl_handler);
	mutex_destroy(&gs2971->mutex);

	pm_runtime_disable(&spi->dev);
	if (!pm_runtime_status_suspended(&spi->dev))
		__gs2971_power_off(gs2971);
	pm_runtime_set_suspended(&spi->dev);

    if(gs2971_class){
        class_destroy(gs2971_class);
        device_destroy(gs2971_class, gs2971->gs2971_devno);
        cdev_del(&gs2971->gs2971_cdev);
        unregister_chrdev_region(gs2971->gs2971_devno, 1);
    }
}

#if IS_ENABLED(CONFIG_OF)
static const struct of_device_id gs2971_of_match[] = {
	{ .compatible = "semtech,gs2971" },
	{},
};
MODULE_DEVICE_TABLE(of, gs2971_of_match);
#endif

static struct spi_driver gs2971_spi_driver = {
	.driver = {
		.name = GS2971_NAME,
		.of_match_table = of_match_ptr(gs2971_of_match),
        .owner = THIS_MODULE,
	},
	.probe		= &gs2971_probe,
	.remove		= &gs2971_remove,
};

static int __init gs2971_mod_init(void)
{
	return spi_register_driver(&gs2971_spi_driver);
}

static void __exit gs2971_mod_exit(void)
{
    return spi_unregister_driver(&gs2971_spi_driver);
}

device_initcall_sync(gs2971_mod_init);
module_exit(gs2971_mod_exit);

MODULE_DESCRIPTION("gs2971 driver");
MODULE_LICENSE("GPL v2");


