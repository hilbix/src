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


all:
	for a in $(SUBS); do ( cd "$$a" && git submodule update --init; ) || echo "bug: $$a"; done


update:	up uplib

up:
	for a in $(SUBS); do echo -n .; ( cd "$$a" && git checkout -q master && for b in . . . . . . . . . .; do git pull -q && break; echo "retry $$a"; sleep 1; done; ) || echo "bug: $$a"; done
	echo

uplib:
	tinolib="$$(readlink -e tinolib)"; for a in */tino; do [ -d "$$a" -a -e "$$a/.git" ] && echo -n . && ( [ -d "$$a" ] && cd "$$a" && git config --local url."$$tinolib".insteadOf "`git ls-remote --get-url origin`" && git checkout -q master && git pull -q --ff-only; ) || echo "bug $$a"; done


st:	status

status:
	for a in */.git; do ( b="$${a%/.git}"; cd "$$b" && git status --porcelain | awk -vT="$$b" '{ printf "%20s %s\n", T, $$0 }'; ); done

