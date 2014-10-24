#!/usr/bin/env bash



SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "building ... $SCRIPTPATH"


# get current dir name
DIRNAME=${SCRIPTPATH##*/}
SRCDIR="$SCRIPTPATH""/src"
BINPATH="$SCRIPTPATH""/bin/$DIRNAME"
CURDIR="$SCRIPTPATH"
OLDGOPATH="$GOPATH"
export GOPATH="$CURDIR"

echo "gofmt ..."
gofmt -w "$SRCDIR"
if [[ $? -ne 0 ]]; then
	echo "Error: cant fmt <$SRCDIR> !"
	exit 1
fi
echo "install ..."
go install "$DIRNAME"
if [[ $? -ne 0 ]]; then
	echo "Error: cant install <$DIRNAME> !"
	exit 1
fi
export GOPATH="$OLDGOPATH"

echo 'Install success.'
echo `ls -l $BINPATH`