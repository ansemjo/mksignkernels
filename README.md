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

## configure

A configuration file is installed in `/etc/mksignkernels.mk`. You can define custom kernel targets,
override the default ones or change global options like the target directory for signed kernels. The
possible options are explained within the file with samples for Arch Linux' common `-fallback`
kernel use case or a completely custom one.

Signing keys are expected in `/etc/efikeys`. This directory can also be configured. Keys can be
created with [mkefikeys](https://github.com/ansemjo/mkefikeys), for example.

## usage

To sign your kernels simply use `mksignkernels`. The makefile will detect if any changes are
necessary based on file timestamps.

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

## install

Install this programm with the included `install.mk` makefile. It optionally accepts a `DESTDIR`
argument for packaging:

    sudo make -f install.mk install DESTDIR=${pkgdir}

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
