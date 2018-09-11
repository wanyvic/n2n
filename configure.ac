AC_PREREQ([2.69])
AC_INIT([libn2n],[0.1])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([build-aux/m4])
AC_CANONICAL_HOST
AH_TOP([#ifndef LIBN2N_CONFIG_H])
AH_TOP([#define LIBN2N_CONFIG_H])
AH_BOTTOM([#endif /*LIBN2N_CONFIG_H*/])
AM_INIT_AUTOMAKE([foreign subdir-objects])
LT_INIT

dnl make the compilation flags quiet unless V=1 is used
m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])

PKG_PROG_PKG_CONFIG

AC_PATH_TOOL(AR, ar)
AC_PATH_TOOL(RANLIB, ranlib)
AC_PATH_TOOL(STRIP, strip)
AX_PROG_CC_FOR_BUILD

if test "x$CFLAGS" = "x"; then
  CFLAGS="-O3 -g"
fi

AM_PROG_CC_C_O

AC_PROG_CC_C99
if test x"$ac_cv_prog_cc_c99" = x"no"; then
  AC_MSG_ERROR([c99 compiler support required])
fi

# Detect the target system
case "${host_os}" in
    linux*)
        build_linux=yes
        AM_CONDITIONAL([NN2N_LINUX],[""])
        AC_SUBST(NN2N_VERSION,[v2.1.0])
        ;;
    cygwin*|mingw*)
        build_windows=yes

        AM_CONDITIONAL([NN2N_WIN32],[""])
        ;;
    darwin*)
        build_mac=yes
        AM_CONDITIONAL([NN2N_MAC],[""])
        ;;
    *)
        AC_MSG_ERROR(["OS $host_os is not supported"])
        ;;
esac

CFLAGS="$CFLAGS -W"

warn_CFLAGS="-std=c99 -pedantic -Wall -Wextra -Wcast-align -Wnested-externs -Wshadow -Wstrict-prototypes -Wno-unused-function -Wno-long-long -Wno-overlength-strings"
saved_CFLAGS="$CFLAGS"
CFLAGS="$CFLAGS $warn_CFLAGS"
AC_MSG_CHECKING([if ${CC} supports ${warn_CFLAGS}])
AC_COMPILE_IFELSE([AC_LANG_SOURCE([[char foo;]])],
    [ AC_MSG_RESULT([yes]) ],
    [ AC_MSG_RESULT([no])
      CFLAGS="$saved_CFLAGS"
    ])

saved_CFLAGS="$CFLAGS"
CFLAGS="$CFLAGS -fvisibility=hidden"
AC_MSG_CHECKING([if ${CC} supports -fvisibility=hidden])
AC_COMPILE_IFELSE([AC_LANG_SOURCE([[char foo;]])],
    [ AC_MSG_RESULT([yes]) ],
    [ AC_MSG_RESULT([no])
      CFLAGS="$saved_CFLAGS"
    ])

AC_ARG_ENABLE(benchmark,
    AS_HELP_STRING([--enable-benchmark],[compile benchmark (default is no)]),
    [use_benchmark=$enableval],
    [use_benchmark=no])

AC_ARG_ENABLE(tests,
    AS_HELP_STRING([--enable-tests],[compile tests (default is no)]),
    [use_tests=$enableval],
    [use_tests=no])

AC_ARG_ENABLE([executale],
  [AS_HELP_STRING([--enable-executale],
  [enable build executale (disabled by default)])],
  [enable_wallet=$enableval],
  [enable_wallet=no])

AC_MSG_CHECKING([for __builtin_expect])
AC_COMPILE_IFELSE([AC_LANG_SOURCE([[void myfunc() {__builtin_expect(0,0);}]])],
    [ AC_MSG_RESULT([yes]);AC_DEFINE(HAVE_BUILTIN_EXPECT,1,[Define this symbol if __builtin_expect is available]) ],
    [ AC_MSG_RESULT([no])
    ])

AC_C_BIGENDIAN()

AM_CONDITIONAL([USE_BENCHMARK], [test x"$use_benchmark" = x"yes"])
AM_CONDITIONAL([USE_TESTS], [test x"$use_tests" = x"yes"])
AC_CONFIG_HEADERS([src/libn2n-config.h])
AC_CONFIG_FILES([Makefile src/Makefile libn2n.pc])
AC_SUBST(SECP_LIBS)
AC_SUBST(SECP_TEST_LIBS)
AC_SUBST(SECP_TEST_INCLUDES)

dnl make sure nothing new is exported so that we don't break the cache
PKGCONFIG_PATH_TEMP="$PKG_CONFIG_PATH"
unset PKG_CONFIG_PATH
PKG_CONFIG_PATH="$PKGCONFIG_PATH_TEMP"

AC_OUTPUT
