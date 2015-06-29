# mup #

mup is a perl interface to [mu](http://www.djcbsoftware.nl/code/mu/)
([GitHub](https://github.com/djcb/mu)), a Maildir indexing and
search system that also implements the core functionality needed
by pretty much any MUA.

mup replicates the API described in the
[mu-server(1)](http://manpages.ubuntu.com/manpages/precise/man1/mu-server.1.html) man page in a pleasingly Perly style.

## Tests ##

I use standard perl testing stuff (`Test::More`).  The tests all
operate on a temporary Maildir/mu index created by `t/lib.pm`.  If you
are interested in hacking on or understanding the tests you should
first look at t/lib.pm to see how the temporary setup is created and
torn down.  All tests should have

    use t::lib;

in them somewhere near the top.  This is all that is necessary to make
sure the code in the test does not e.g. hose down your actual
~/Maildir and/or ~/.mu.
