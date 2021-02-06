#! /bin/bash
set -euvxo pipefail
(( $# == 1 ))
[[ -n "$1" ]]

export CPPFLAGS="-DNDEBUG -DCURL_STATICLIB $CPPFLAGS"

if (( $1 == 1 )) ; then
  sleep 91
  git clone --depth=1 --recursive -b release-2.1.12-stable https://github.com/libevent/libevent.git ||
fi
cd libevent
./autogen.sh
./configure \
  --target=$CHOST \
  --host=$CHOST \
  --prefix=$PREFIX \
  --disable-shared \
  --enable-static \
  --disable-mbedtls \
  --disable-debug-mode \
  --disable-samples \
  --enable-function-sections \
  --disable-largefile \
  --disable-doxygen-html \
  --with-curl=$PREFIX \
  --with-crypto=$PREFIX \
  CPPFLAGS="$CPPFLAGS" \
  CXXFLAGS="$CXXFLAGS" \
  CFLAGS="$CFLAGS" \
  LDFLAGS="$LDFLAGS" \
        CPATH="$CPATH"                                \
        C_INCLUDE_PATH="$C_INCLUDE_PATH"              \
        OBJC_INCLUDE_PATH="$OBJC_INCLUDE_PATH"        \
        LIBRARY_PATH="$LIBRARY_PATH"                  \
        LD_LIBRARY_PATH="$LD_LIBRARY_PATH"            \
        LD_RUN_PATH="$LD_RUN_PATH"                    \
        PKG_CONFIG_LIBDIR="$PKG_CONFIG_LIBDIR"        \
        PKG_CONFIG_PATH="$PKG_CONFIG_PATH"            \
        CC="$CC"                                      \
        CXX="$CXX"                                    \
        NM="$NM"                                      \
        AR="$AR"                                      \
        RANLIB="$RANLIB"
make
make install
if (( $1 == 1 )) ; then
  git reset --hard
  git clean -fdx
  git clean -fdx
fi
cd ..
if (( $1 == 2 )) ; then
  rm -rf libevent
  rm -v "$0"
fi

