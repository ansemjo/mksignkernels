# Maintainer: Anton Semjonov <anton@semjonov.de>

pkgname="mksignkernels-git"
_pkgname=(${pkgname%-git})
pkgdesc="Bundle and sign your kernel for SecureBoot-enabled systems."

pkgver=0.0.5
pkgrel=1

arch=('any')
url="https://github.com/ansemjo/$_pkgname"
license=('MIT')

depends=('systemd' 'bash' 'make' 'sed' 'binutils' 'sbsigntools')
makedepends=('make' 'git')

provides=($_pkgname)
conflicts=($_pkgname)
backup=("etc/$_pkgname.mk")
source=("$_pkgname"
        "$_pkgname.mk"
        "96-$_pkgname.hook"
        "README.md"
        "install.mk")

pkgver() {
  cd "$srcdir"
  printf "%s" "$(git describe --long | sed 's/\([^-]*-\)g/r\1/;s/-/./g')"

}

package() {
	make -f install.mk DESTDIR="$pkgdir/" install
}

sha256sums=('cb9f0b092b475e0c14211413dcde8c46e16cff6618facbaa959c335ab3694700'
            '4c7f50365711d612980c922055cb873e9aceae260a464eb1d55ca9b553192468'
            'e133c3b7b5028d8bb4a56f8672c5e3e7c38313048e550f67d238ba5ae85e6277'
            '4b344f66b715e327ec52807663f2e343f5c470c54e462b1285cafacb4c28ab84'
            '3ea9492e5613920e2239ff18a59366c9897233718262a00b3885034bb284d53b')
