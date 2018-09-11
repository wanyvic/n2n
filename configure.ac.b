#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])

define(_N2N_VERSION,2.1.0)
AC_INIT([libn2n], [_N2N_VERSION], [https://github.com/wanyvic/libn2n])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([build-aux/m4])
LIBTOOL=”＄LIBTOOL --silent”
AC_CANONICAL_SYSTEM

build_linux=no
build_windows=no
build_mac=no

# Detect the target system
case "${host_os}" in
    linux*)
        build_linux=yes
        AC_DEFINE(N2N_OSNAME, [linux-gnu], [os name])
        AC_SUBST(NN2N_OSNAME, [linux-gnu])
        
        AC_SUBST(NN2N_VERSION,[v2.1.0])
        ;;
    cygwin*|mingw*)
        build_windows=yes
        ;;
    darwin*)
        build_mac=yes
        ;;
    *)
        AC_MSG_ERROR(["OS $host_os is not supported"])
        ;;
esac

# Pass the conditionals to automake
AM_CONDITIONAL([LINUX], [test "$build_linux" = "yes"])
AM_CONDITIONAL([WINDOWS], [test "$build_windows" = "yes"])
AM_CONDITIONAL([OSX], [test "$build_mac" = "yes"])

AM_INIT_AUTOMAKE([libn2n],[_N2N_VERSION])
AC_CONFIG_SRCDIR([src/sn.c])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile
           	src/Makefile])
define(_N2N_OSNAME,$host_os)
AC_DEFINE(N2N_VERSION, _N2N_VERSION, [project version])
AC_ARG_ENABLE([executale],
  [AS_HELP_STRING([--enable-executale],
  [enable build executale (disabled by default)])],
  [enable_wallet=$enableval],
  [enable_wallet=no])

CPPFLAGS="$CPPFLAGS -DN2N_VERSION=$NN2N_VERSION -DN2N_OSNAME=$NN2N_OSNAME"
# Checks for programs.
AC_PROG_CC
AC_PROG_INSTALL

# Checks for libraries.
AC_CHECK_LIB([ssl],         [main],SSL_LIBS=-lssl, AC_MSG_ERROR(libssl missing))

# Checks for header files.

AC_CHECK_HEADER([openssl/ssl.h],, AC_MSG_ERROR(libssl headers missing),)
AC_CHECK_HEADERS([arpa/inet.h fcntl.h inttypes.h libintl.h limits.h netdb.h netinet/in.h stddef.h stdint.h stdlib.h string.h strings.h sys/ioctl.h sys/param.h sys/socket.h sys/time.h syslog.h unistd.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_CHECK_HEADER_STDBOOL
AC_TYPE_UID_T
AC_TYPE_INT16_T
AC_TYPE_INT32_T
AC_TYPE_INT64_T
AC_TYPE_INT8_T
AC_TYPE_SIZE_T
AC_TYPE_SSIZE_T
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T
AC_TYPE_UINT8_T
AC_CHECK_TYPES([ptrdiff_t])

# Checks for library functions.
AC_FUNC_MALLOC
AC_FUNC_REALLOC
AC_CHECK_FUNCS([gettimeofday memmove memset select socket strchr strdup strerror strpbrk strtol strtoul])
AC_OUTPUT
