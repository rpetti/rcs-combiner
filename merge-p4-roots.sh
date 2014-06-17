#!/bin/bash

set -e

if [ "$3" == "" ]; then
	echo "Usage: $0 <path to root A> <path to root B> <path for merged root>"
	exit 1
fi

pathA="$1"
pathB="$2"
pathC="$3"

(cd $pathA >/dev/null && find . -type f -name \*,v) | while read file; do
	mkdir -p "`dirname \"$pathC/$file\"`"
	if [ -e "$pathB/$file" ]; then
		./rcs-combiner "$pathA/$file" "$pathB/$file" "$pathC/$file"
	else
		cp "$pathA/$file" "$pathC/$file"
	fi
done
(cd $pathB >/dev/null && find . -type f -name \*,v) | while read file; do
	mkdir -p "`dirname \"$pathC/$file\"`"
	if [ ! -e "$pathA/$file" ]; then
		cp "$pathB/$file" "$pathC/$file"
	fi
done

