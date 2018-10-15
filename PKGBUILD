# Maintainer: Anton Semjonov <anton@semjonov.de>

pkgname="mksignkernels"
pkgdesc="Bundle and sign your kernel for SecureBoot-enabled systems."

pkgver=0.0.1
pkgrel=1

arch=('any')
url="https://github.com/ansemjo/$pkgname"
license=('MIT')

depends=('systemd' 'make' 'binutils' 'sbsigntools')
makedepends=('make')

provides=($pkgname)
conflicts=($pkgname)
backup=("etc/$pkgname.mk")
source=("$pkgname"
        "$pkgname.mk"
        "README.md"
        "install.mk")
package() {
	make -f install.mk DESTDIR="$pkgdir/" install
}
sha256sums=('f8002970c3c84b918f0919708e0878e005e8990da083876136d3237e3f4c9fd1'
            '4c7f50365711d612980c922055cb873e9aceae260a464eb1d55ca9b553192468'
            '1d9f29f0336cfea336e9257d5e43fabe8358c5464b89687700346ef3433748f1'
            '3e0c0a7862937e28065b9fa7baad1976d870505180500745000577ed6e09b9c8')
