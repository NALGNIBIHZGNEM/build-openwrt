#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt
# Function: Diy script (After Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/immortalwrt/immortalwrt / Branch: master
#========================================================================================================================

# ------------------------------- Main source started -------------------------------
#
# Add the default password for the 'root' user（Change the empty password to 'password'）
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.::0:99999:7:::/g' package/base-files/files/etc/shadow

# Set etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='GBC$(date +%Y.%m.%d)'|g" package/base-files/files/etc/openwrt_release
echo "DISTRIB_SOURCECODE='immortalwrt'" >>package/base-files/files/etc/openwrt_release


# Modify default IP（FROM 192.168.1.1 CHANGE TO 192.168.66.253）
# sed -i 's/192.168.1.1/192.168.31.4/g' package/base-files/files/bin/config_generate
# 修改默认IP地址
sed -i 's/192.168.1.1/192.168.66.253/g' package/base-files/files/bin/config_generate

# 修改主机名
sed -i "s/hostname='OpenWrt'/hostname='GBC'/g" package/base-files/files/bin/config_generate
# 修改设备说明
sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION='GBC $(date +"%y%m%d")'/g" package/base-files/files/etc/openwrt_release
# 写入设备型号
echo "DISTRIB_MODEL='X86_64'" >> package/base-files/files/etc/openwrt_release





# Modify default IP（FROM 192.168.1.1 CHANGE TO 192.168.31.4）
# sed -i 's/192.168.1.1/192.168.31.4/g' package/base-files/files/bin/config_generate
#
# ------------------------------- Main source ends -------------------------------

# ------------------------------- Other started -------------------------------
#
# Add luci-app-amlogic
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic

# Apply patch
# git apply ../config/patches/{0001*,0002*}.patch --directory=feeds/luci
#
# ------------------------------- Other ends -------------------------------

