#! /bin/bash
set -euvxo pipefail
(( $# == 1 ))
[[ -n "$1" ]]

export CPPFLAGS="-DNDEBUG $CPPFLAGS"

if (( $1 == 1 )) ; then
  sleep 91
  git clone --depth=1 --recursive -b curl-7_74_0 https://github.com/curl/curl.git ||
fi
cd                        curl
autoreconf -fi
./configure --prefix=$PREFIX                      \
        --target=$CHOST           \
        --host=$CHOST             \
	--with-zlib="$PREFIX"                         \
	--with-ssl="$PREFIX"                          \
        --disable-shared                              \
	--enable-static                               \
	--enable-optimize                             \
	--disable-curldebug                           \
	--disable-ares                                \
	--disable-rt                                  \
	--disable-ech                                 \
	--disable-largefile                           \
	--enable-http                                 \
	--disable-ftp                                 \
	--disable-file                                \
	--disable-ldap                                \
	--disable-ldaps                               \
	--disable-rtsp                                \
	--enable-proxy                                \
	--disable-dict                                \
	--disable-telnet                              \
	--disable-tftp                                \
	--disable-pop3                                \
	--disable-imap                                \
	--disable-smb                                 \
	--disable-smtp                                \
	--disable-gopher                              \
	--disable-mqtt                                \
	--disable-manual                              \
	--disable-libcurl-option                      \
	--disable-ipv6                                \
	--disable-sspi                                \
	--disable-crypto-auth                         \
	--disable-ntlm-wb                             \
	--disable-tls-srp                             \
	--disable-unix-sockets                        \
	--disable-cookies                             \
	--disable-socketpair                          \
	--disable-http-auth                           \
	--disable-doh                                 \
	--disable-mine                                \
	--disable-dataparse                           \
	--disable-netrc                               \
	--disable-progress-meter                      \
	--disable-alt-svc                             \
	--disable-hsts                                \
	--without-brotli                              \
	--without-zstd                                \
	--without-winssl                              \
	--without-schannel                            \
	--without-darwinssl                           \
	--without-secure-transport                    \
	--without-amissl                              \
	--without-gnutls                              \
	--without-mbedtls                             \
	--without-wolfssl                             \
	--without-mesalink                            \
	--without-bearssl                             \
	--without-nss                                 \
	--without-libpsl                              \
	--without-libmetalink                         \
	--without-librtmp                             \
	--without-winidn                              \
	--without-libidn2                             \
	--without-nghttp2                             \
	--without-ngtcp2                              \
	--without-nghttp3                             \
	--without-quiche                              \
	--disable-threaded-resolver                   \
	CPPFLAGS="$CPPFLAGS"                          \
	CXXFLAGS="$CXXFLAGS"                          \
	CFLAGS="$CFLAGS"                              \
	LDFLAGS="$LDFLAGS"                            \
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
  rm -rf curl
  rm -v "$0"
fi
rm -v $PREFIX/bin/*curl*

