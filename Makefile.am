NULL =

#Build in these directories:

SUBDIRS = \
	data \
	src \
	po \
	$(NULL)

godvilledocdir = ${prefix}/doc/godville
godvilledoc_DATA = \
	ChangeLog \
	README \
	COPYING \
	AUTHORS \
	INSTALL \
	NEWS\
	$(NULL)

EXTRA_DIST = \
	$(godville_SCHEMAS) \
	$(godvilledoc_DATA) \
	intltool-extract.in \
	intltool-merge.in \
	intltool-update.in\
	$(NULL)

DISTCLEANFILES = \
	intltool-extract \
	intltool-merge \
	intltool-update \
	po/.intltool-merge-cache \
	$(NULL)

