# template for a custom kernel:
#
# CUSTOMKERNELS += kernel-custom
# kernel-custom :
# 	@$(SELF) $(ESP)/vmlinuz-custom.efi \
# 		EFISTUB="$(EFISTUB)" \
# 		OSREL="$(OSREL)" \
# 		KEY="$(KEY)" \
# 		CERT="$(CERT)" \
# 		KERNEL="$(BOOT)/vmlinuz" \
# 		INITRAMFS="$(MICROCODE) $(BOOT)/initramfs-linux-custom.img" \
# 		CMDLINE="custom_cmdline"
#
# if your custom kernel conforms to the default kernel-% target
# and you only want to change few settings, e.g. the cmdline, use:
#
# CUSTOMKERNELS += kernel-linux
# kernel-linux:
# 	@$(SELF) $(ESP)/vmlinuz-linux.efi \
# 		CMDLINE="other_settings"

# -------- custom targets --------

CUSTOMKERNELS += kernel-linux-fallback
kernel-linux-fallback :
	@$(SELF) $(ESP)/vmlinuz-linux-fallback.efi \
		KERNEL="$(BOOT)/vmlinuz-linux"

CUSTOMKERNELS += kernel-custom
kernel-custom :
	@$(SELF) $(ESP)/vmlinuz-custom.efi \
		EFISTUB="$(EFISTUB)" \
		OSREL="$(OSREL)" \
		KEY="$(KEY)" \
		CERT="$(CERT)" \
		KERNEL="$(BOOT)/vmlinuz" \
		INITRAMFS="$(MICROCODE) $(BOOT)/initramfs-linux.img" \
		CMDLINE="custom_cmdline"
