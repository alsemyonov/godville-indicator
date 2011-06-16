NULL =

SUBDIRS = icons

@INTLTOOL_DESKTOP_RULE@
desktopdir = $(datadir)/applications
desktop_in_files = godville.desktop.in
desktop_DATA = $(desktop_in_files:.desktop.in=.desktop)

gsettings_SCHEMAS = net.godville.indicator.gschema.xml
@GSETTINGS_RULES@

EXTRA_DIST = \
	$(desktop_in_files) \
	$(gsettings_SCHEMAS) \
	$(NULL)

clean-local :
	rm -f *~

DISTCLEANFILES = \
	godville.desktop \
	$(NULL)
