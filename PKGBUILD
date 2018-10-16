# Maintainer: Anton Semjonov <anton@semjonov.de>

pkgname="mksignkernels-git"
_pkgname=(${pkgname%-git})
pkgdesc="Bundle and sign your kernel for SecureBoot-enabled systems."

pkgver=0.0.3.r0.4e987aa
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

sha256sums=('4e4bb0ab4477861383bfd68a590a5ef21ef0e65808f69009787e403f2762a7e1'
            '4c7f50365711d612980c922055cb873e9aceae260a464eb1d55ca9b553192468'
            'a6ab20fa24a8ef0f85f3b0c372f63f9cb76a93f82c1eec8eba806de1fa983c39'
            '4b344f66b715e327ec52807663f2e343f5c470c54e462b1285cafacb4c28ab84'
            '3ea9492e5613920e2239ff18a59366c9897233718262a00b3885034bb284d53b')
