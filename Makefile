#

# to see need to update SUBS: make check
SUBS=
SUBS+=Q
SUBS+=bashy
SUBS+=batchlines
SUBS+=bbb
SUBS+=checkrun
SUBS+=cmpfast
SUBS+=count
SUBS+=dbm
SUBS+=ddrescue-verify
SUBS+=dirlist
SUBS+=diskus
SUBS+=gitstart
SUBS+=histogram
SUBS+=json2sh
SUBS+=kdmktone
SUBS+=keepcached
SUBS+=keypressed
SUBS+=killmem
SUBS+=macshim
SUBS+=md5chk
SUBS+=misc
SUBS+=mvatom
SUBS+=nonblocking
SUBS+=passfd
SUBS+=printansi
SUBS+=printargs
SUBS+=ptybuffer
SUBS+=run-until-change
SUBS+=shellshock
SUBS+=slowdown
SUBS+=socklinger
SUBS+=speedtests
SUBS+=sq
SUBS+=suid
SUBS+=timeout
SUBS+=tinohtmlparse
SUBS+=tinolib
SUBS+=tinoseq
SUBS+=unbuffered
SUBS+=watcher

# Well .. Debians
DEBS=
DEBS+=build-essential
DEBS+=libgdbm-dev libsqlite3-dev
DEBS+=autoconf libtool
DEBS+=gawk dietlibc-dev ksh
DEBS+=libssl-dev

.PHONY: all clean distclean
all::	sub
all clean distclean::
	git submodule foreach '$(MAKE)' $@ || { err=$$?; echo; echo "FAIL $$err"; echo; echo "If something is missing, try 'make debian' to pull needed packages"; exit $$err; }

distclean::
	rm -f *~ .*~

.PHONY: sub
sub:
	./.pull 100
	for a in $(SUBS); do [ -d "$$a" -a -e "$$a/.git" ] || ( cd "`dirname "$$a"`" && git submodule update --init --recursive "`basename "$$a"`" ); done
	for a in */tino; do [ -d "$$a" -a -e "$$a/.git" ] || ( cd "`dirname "$$a"`" && git submodule update --init --recursive "`basename "$$a"`" ); done

.PHONY: update up up2 up5 uplib
update:	up uplib

up:
	./.pull 120 $(SUBS)

up2:
	./.pull 2 $(SUBS)

up5:
	./.pull 5 $(SUBS)

.PHONY: push
push:
	@echo; echo 'NOTE: Please use detached HEAD state, as usual on submodules, to skip push.  Else it must be a tracking branch.'; echo
	git submodule foreach --recursive 'if git symbolic-ref HEAD >/dev/null 2>&1; then git push; else echo "$$name is detached, so no push"; fi'

uplib:
	./.pull 100
	ok=true; tinolib="$$(readlink -e tinolib)" && for a in */tino; do if [ -d "$$a" -a -e "$$a/.git" ] && printf . && ( cd "$$a" && git config --local url."$$tinolib".insteadOf "`git ls-remote --get-url origin`" ); then ./.pull '' "$$a"; else echo "bug $$a"; ok=false; fi; done; $$ok
	./.pull 100

downlib:
	for a in $(SUBS); do [ -d "$$a/tino" -e "$$a/tino/.git" ] && ( cd ..................... XXX TODO XXX

.PHONY: lib
lib:
	for a in */tino; do [ -d "$$a" -a -e "$$a/.git" ] && printf . && ( cd "`dirname "$$a"`" && $(MAKE) && git add Makefile Makefile.md5 tino ) || { echo; echo "bug $$a"; echo; exit 1; }; done

.PHONY: checklib
checklib:
	SHA="`cd tinolib && git rev-parse HEAD`" && { ok=:; for a in $(SUBS); do [ -d "$$a/tino" -a -e "$$a/tino/.git" ] && [ ".$$SHA" != ".`cd "$$a/tino" && git rev-parse HEAD`" ] && { echo "WRONG $$a"; ok=false; }; done; $$ok && echo OK; }

.PHONY: check
check:
	bash -c "diff -u <(grep ^SUBS+= Makefile) <(git submodule | awk '{ print \"SUBS+=\" \$$2 }')"

.PHONY: st status
st:
	@git submodule --quiet foreach 'git status --porcelain | awk -vT="$$path" '\''{ printf "%20s %s\n", T, $$0 }'\'

status:
	for a in */.git; do ( b="$${a%/.git}"; cd "$$b" && git status --porcelain | awk -vT="$$b" '{ printf "%20s %s\n", T, $$0 }'; ); done

.PHONY: debian
debian:
	sudo apt-get install $(DEBS)

