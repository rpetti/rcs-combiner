#!/bin/bash
set -e 
export P4PORT=svsperforce1:1667
export P4USER=perforce
export P4PASSWD=perforce23

KEEPDIR=keeplists
OLDROOT=old
NEWROOT=new

p4 -ztag fstat -Oc $1 | sed -n -e '/lbrFile/ {N; s/\.\.\. lbrFile \/\/\(.*\)\n\.\.\. lbrRev \(.*\)/\1::\2/p }' | while read line; do
	lbrfile=`echo "$line" | sed -e 's/::.*//'`
	lbrrev=`echo "$line" | sed -e 's/.*:://'`
	mkdir -p "$KEEPDIR/`dirname "$lbrfile,v,keeprev"`"
	echo $lbrrev >> keeplists/"$lbrfile,v,keeprev"
done

(cd $OLDROOT; find . -name \*,v) | while read lbrfile; do
	mkdir -p "$NEWROOT/`dirname "$lbrfile"`"
	./rcs-cleaner "$OLDROOT/$lbrfile" "$KEEPDIR/$lbrfile,keeprev" "$NEWROOT/$lbrfile" || true
done
