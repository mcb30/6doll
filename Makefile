ARCH	= ramips
TARGET	= mt76x8
PROFILE	= glinet_microuter-n300
HOST	= Linux-x86_64

BASE_URL = https://downloads.openwrt.org/snapshots/targets/$(ARCH)/$(TARGET)

BUILDER = openwrt-imagebuilder-$(ARCH)-$(TARGET).$(HOST)
BUILDER_TAR = $(BUILDER).tar.xz
BUILDER_URL = $(BASE_URL)/$(BUILDER_TAR)

SYSUPGRADE_BIN = openwrt-$(ARCH)-$(TARGET)-$(PROFILE)-squashfs-sysupgrade.bin

all : $(SYSUPGRADE_BIN)

$(BUILDER_TAR) :
	wget $(BUILDER_URL)

.SECONDARY : $(BUILDER_TAR)

$(BUILDER)/Makefile : $(BUILDER_TAR)
	$(RM) -r $(BUILDER)
	tar xvf $(BUILDER_TAR)
	touch $@

$(SYSUPGRADE_BIN) : $(BUILDER)/Makefile
	$(MAKE) -C $(BUILDER) PROFILE=$(PROFILE) \
		PACKAGES="miredo kmod-ipt-nat6 luci" \
		FILES="$(shell pwd)/files" \
		image
	cp $(BUILDER)/bin/targets/$(ARCH)/$(TARGET)/$@ $@

install : $(SYSUPGRADE_BIN)
	curl --form firmware=@$< --form submit=1 http://192.168.1.1

clean :
	$(RM) -r $(BUILDER)
	$(RM) $(SYSUPGRADE_BIN)
