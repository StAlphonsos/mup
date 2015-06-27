# mup - perl interface to mu

use ExtUtils::MakeMaker;
do "./lib/mup.pm";

sub SRC { "lib/@_" }
sub DST { '$(INST_LIBDIR)/'."@_" }
sub PAIR { ( SRC(@_) => DST(@_) ) }

print STDERR "Welcome to mup $mup::VERSION\n\n";
WriteMakefile(
    AUTHOR => 'attila <attila@stalphonsos.com>',
    ABSTRACT => 'perl interface to mu',
    NAME => 'mup',
    VERSION_FROM => 'lib/mup.pm',
    PREREQ_PM => {
	'Data::SExpression' => 0,
	'IPC::Open2' => 0,
	'Moose' => 0,
	'namespace::clean' => 0,
    },
    PM => {
	PAIR('mup.pm'),
    }
);
sub MY::postamble {
    print STDERR "To install completely:\n";
    print STDERR "    \$ make\n    \$ sudo make install\n";
    print STDERR "\nDon't forget to read the README and the POD.\n";
    print STDERR "Examples will be installed somehwere like /usr/local/share/examples/flail\nThey are also in the eg/ subdirectory of this distribution.\n\nEat your veggies.\n\n";
    return <<__MyTaRgEt__;
OPENSSLCMD?=openssl
MD5CMD?=\$(OPENSSLCMD) dgst -md5
SHA1CMD?=\$(OPENSSLCMD) dgst -sha1
RIPEMD160CMD?=\$(OPENSSLCMD) dgst -ripemd160
GPGCMD?=gpg
GPGKEYID?=0x4FFCBB9C
RELEASEDIR?=\$\$HOME/release
RELEASETARBALL?=\$(NAME)-\$(VERSION).tar.gz
RELEASEFILES?=\$(RELEASETARBALL) \$(NAME)-\$(VERSION).tar.gz.md5 \$(NAME)-\$(VERSION).tar.gz.sha1 \$(NAME)-\$(VERSION).tar.gz.ripemd160 \$(NAME)-\$(VERSION).tar.gz.asc
RELEASETARGETS?=dist md5 sha1 ripemd160 asc
RM?=/bin/rm
SHAREDIR?=\$(PREFIX)/share
EXAMPLEDIR?=\$(SHAREDIR)/examples/\$(NAME)
EXAMPLES?=eg
MKDIR_P?=mkdir -p

clean::
	\$(RM) -f *.flc *.bak *~ .tec*

force-releasefiles: cleanrelease releasefiles

distclean:: cleanrelease

install :: \$(EXAMPLEDIR)
	\$(CP) dot.flailrc \$(EXAMPLEDIR)
	(cd \$(EXAMPLES); \$(TAR) cf - `grep eg/ ../MANIFEST | sed -e 's|eg/||'`) | (cd \$(EXAMPLEDIR); \$(TAR) xf -)

\$(EXAMPLEDIR) :
	\$(MKDIR_P) \$(EXAMPLEDIR)

cleanrelease:
	-\$(RM) -f \$(RELEASEFILES)

releasefiles: \$(RELEASETARGETS)

release: releasefiles
	\@-[ -d \$(RELEASEDIR) ] && \$(MV) \$(RELEASEFILES) \$(RELEASEDIR)
	\@echo Moved release files to \$(RELEASEDIR): \$(RELEASEFILES)

md5: \$(RELEASETARBALL)
	\$(MD5CMD) \$(NAME)-\$(VERSION).tar.gz > \$(NAME)-\$(VERSION).tar.gz.md5

sha1: \$(RELEASETARBALL)
	\$(SHA1CMD) \$(NAME)-\$(VERSION).tar.gz > \$(NAME)-\$(VERSION).tar.gz.sha1

ripemd160: \$(RELEASETARBALL)
	\$(RIPEMD160CMD) \$(NAME)-\$(VERSION).tar.gz > \$(NAME)-\$(VERSION).tar.gz.ripemd160

asc: \$(RELEASETARBALL)
	\$(GPGCMD) --sign --default-key \$(GPGKEYID) --detach --armor \$(NAME)-\$(VERSION).tar.gz
__MyTaRgEt__
}
