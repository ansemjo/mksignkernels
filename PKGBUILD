# Maintainer: Anton Semjonov <anton@semjonov.de>

pkgname="mksignkernels"
pkgdesc="Bundle and sign your kernel for SecureBoot-enabled systems."

pkgver=0.0.2
pkgrel=1

arch=('any')
url="https://github.com/ansemjo/$pkgname"
license=('MIT')

depends=('systemd' 'bash' 'make' 'binutils' 'sbsigntools')
makedepends=('make')

provides=($pkgname)
conflicts=($pkgname)
backup=("etc/$pkgname.mk")
source=("$pkgname"
        "$pkgname.mk"
        "96-$pkgname.hook"
        "README.md"
        "install.mk")
package() {
	make -f install.mk DESTDIR="$pkgdir/" install
}
sha256sums=('f8002970c3c84b918f0919708e0878e005e8990da083876136d3237e3f4c9fd1'
            '4c7f50365711d612980c922055cb873e9aceae260a464eb1d55ca9b553192468'
            'a6ab20fa24a8ef0f85f3b0c372f63f9cb76a93f82c1eec8eba806de1fa983c39'
            '4b344f66b715e327ec52807663f2e343f5c470c54e462b1285cafacb4c28ab84'
            '3ea9492e5613920e2239ff18a59366c9897233718262a00b3885034bb284d53b')
