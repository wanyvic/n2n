ACLOCAL_AMFLAGS = -I build-aux/m4
lib_LTLIBRARIES =
lib_LTLIBRARIES += libn2n.la
include_HEADERS = ../include/n2n.h ../include/n2n_wire.h ../include/sglib.h
noinst_HEADERS = 
noinst_HEADERS += lzoconf.h
noinst_HEADERS += lzodefs.h
noinst_HEADERS += minilzo.h
noinst_HEADERS += n2n_keyfile.h
noinst_HEADERS += n2n_transforms.h
noinst_HEADERS += scm.h
noinst_HEADERS += twofish.h

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = libn2n.pc

libn2n_la_SOURCES = n2n.c \
                n2n_keyfile.c \
                wire.c \
                minilzo.c \
                twofish.c \
                transform_null.c \
                transform_tf.c \
                transform_aes.c \
                tuntap_freebsd.c \
                tuntap_netbsd.c \
                tuntap_linux.c \
                tuntap_osx.c \
                version.c
if WINDOWS
    libn2n_la_SOURCES += ../win32/win-scm.c
else 
    libn2n_la_SOURCES += unix-scm.c
endif
libn2n_la_CFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src
libn2n_la_LIBADD =

bin_PROGRAMS =
noinst_PROGRAMS =
if USE_BENCHMARK
noinst_PROGRAMS += benchmark benchmark_hashtable
benchmark_SOURCES = benchmark.c
benchmark_LDADD = libn2n.la
benchmark_CFLAGS = -static
benchmark_hashtable_SOURCES = benchmark_hashtable.c
benchmark_hashtable_LDADD = libn2n.la
benchmark_hashtable_CFLAGS = -static
endif

if USE_TEST
noinst_PROGRAMS += n2n_test
n2n_test_SOURCES = n2n_test.c
n2n_test_LDADD = libn2n.la
n2n_test_CFLAGS = -static
TESTS = n2n_test
endif

if USE_EXECUTALE
noinst_PROGRAMS += edge supernode
edge_SOURCES = edge.c
edge_LDADD = libn2n.la
edge_CFLAGS = -static
supernode_SOURCES = sn.c
supernode_LDADD = libn2n.la
supernode_CFLAGS = -static
endif

EXTRA_DIST = autogen.sh
