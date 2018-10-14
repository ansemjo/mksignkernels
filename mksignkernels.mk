# Settings file for mksignkernels.
#
# --- Template for a custom kernel ---
#
# CUSTOMKERNELS += kernel-custom
# kernel-custom :
# 	@$(SELF) $(ESP)/vmlinuz-custom.efi \
# 		EFISTUB="$(EFISTUB)" \
# 		OSREL="$(OSREL)" \
# 		KEY="$(KEY)" \
# 		CERT="$(CERT)" \
# 		KERNEL="$(BOOT)/mykernel" \
# 		INITRAMFS="$(MICROCODE) $(BOOT)/myinitramfs.img" \
# 		CMDLINE="custom_cmdline"
#
# --- Small changes ---
#
# If your custom kernel conforms to the default kernel-% target and
# you only want to change a few settings, e.g. the cmdline or used
# kernel (useful for Arch Linux' -fallback targets), use:
#
# CUSTOMKERNELS += kernel-linux-fallback
# kernel-linux-fallback :
# 	@$(SELF) $(ESP)/vmlinuz-linux-fallback.efi \
# 		KERNEL="$(BOOT)/vmlinuz-linux"
#
# --- Global settings ---
#
# You can also change any of the global settings for all targets here:
#
# OSREL       = /etc/os-release
# EFISTUB     = /usr/lib/systemd/boot/efi/linuxx64.efi.stub
# PKI         = /etc/efikeys
# KEY         = $(PKI)/DatabaseKey.key
# CERT        = $(PKI)/DatabaseKey.crt
# BOOT        = /boot
# ESP         = $(BOOT)/efi
# MICROCODE	  = $(BOOT)/intel-ucode.img
# CMDLINE     = quiet
# HOOKTARGETS = boot/vmlinuz-(.*)
#
# -------- custom targets --------

