#!/bin/bash
# rm -rf feeds/packages/net/v2ray-geodata
# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# Default IP
sed -i 's/192.168.1.1/192.168.110.247/g' package/base-files/files/bin/config_generate

# Remove packages
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/applications/luci-app-passwall2

# Add packages
git clone --depth=1 https://github.com/ophub/luci-app-amlogic package/amlogic
git_sparse_clone main https://github.com/xiaorouji/openwrt-passwall luci-app-passwall
git_sparse_clone main https://github.com/xiaorouji/openwrt-passwall2 luci-app-passwall2
git_sparse_clone main https://github.com/kenzok8/small-package luci-app-store
git_sparse_clone main https://github.com/morytyann/OpenWrt-mihomo luci-app-mihomo mihomo


