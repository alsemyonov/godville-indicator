# Process this file with autoconf to produce a configure script.
AC_PREREQ([2.64])
AC_INIT([godville],
        [0.1.0],
        [al@semyonov.us],
        [godville])
AC_CONFIG_SRCDIR([Makefile.am])
AC_CONFIG_HEADERS(config.h)
AM_INIT_AUTOMAKE([dist-bzip2])
AM_MAINTAINER_MODE

AC_PROG_CC
AM_PROG_CC_C_O
AC_DISABLE_STATIC
AC_PROG_LIBTOOL

AC_PATH_PROG(VALAC, valac, valac)
AC_SUBST(VALAC)

AH_TEMPLATE([GETTEXT_PACKAGE], [Package name for gettext])
GETTEXT_PACKAGE=godville
AC_DEFINE_UNQUOTED(GETTEXT_PACKAGE, "$GETTEXT_PACKAGE")
AC_SUBST(GETTEXT_PACKAGE)
AM_GLIB_GNU_GETTEXT
IT_PROG_INTLTOOL([0.35.0])

AC_SUBST(CFLAGS)
AC_SUBST(CPPFLAGS)
AC_SUBST(LDFLAGS)

GLIB_REQUIRED=2.12.0
GTK_REQUIRED=2.18.0
SOUP_REQUIRED=2.34.0
XML_REQUIRED=2.7.8
APPINDICATOR_REQUIRED=0.3.0
LIBNOTIFY_REQUIRED=0.5.0

PKG_CHECK_MODULES(GODVILLE, \
                  glib-2.0 >= $GLIB_REQUIRED \
                  gobject-2.0 >= $GLIB_REQUIRED \
                  gtk+-2.0 >= $GTK_REQUIRED \
                  libsoup-2.4 >= $SOUP_REQUIRED \
                  libxml-2.0 >= $XML_REQUIRED \
                  appindicator-0.1 >= $APPINDICATOR_REQUIRED \
                  libnotify >= $LIBNOTIFY_REQUIRED
                 )
AC_SUBST(GODVILLE_CFLAGS)
AC_SUBST(GODVILLE_LIBS)

GLIB_GSETTINGS

AC_CONFIG_FILES([Makefile
	src/Makefile
	data/Makefile
	data/icons/Makefile
	data/icons/16x16/Makefile
	po/Makefile.in])

AC_OUTPUT
