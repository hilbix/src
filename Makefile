#

TINOLIBREPO=https://github.com/hilbix/tinolib.git

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


update:	up uplib

up:
	for a in $(SUBS); do ( cd "$$a" && git checkout master && for b in . . . . . . . . . .; do echo "pull $$a"; git pull && break; echo retry; sleep 2; done; ); done

uplib:
	tinolib="$$(readlink -e tinolib)"; for a in */tino; do ( [ -d "$$a" ] && cd "$$a" && git config --local url."$$tinolib".insteadOf "$(TINOLIBREPO)" && git checkout master && for b in . . . . . . . . . .; do echo "pull $$a" && git pull && break; echo retry; sleep 2; done; ); done


st:	status

status:
	for a in */.git; do ( b="$${a%/.git}"; cd "$$b" && git status --porcelain | awk -vT="$$b" '{ printf "%20s %s\n", T, $$0 }'; ); done

