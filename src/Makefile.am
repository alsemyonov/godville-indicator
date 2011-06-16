NULL =

AM_CPPFLAGS = \
	$(GODVILLE_CFLAGS) \
	-include $(CONFIG_HEADER) \
	$(NULL)

bin_PROGRAMS = godville

godville_SOURCES = \
	godville.vala \
	godville-indicator.vala \
	godville-status.vala \
	#godville-application_window.vala \
	$(NULL)

godville_VALAFLAGS = --pkg gtk+-2.0 --pkg libsoup-2.4 --pkg libxml-2.0 --pkg appindicator-0.1 --pkg libnotify

godville_LDADD = \
	$(GODVILLE_LIBS) \
	$(NULL)

EXTRA_DIST = \
	$(NULL)

DISTCLEANFILES = \
	$(NULL)

