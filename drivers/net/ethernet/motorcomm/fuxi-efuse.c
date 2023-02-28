
/*++

Copyright (c) 2021 Motorcomm Corporation. 
Confidential and Proprietary. All rights reserved.

This is Motorcomm Corporation NIC driver relevant files. Please don't copy, modify,
distribute without commercial permission.

--*/

#include "fuxi-gmac.h"
#include "fuxi-gmac-reg.h"
#include "fuxi-efuse.h"
#if defined(UEFI)
#include "nic_sw.h"
#elif defined(LINUX)
#elif defined(_WIN32) || defined(_WIN64)

#else
#endif

bool fxgmac_read_patch_from_efuse_per_index(struct fxgmac_pdata* pdata, u8 index, u32* offset, u32* value) /* read patch per index. */
{
    unsigned int wait, i;
    u32 regval = 0;
    bool succeed = false;

    if (index >= FUXI_EFUSE_MAX_ENTRY) {
        FXGMAC_PR("Reading efuse out of range, index %d\n", index);
        return false;
    }

    if (offset) {
        *offset = 0;
    }
    for (i = EFUSE_PATCH_ADDR_START_BYTE; i < EFUSE_PATCH_DATA_START_BYTE; i++) {
        regval = 0;
        regval = FXGMAC_SET_REG_BITS(regval, EFUSE_OP_ADDR_POS, EFUSE_OP_ADDR_LEN, EFUSE_REGION_A_B_LENGTH + index * EFUSE_EACH_PATH_SIZE + i);
        regval = FXGMAC_SET_REG_BITS(regval, EFUSE_OP_START_POS, EFUSE_OP_START_LEN, 1);
        regval = FXGMAC_SET_REG_BITS(regval, EFUSE_OP_MODE_POS, EFUSE_OP_MODE_LEN, EFUSE_OP_MODE_ROW_READ);
        writereg(pdata->pAdapter, regval, pdata->base_mem + EFUSE_OP_CTRL_0);
        wait = 1000;
        while (wait--) {
            usleep_range_ex(pdata->pAdapter, 20, 50);
            regval = readreg(pdata->pAdapter, pdata->base_mem + EFUSE_OP_CTRL_1);
            if (FXGMAC_GET_REG_BITS(regval, EFUSE_OP_DONE_POS, EFUSE_OP_DONE_LEN)) {
                succeed = true;
                break;
            }
        }
        if (succeed) {
            if (offset) {
                *offset |= (FXGMAC_GET_REG_BITS(regval, EFUSE_OP_RD_DATA_POS, EFUSE_OP_RD_DATA_LEN) << (i << 3));
            }
        }
        else {
            FXGMAC_PR("Fail to reading efuse Byte%d\n", index * EFUSE_EACH_PATH_SIZE + i);
            return succeed;
        }
    }

    if (value) {
        *value = 0;
    }
    for (i = EFUSE_PATCH_DATA_START_BYTE; i < EFUSE_EACH_PATH_SIZE; i++) {
        regval = 0;
        regval = FXGMAC_SET_REG_BITS(regval, EFUSE_OP_ADDR_POS, EFUSE_OP_ADDR_LEN, EFUSE_REGION_A_B_LENGTH + index * EFUSE_EACH_PATH_SIZE + i);
        regval = FXGMAC_SET_REG_BITS(regval, EFUSE_OP_START_POS, EFUSE_OP_START_LEN, 1);
        regval = FXGMAC_SET_REG_BITS(regval, EFUSE_OP_MODE_POS, EFUSE_OP_MODE_LEN, EFUSE_OP_MODE_ROW_READ);
        writereg(pdata->pAdapter, regval, pdata->base_mem + EFUSE_OP_CTRL_0);
        wait = 1000;
        while (wait--) {
            usleep_range_ex(pdata->pAdapter, 20, 50);
            regval = readreg(pdata->pAdapter, pdata->base_mem + EFUSE_OP_CTRL_1);
            if (FXGMAC_GET_REG_BITS(regval, EFUSE_OP_DONE_POS, EFUSE_OP_DONE_LEN)) {
                succeed = true;
                break;
            }
        }
        if (succeed) {
            if (value) {
                *value |= (FXGMAC_GET_REG_BITS(regval, EFUSE_OP_RD_DATA_POS, EFUSE_OP_RD_DATA_LEN) << ((i - 2) << 3));
            }
        }
        else {
            FXGMAC_PR("Fail to reading efuse Byte%d\n", index * EFUSE_EACH_PATH_SIZE + i);
            return succeed;
        }
    }

    return succeed;
}

bool fxgmac_read_patch_from_efuse(struct fxgmac_pdata* pdata, u32 offset, u32* value) /* read patch per index. */
{
    u32 reg_offset, reg_val;
    u32 cur_val = 0;
    bool succeed = true;
	u8 index = 0;
	
	if(offset >> 16){
        FXGMAC_PR("Reading efuse out of range, reg %d. reg must be 2bytes.\n", index);
        return false;
    }

    for (index = 0; index < FUXI_EFUSE_MAX_ENTRY; index++) {
        if (!fxgmac_read_patch_from_efuse_per_index(pdata, index, &reg_offset, &reg_val)) {
            succeed = false;
            break;
        } else if (reg_offset == offset) {
            cur_val = reg_val;
        } else if (0 == reg_offset && 0 == reg_val) {
            break; // first blank. We should write here.
        }
    }

    if (value) {
        *value = cur_val;
    }
    
    return succeed;
}

bool fxgmac_write_patch_to_efuse_per_index(struct fxgmac_pdata* pdata, u8 index, u32 offset, u32 value)
{
    unsigned int    wait, i;
    u32             reg_val;
    bool            succeed = false;
	u32             cur_reg, cur_val;
	
	if(offset >> 16){
        FXGMAC_PR("Reading efuse out of range, reg %d. reg must be 2bytes.\n", index);
        return false;
    }

    if (index >= FUXI_EFUSE_MAX_ENTRY) {
        FXGMAC_PR("Writing efuse out of range, index %d\n", index);
        return false;
    }
	
	if (fxgmac_read_patch_from_efuse_per_index(pdata, index, &cur_reg, &cur_val)) {
        if(cur_reg != 0 || cur_val != 0){
            FXGMAC_PR(" The index %d has writed value, cannot rewrite it.\n", index);
            return false;
        }
    }else{
        FXGMAC_PR("Cannot read index %d.\n", index);
        return false;
    }
	
    for (i = EFUSE_PATCH_ADDR_START_BYTE; i < EFUSE_PATCH_DATA_START_BYTE; i++) {
        reg_val = 0;
        reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_ADDR_POS, EFUSE_OP_ADDR_LEN, EFUSE_REGION_A_B_LENGTH + index * EFUSE_EACH_PATH_SIZE + i);
        reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_WR_DATA_POS, EFUSE_OP_WR_DATA_LEN, (offset >> (i << 3)) & 0xFF);
        reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_START_POS, EFUSE_OP_START_LEN, 1);
        reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_MODE_POS, EFUSE_OP_MODE_LEN, EFUSE_OP_MODE_ROW_WRITE);
        writereg(pdata->pAdapter, reg_val, pdata->base_mem + EFUSE_OP_CTRL_0);

        succeed = false;
        wait = 1000;
        while (wait--) {
            usleep_range_ex(pdata->pAdapter, 20, 50);
            reg_val = readreg(pdata->pAdapter, pdata->base_mem + EFUSE_OP_CTRL_1);
            if (FXGMAC_GET_REG_BITS(reg_val, EFUSE_OP_DONE_POS, EFUSE_OP_DONE_LEN)) {
                succeed = true;
                break;
            }
        }
        if (!succeed) {
            FXGMAC_PR("Fail to writing efuse Byte%d\n", index * EFUSE_EACH_PATH_SIZE + i);
            return succeed;
        }
    }

    for (i = 2; i < 6; i++) {
        reg_val = 0;
        reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_ADDR_POS, EFUSE_OP_ADDR_LEN, 18 + index * 6 + i);
        reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_WR_DATA_POS, EFUSE_OP_WR_DATA_LEN, (value >> ((i - 2) << 3)) & 0xFF);
        reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_START_POS, EFUSE_OP_START_LEN, 1);
        reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_MODE_POS, EFUSE_OP_MODE_LEN, EFUSE_OP_MODE_ROW_WRITE);
        writereg(pdata->pAdapter, reg_val, pdata->base_mem + EFUSE_OP_CTRL_0);

        succeed = false;
        wait = 1000;
        while (wait--) {
            usleep_range_ex(pdata->pAdapter, 20, 50);
            reg_val = readreg(pdata->pAdapter, pdata->base_mem + EFUSE_OP_CTRL_1);
            if (FXGMAC_GET_REG_BITS(reg_val, EFUSE_OP_DONE_POS, EFUSE_OP_DONE_LEN)) {
                succeed = true;
                break;
            }
        }
        if (!succeed) {
            FXGMAC_PR("Fail to writing efuse Byte%d\n", index * EFUSE_EACH_PATH_SIZE + i);
            return succeed;
        }
    }

    return succeed;
}

bool fxgmac_write_patch_to_efuse(struct fxgmac_pdata* pdata, u32 offset, u32 value)
{
    unsigned int wait, i;
    u32 reg_offset, reg_val;
    u32 cur_offset = 0, cur_val = 0;
    bool succeed = false;
    u8 index = 0;
	
	if(offset >> 16){
        FXGMAC_PR("Reading efuse out of range, reg %d. reg must be 2bytes.\n", index);
        return false;
    }
	
    for (index = 0; ; index++) {
        if (!fxgmac_read_patch_from_efuse_per_index(pdata, index, &reg_offset, &reg_val)) {
            return false;
        } else if (reg_offset == offset) {
            cur_offset = reg_offset;
            cur_val = reg_val;
        } else if (0 == reg_offset && 0 == reg_val) {
            break; // first blank. We should write here.
        }
    }

    if (cur_offset == offset) {
        if (cur_val == value) {
            FXGMAC_PR("0x%x -> Reg0x%x already exists, ignore.\n", value, offset);
            return true;
        } else {
            FXGMAC_PR("Reg0x%x entry current value 0x%x, reprogram.\n", offset, value);
        }
    }

    for (i = EFUSE_PATCH_ADDR_START_BYTE; i < EFUSE_PATCH_DATA_START_BYTE; i++) {
        reg_val = 0;
        reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_ADDR_POS, EFUSE_OP_ADDR_LEN, EFUSE_REGION_A_B_LENGTH + index * EFUSE_EACH_PATH_SIZE + i);
        reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_WR_DATA_POS, EFUSE_OP_WR_DATA_LEN, (offset >> (i << 3)) & 0xFF );
        reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_START_POS, EFUSE_OP_START_LEN, 1);
        reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_MODE_POS, EFUSE_OP_MODE_LEN, EFUSE_OP_MODE_ROW_WRITE);
        writereg(pdata->pAdapter, reg_val, pdata->base_mem + EFUSE_OP_CTRL_0);

        succeed = false;
        wait = 1000;
        while (wait--) {
            usleep_range_ex(pdata->pAdapter, 20, 50);
            reg_val = readreg(pdata->pAdapter, pdata->base_mem + EFUSE_OP_CTRL_1);
            if (FXGMAC_GET_REG_BITS(reg_val, EFUSE_OP_DONE_POS, EFUSE_OP_DONE_LEN)) {
                succeed = true;
                break;
            }
        }
        if (!succeed) {
            FXGMAC_PR("Fail to writing efuse Byte%d\n", index * EFUSE_EACH_PATH_SIZE + i);
            return succeed;
        }
    }

    for (i = EFUSE_PATCH_DATA_START_BYTE; i < EFUSE_EACH_PATH_SIZE; i++) {
        reg_val = 0;
        reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_ADDR_POS, EFUSE_OP_ADDR_LEN, EFUSE_REGION_A_B_LENGTH + index * EFUSE_EACH_PATH_SIZE + i);
        reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_WR_DATA_POS, EFUSE_OP_WR_DATA_LEN, (value >> ((i - 2) << 3)) & 0xFF);
        reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_START_POS, EFUSE_OP_START_LEN, 1);
        reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_MODE_POS, EFUSE_OP_MODE_LEN, EFUSE_OP_MODE_ROW_WRITE);
        writereg(pdata->pAdapter, reg_val, pdata->base_mem + EFUSE_OP_CTRL_0);

        succeed = false;
        wait = 1000;
        while (wait--) {
            usleep_range_ex(pdata->pAdapter, 20, 50);
            reg_val = readreg(pdata->pAdapter, pdata->base_mem + EFUSE_OP_CTRL_1);
            if (FXGMAC_GET_REG_BITS(reg_val, EFUSE_OP_DONE_POS, EFUSE_OP_DONE_LEN)) {
                succeed = true;
                break;
            }
        }
        if (!succeed) {
            FXGMAC_PR("Fail to writing efuse Byte%d\n", index * EFUSE_EACH_PATH_SIZE + i);
            return succeed;
        }
    }

    return succeed;
}

bool fxgmac_read_mac_subsys_from_efuse(struct fxgmac_pdata* pdata, u8* mac_addr, u32* subsys, u32* revid)
{
    u32 offset = 0, value = 0;
    u32 machr = 0, maclr = 0;
	bool succeed = true;
	u8 index = 0;
	
    for (index = 0; ; index++) {
        if (!fxgmac_read_patch_from_efuse_per_index(pdata, index, &offset, &value)) {
			succeed = false;
            break; // reach the last item.
        }
        if (0x00 == offset) {
            break; // reach the blank.
        }
        if (MACA0LR_FROM_EFUSE == offset) {
            maclr = value;
        }
        if (MACA0HR_FROM_EFUSE == offset) {
            machr = value;
        }

        if ((0x08 == offset) && revid) {
            *revid = value;
        }
        if ((0x2C == offset) && subsys) {
            *subsys = value;
        }
    }
    if (mac_addr) {
        mac_addr[5] = (u8)(maclr & 0xFF);
        mac_addr[4] = (u8)((maclr >> 8) & 0xFF);
        mac_addr[3] = (u8)((maclr >> 16) & 0xFF);
        mac_addr[2] = (u8)((maclr >> 24) & 0xFF);
        mac_addr[1] = (u8)(machr & 0xFF);
        mac_addr[0] = (u8)((machr >> 8) & 0xFF);
    }

    return succeed;
}

bool fxgmac_write_mac_subsys_to_efuse(struct fxgmac_pdata* pdata, u8* mac_addr, u32* subsys, u32* revid)
{
    u32 machr = 0, maclr = 0,pcie_cfg_ctrl= PCIE_CFG_CTRL_DEFAULT_VAL;
	bool succeed = true;
    if (mac_addr) {
        machr = readreg(pdata->pAdapter, pdata->base_mem + MACA0HR_FROM_EFUSE);
        maclr = readreg(pdata->pAdapter, pdata->base_mem + MACA0LR_FROM_EFUSE);
        FXGMAC_PR("Current mac address from efuse is %02x-%02x-%02x-%02x-%02x-%02x.\n", 
            (machr >> 8) & 0xFF, machr & 0xFF, (maclr >> 24) & 0xFF, (maclr >> 16) & 0xFF, (maclr >> 8) & 0xFF, maclr & 0xFF);

        if(!fxgmac_write_patch_to_efuse(pdata, MACA0HR_FROM_EFUSE, (((u32)mac_addr[0]) << 8) | mac_addr[1])){
			succeed = false;
		}
        if(!fxgmac_write_patch_to_efuse(pdata, MACA0LR_FROM_EFUSE, (((u32)mac_addr[2]) << 24) | (((u32)mac_addr[3]) << 16) | (((u32)mac_addr[4]) << 8) | mac_addr[5])){
			succeed = false;
		}
    }

    if (revid) {
        if(!fxgmac_write_patch_to_efuse(pdata, EFUSE_REVID_REGISTER, *revid)){
			succeed = false;
		}
    }
    if (subsys) {
        pcie_cfg_ctrl = FXGMAC_SET_REG_BITS(pcie_cfg_ctrl, MGMT_PCIE_CFG_CTRL_CS_EN_POS, MGMT_PCIE_CFG_CTRL_CS_EN_LEN, 1);
        if (!fxgmac_write_patch_to_efuse(pdata, MGMT_PCIE_CFG_CTRL, pcie_cfg_ctrl)){
            succeed = false;
        }
        if(!fxgmac_write_patch_to_efuse(pdata, EFUSE_SUBSYS_REGISTER, *subsys)){
			succeed = false;
		}
        pcie_cfg_ctrl = FXGMAC_SET_REG_BITS(pcie_cfg_ctrl, MGMT_PCIE_CFG_CTRL_CS_EN_POS, MGMT_PCIE_CFG_CTRL_CS_EN_LEN, 0);
        if (!fxgmac_write_patch_to_efuse(pdata, MGMT_PCIE_CFG_CTRL, pcie_cfg_ctrl)){
            succeed = false;
        }
    }
    return succeed;
}

bool fxgmac_write_mac_addr_to_efuse(struct fxgmac_pdata* pdata, u8* mac_addr)
{
    u32 machr = 0, maclr = 0;
    bool succeed = true;
    
    if (mac_addr) {
        machr = readreg(pdata->pAdapter, pdata->base_mem + MACA0HR_FROM_EFUSE);
        maclr = readreg(pdata->pAdapter, pdata->base_mem + MACA0LR_FROM_EFUSE);
        FXGMAC_PR("Current mac address from efuse is %02x-%02x-%02x-%02x-%02x-%02x.\n", 
            (machr >> 8) & 0xFF, machr & 0xFF, (maclr >> 24) & 0xFF, (maclr >> 16) & 0xFF, (maclr >> 8) & 0xFF, maclr & 0xFF);

        if(!fxgmac_write_patch_to_efuse(pdata, MACA0HR_FROM_EFUSE, (((u32)mac_addr[0]) << 8) | mac_addr[1])){
            succeed = false;
        }
        if(!fxgmac_write_patch_to_efuse(pdata, MACA0LR_FROM_EFUSE, (((u32)mac_addr[2]) << 24) | (((u32)mac_addr[3]) << 16) | (((u32)mac_addr[4]) << 8) | mac_addr[5])){
            succeed = false;
        }
    }

    return succeed;
}

bool fxgmac_read_subsys_from_efuse(struct fxgmac_pdata* pdata, u32* subsys, u32* revid)
{
    u32 offset = 0, value = 0;
    u8 index;
    bool succeed = true;
    
    for (index = 0; ; index++) {
        if (!fxgmac_read_patch_from_efuse_per_index(pdata, index, &offset, &value)) {
            succeed = false;
            break; // reach the last item.
        }
        if (0x00 == offset) {
            break; // reach the blank.
        }

        if ((EFUSE_REVID_REGISTER == offset) && revid) {
            *revid = value;
        }else{
            succeed = false;
        }
        if ((EFUSE_SUBSYS_REGISTER == offset) && subsys) {
            *subsys = value;
        }else{
            succeed = false;
        }
    }
    
    return succeed;
}

bool fxgmac_write_subsys_to_efuse(struct fxgmac_pdata* pdata, u32* subsys, u32* revid)
{
    bool succeed = true;
    
    /* write subsys info */
    if (revid) {
        if(!fxgmac_write_patch_to_efuse(pdata, EFUSE_REVID_REGISTER, *revid)){
            succeed = false;
        }
    }
    if (subsys) {
        if(!fxgmac_write_patch_to_efuse(pdata, EFUSE_SUBSYS_REGISTER, *subsys)){
            succeed = false;
        }
    }
    return succeed;
}

bool  fxgmac_efuse_load(struct fxgmac_pdata* pdata)
{
    bool succeed = false;
    unsigned int wait;
    u32 reg_val = 0;
    reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_START_POS, EFUSE_OP_START_LEN, 1);
    reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_MODE_POS, EFUSE_OP_MODE_LEN, EFUSE_OP_MODE_AUTO_LOAD);
    writereg(pdata->pAdapter, reg_val, pdata->base_mem + EFUSE_OP_CTRL_0);

    wait = 1000;
    while (wait--) {
        usleep_range_ex(pdata->pAdapter, 20, 50);
        reg_val = readreg(pdata->pAdapter, pdata->base_mem + EFUSE_OP_CTRL_1);
        if (FXGMAC_GET_REG_BITS(reg_val, EFUSE_OP_DONE_POS, EFUSE_OP_DONE_LEN)) {
            succeed = true;
            break;
        }
    }
    if (!succeed) {
        FXGMAC_PR("Fail to loading efuse, ctrl_1 0x%08x\n", reg_val);
    }
    return succeed;
}

bool fxgmac_efuse_read_regionA_regionB(struct fxgmac_pdata* pdata, u32 reg, u32* value)
{
    bool succeed = false;
    unsigned int wait;
    u32 reg_val = 0;

    if (reg >= EFUSE_REGION_A_B_LENGTH) {
        FXGMAC_PR("Read addr out of range %d", reg);
        return succeed;
    }

    if (value) {
        *value = 0;
    }

    reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_ADDR_POS, EFUSE_OP_ADDR_LEN, reg);
    reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_START_POS, EFUSE_OP_START_LEN, 1);
    reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_MODE_POS, EFUSE_OP_MODE_LEN, EFUSE_OP_MODE_ROW_READ);
    writereg(pdata->pAdapter, reg_val, pdata->base_mem + EFUSE_OP_CTRL_0);
    wait = 1000;
    while (wait--) {
        usleep_range_ex(pdata->pAdapter, 20, 50);
        reg_val = readreg(pdata->pAdapter, pdata->base_mem + EFUSE_OP_CTRL_1);
        if (FXGMAC_GET_REG_BITS(reg_val, EFUSE_OP_DONE_POS, EFUSE_OP_DONE_LEN)) {
            succeed = true;
            break;
        }
    }

    if (succeed) {
        if (value) {
            *value = FXGMAC_GET_REG_BITS(reg_val, EFUSE_OP_RD_DATA_POS, EFUSE_OP_RD_DATA_LEN);
        }
    }
    else {
        FXGMAC_PR("Fail to reading efuse Byte%d\n", reg);
    }

    return succeed;
}

bool fxgmac_efuse_write_oob(struct fxgmac_pdata* pdata)
{
    bool succeed = false;
    unsigned int wait;
    u32 reg_val, value;

    if (!fxgmac_efuse_read_regionA_regionB(pdata, EFUSE_OOB_ADDR, &reg_val)) {
        return succeed;
    }

    if (FXGMAC_GET_REG_BITS(reg_val, EFUSE_OOB_POS, EFUSE_OOB_LEN)) {
        FXGMAC_PR("OOB Ctrl bit already exists");
        return true;
    }

    value = 0;
    value = FXGMAC_SET_REG_BITS(value, EFUSE_OOB_POS, EFUSE_OOB_LEN, 1);

    reg_val = 0;
    reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_ADDR_POS, EFUSE_OP_ADDR_LEN, EFUSE_OOB_ADDR);
    reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_WR_DATA_POS, EFUSE_OP_WR_DATA_LEN, value & 0xFF);
    reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_START_POS, EFUSE_OP_START_LEN, 1);
    reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_MODE_POS, EFUSE_OP_MODE_LEN, EFUSE_OP_MODE_ROW_WRITE);
    writereg(pdata->pAdapter, reg_val, pdata->base_mem + EFUSE_OP_CTRL_0);

    wait = 1000;
    while (wait--) {
        usleep_range_ex(pdata->pAdapter, 20, 50);
        reg_val = readreg(pdata->pAdapter, pdata->base_mem + EFUSE_OP_CTRL_1);
        if (FXGMAC_GET_REG_BITS(reg_val, EFUSE_OP_DONE_POS, EFUSE_OP_DONE_LEN)) {
            succeed = true;
            break;
        }
    }

    if (!succeed) {
        FXGMAC_PR("Fail to writing efuse Byte OOB");
    }

    return succeed;
}

bool fxgmac_efuse_write_led(struct fxgmac_pdata* pdata, u32 value)
{
    bool succeed = false;
    unsigned int wait;
    u32 reg_val;

    if (!fxgmac_efuse_read_regionA_regionB(pdata, EFUSE_LED_ADDR, &reg_val)) {
        return succeed;
    }

    if (reg_val == value) {
        FXGMAC_PR("Led Ctrl option already exists");
        return true;
    }

    reg_val = 0;
    reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_ADDR_POS, EFUSE_OP_ADDR_LEN, EFUSE_LED_ADDR);
    reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_WR_DATA_POS, EFUSE_OP_WR_DATA_LEN, value & 0xFF);
    reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_START_POS, EFUSE_OP_START_LEN, 1);
    reg_val = FXGMAC_SET_REG_BITS(reg_val, EFUSE_OP_MODE_POS, EFUSE_OP_MODE_LEN, EFUSE_OP_MODE_ROW_WRITE);
    writereg(pdata->pAdapter, reg_val, pdata->base_mem + EFUSE_OP_CTRL_0);

    wait = 1000;
    while (wait--) {
        usleep_range_ex(pdata->pAdapter, 20, 50);
        reg_val = readreg(pdata->pAdapter, pdata->base_mem + EFUSE_OP_CTRL_1);
        if (FXGMAC_GET_REG_BITS(reg_val, EFUSE_OP_DONE_POS, EFUSE_OP_DONE_LEN)) {
            succeed = true;
            break;
        }
    }

    if (!succeed) {
        FXGMAC_PR("Fail to writing efuse Byte LED");
    }

    return succeed;
}