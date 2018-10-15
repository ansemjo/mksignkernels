# mksignkernels

To take full control of you computer's SecureBoot platform you need to generate a custom set of
keys, install them in your computer's firmware and sign all binaries that should be trusted by your
bootloader with those keys. Information on SecureBoot in general can be found on Roderick W. Smith's
[pages][0] and various [wiki][1] [pages][2].

[0]: https://www.rodsbooks.com/efi-bootloaders/controlling-sb.html
[1]: https://wiki.archlinux.org/index.php/Secure_Boot
[2]: https://wiki.gentoo.org/wiki/Sakaki%27s_EFI_Install_Guide/Configuring_Secure_Boot
[3]: https://github.com/mjg59/efitools

## requirements

The makefile requires that `objcopy` and `sbsign` are present, which should be included in
`binutils` and `sbsigntools` packages respectively.

Furthermore the EFI stub included with `systemd-boot` is required. On most systems this should have
been installed with systemd itself.

## configure

A configuration file is installed in `/etc/mksignkernels.mk`. You can define custom kernel targets,
override the default ones or change global options like the target directory for signed kernels. The
possible options are explained within the file with samples for Arch Linux' common `-fallback`
kernel use case or a completely custom one.

Signing keys are expected in `/etc/efikeys`. This directory can also be configured. Keys can be
created with [mkefikeys](https://github.com/ansemjo/mkefikeys), for example.

## usage

To sign your kernels simply[¹](#simply) use `mksignkernels`. The makefile will detect if any changes
are necessary based on file timestamps.

    mksignkernels

If you want to be explicit, use the `kernels` target or specify a specific kernel target, e.g. for
`/boot/vmlinuz-linux` use `kernel-linux`:

    mksignkernels kernel-linux

Since it is a makefile, it also accepts any `make` options. To force a rebuild of all signed kernels
use the `-B`/`--always-make` flag. This is useful if you changed your `CMDLINE`, since this is not
detected by the makefile prerequisites.

    mksignkernels kernels --always-make

To sign single binaries, e.g. a `shellx64.efi` or your bootloader itself, use the `sign` target:

    mksignkernels sign SIGN=/boot/efi/shellx64.efi

## simply

Ok. It's not that simple. It is only that simple if you are using Arch Linux, the kernel names don't
change and everything fits the default `kernel-%` target. On Gentoo you should use `buildkernel` to
begin with as that can apparently create signed kernels by itself.

For any other distribution that installs new kernels with every update you probably need to override
the default `kernel-%` target and fix the globbing patterns / regular expressions in `HOOKTARGETS`
and `FOUNDKERNELS`. `HOOKTARGETS` is used in the hook mode, which is currently only used with
`pacman`. `FOUNDKERNELS` is built by a simple shell command and contains the names of all kernels
found in `$(BOOT)`. The name is then appended to `kernel-` and thus the default pattern rule is used
to bundle and sign the kernel.

For example: `ls /boot/vmlinuz-* | sed 's/.*\/vmlinuz-//'` finds the kernel `/boot/vmlinuz-linux`
and extracts the name `linux`. This is used to require the target `kernel-linux`. The pattern rule
uses `$*` in various places to substitute the name back into file paths and infer that the kernel
must have been `/boot/vmlinuz-linux`, the corresponding initramfs should be
`/boot/initramfs-linux.img` and the output file is `$(ESP)/vmlinuz-linux.efi`. Then the pattern rule
and actual signed kernel target `$(ESP)/vmlinuz-%.efi` is built in a submake with all the correct
variables set. You'll also need to modify that pattern if you want to name your output kernels
differently.

I use this sort of two-stage approach instead of directly requiring the target
`$(ESP)/vmlinuz-%.efi` because that makes it much easier to specify custom `kernel-whatever` targets
with only a few options overridden without the need to copy the full `objcopy ...` command every
time.

## efistub

Simply speaking, all of this works by concatenating the efi stub, kernel, (multiple) initramfs and
the cmdline into a single file. `objcopy` is used to give each part a predefined section name within
the executable, so the stub can find all it needs upon execution. By signing this entire bundle you
make sure that no part can be changed without Secureboot failing with an invalid signature.

This effectively foils Evil-Maid attacks and complements an encrypted root partition nicely.

## install

Install this programm with the included `install.mk` makefile. It optionally accepts a `DESTDIR`
argument for packaging:

    sudo make -f install.mk install DESTDIR=${pkgdir}

On Arch Linux you can also use the `PKGBUILD`:

    git clone ... && cd ...
    makepkg -i

## trivia

Be aware that testing your bundled kernels from an EFI shell with Secureboot disabled will probably
not work if you do not specify the kernel arguments on the shell commandline. The efi stub uses
arguments passed from the shell instead of the bundled `CMDLINE` in that case. And no arguments
result in an empty argument string. Either enable Secureboot (in which case your shell must be
signed as well) or specify a direct boot entry with `efibootmgr`. (see
[andreyv/sbupdate#4](https://github.com/andreyv/sbupdate/issues/4))

# LICENSE

```
MIT License

Copyright (c) 2018 Anton Semjonov

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
