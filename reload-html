#!/bin/bash
set -ue

# source virtualenv
#source ~/.virtualenvs/env/bin/activate
OUT=/tmp/html
DIR=$1

mkdir -p $OUT
pushd $OUT
# npm -g install browser-sync
browser-sync start --server --files "*html" &
popd

inotifywait -m -e modify --format %f $DIR | while read filename
do
    if [[ ${filename##*.} = 'rst' ]] || [[ ${filename##*.} = 'md' ]]
    then
        rst2html --source $filename --out $OUT
    fi
done
