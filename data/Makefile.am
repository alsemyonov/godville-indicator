NULL =

SUBDIRS = pixmaps

@INTLTOOL_DESKTOP_RULE@
desktopdir = $(datadir)/applications
desktop_in_files = godville.desktop.in
desktop_DATA = $(desktop_in_files:.desktop.in=.desktop)

godville_SCHEMAS = net.godville.Indicator.gschema.xml
@GSETTINGS_RULES@

EXTRA_DIST = \
	$(desktop_in_files) \
	net.godville.indicator.gschema.xml \
	$(NULL)

clean-local :
	rm -f *~

DISTCLEANFILES = \
	godville.desktop \
	$(NULL)
