ACLOCAL_AMFLAGS = -I build-aux/m4

lib_LTLIBRARIES = libn2n.la
include_HEADERS = include/n2n.h include/n2n_wire.h include/sglib.h
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
                
if NN2N_LINUX
libn2n_la_SOURCES += unix-scm.c
endif
#if NN2N_WIN32
#libn2n_la_SOURCES += ../win32/win-scm.c
#endif
libn2n_la_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src
libn2n_la_LIBADD = $(SECP_LIBS)


noinst_PROGRAMS =
if USE_BENCHMARK
noinst_PROGRAMS += benchmark benchmark_hashtable
benchmark_SOURCES = benchmark.c
benchmark_LDADD = libn2n.la $(SECP_LIBS)
benchmark_hashtable_SOURCES = benchmark_hashtable.c
benchmark_hashtable_LDADD = libn2n.la $(SECP_LIBS)
endif

if USE_TESTS
noinst_PROGRAMS += n2n_tests
n2n_tests_SOURCES = n2n_tests.c
n2n_tests_CPPFLAGS = -DVERIFY -I$(top_srcdir)/src -I$(top_srcdir)/include $(SECP_TEST_INCLUDES)
n2n_tests_LDADD = libn2n.la $(SECP_LIBS)
n2n_tests_LDFLAGS = -static
TESTS = n2n_tests
endif

EXTRA_DIST = autogen.sh
