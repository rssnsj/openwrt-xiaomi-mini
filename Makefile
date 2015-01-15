#
#
xiaomi_root = $(shell pwd)
openwrt_dir = openwrt-ramips
packages_required = build-essential git flex gettext libncurses5-dev \
  unzip gawk liblzma-dev u-boot-tools
openwrt_feeds = libevent2 luci luci-app-samba xl2tpd pptpd pdnsd ntfs-3g
### mwan3 luci-app-mwan3

s_build_openwrt: s_install_feeds
	@cd $(openwrt_dir); \
		if [ -e .config ]; then \
			mv -vf .config .config.bak; \
			echo "WARNING: .config is updated, backed up as '.config.bak'"; \
		fi; \
		cp -vf ../config-xiaomi-mini .config
	make -C $(openwrt_dir) V=s -j4

s_install_feeds: s_update_feeds
	@cd $(openwrt_dir); ./scripts/feeds install $(openwrt_feeds);
	@git clone https://github.com/rssnsj/openwrt-feeds.git $(openwrt_dir)/package/rssnsj-feeds
	@touch s_install_feeds

s_update_feeds: s_xiaomi_patch
	@cd $(openwrt_dir); ./scripts/feeds update;
	@touch s_update_feeds

s_xiaomi_patch: s_checkout_svn
	@cd $(openwrt_dir); cat ../patches/*.patch | patch -p0
	@cp -vf config-xiaomi-mini $(openwrt_dir)/.config
	@touch s_xiaomi_patch

# 2. Checkout source code:
s_checkout_svn: s_check_hostdeps
	svn co svn://svn.openwrt.org/openwrt/branches/barrier_breaker $(openwrt_dir) -r43770
	@[ -d /var/dl ] && ln -sf /var/dl $(openwrt_dir)/dl || :
	@touch s_checkout_svn

s_check_hostdeps:
# 1. Install required host components:
	@which dpkg >/dev/null 2>&1 || exit 0; \
	for p in $(packages_required); do \
		dpkg -s $$p >/dev/null 2>&1 || to_install="$$to_install$$p "; \
	done; \
	if [ -n "$$to_install" ]; then \
		echo "Please install missing packages by running the following commands:"; \
		echo "  sudo apt-get update"; \
		echo "  sudo apt-get install -y $$to_install"; \
		exit 1; \
	fi;
	@touch s_check_hostdeps

menuconfig: s_install_feeds
	@cd $(openwrt_dir); [ -f .config ] && mv -vf .config .config.bak || :
	@cp -vf config-xiaomi-mini $(openwrt_dir)/.config
	@touch config-xiaomi-mini  # change modification time
	@make -C $(openwrt_dir) menuconfig
	@[ $(openwrt_dir)/.config -nt config-xiaomi-mini ] && cp -vf $(openwrt_dir)/.config config-xiaomi-mini || :

clean:
	rm -f s_build_openwrt
	make clean -C $(openwrt_dir) V=s

