#

SUBS=	\
	checkrun       	\
	cmpfast        	\
	count          	\
	dbm            	\
	ddrescue-verify	\
	dirlist        	\
	diskus         	\
	gitstart       	\
	histogram      	\
	kdmktone       	\
	keypressed     	\
	md5chk         	\
	misc           	\
	mvatom         	\
	printansi      	\
	printargs      	\
	ptybuffer      	\
	slowdown       	\
	socklinger     	\
	sq             	\
	tinohtmlparse  	\
	tinolib        	\
	tinoseq        	\
	unbuffered     	\

DEBS=
DEBS+=build-essential
DEBS+=libgdbm-dev libsqlite3-dev
DEBS+=autoconf libtool
DEBS+=gawk dietlibc-dev ksh

.PHONY: all clean distclean
all clean distclean:	sub
	git submodule foreach '$(MAKE)' $@ || { err=$$?; echo; echo "FAIL $$err"; echo; echo "If something is missing, try 'make debian' to pull needed packages"; exit $$err; }

.PHONY: sub
sub:
	git submodule update --init
	git submodule foreach git submodule update --init

.PHONY: update up uplib
update:	up uplib

up:
	git submodule --quiet foreach 'echo -n .; git checkout -q master && for b in . . . . . . . . . .; do git pull -q && exit 0; echo "retry $$path"; sleep 1; done; false'
	echo

.PHONY: push
push:
	@echo; echo 'NOTE: Please use detached HEAD state, as usual on submodules, to skip push.  Else it must be a tracking branch.'; echo
	git submodule foreach --recursive 'if git symbolic-ref HEAD >/dev/null 2>&1; then git push; else echo "$$name is detached, so no push"; fi'

uplib:
	ok=true; tinolib="$$(readlink -e tinolib)" && for a in */tino; do [ -d "$$a" -a -e "$$a/.git" ] && echo -n . && ( cd "$$a" && git config --local url."$$tinolib".insteadOf "`git ls-remote --get-url origin`" && git checkout -q master && git pull -q --ff-only; ) || { echo "bug $$a"; ok=false; }; done; $$ok

.PHONY: lib
lib:
	for a in */tino; do [ -d "$$a" -a -e "$$a/.git" ] && echo -n . && ( cd "`dirname "$$a"`" && $(MAKE) && git add Makefile Makefile.md5 tino ) || { echo; echo "bug $$a"; echo; exit 1; }; done


.PHONY: st status
st:
	@git submodule --quiet foreach 'git status --porcelain | awk -vT="$$path" '\''{ printf "%20s %s\n", T, $$0 }'\'

status:
	for a in */.git; do ( b="$${a%/.git}"; cd "$$b" && git status --porcelain | awk -vT="$$b" '{ printf "%20s %s\n", T, $$0 }'; ); done

.PHONY: debian
debian:
	sudo apt-get install $(DEBS)

