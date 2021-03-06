#!/bin/bash
set -xeuo pipefail

# thanks to Kevin Schumacher
# https://gist.github.com/kevinschumacher/192624d795f4ca54e4b265d194a2249f#file-02-install-pythons-sh


INSTALL_DIR=$HOME/python
VERSIONS=("3.6.10" "3.5.9")

# for openssl (see end of output of `brew upgrade openssl`)
# for sqlite  (see end of output of `brew upgrade sqlite`)
# make sure these values match your machine
#SQLITE_LIB=/usr/lib64
#SQLITE_INCLUDE=/usr/include
#OPENSSL_LIB="/usr/lib64"
#OPENSSL_INCLUDE="/usr/include/openssl"

export LDFLAGS="-L$SQLITE_LIB -L$OPENSSL_LIB"
export CPPFLAGS="-I$SQLITE_INCLUDE -I$OPENSSL_INCLUDE"


function short(){
  echo `echo $1 | cut -d"." -f1,2`
}
function without_beta(){
  echo `echo $1 | cut -d"b" -f1`
}

for version in "${VERSIONS[@]}"
do
  without_beta_version="$(without_beta $version)"
  prefix="$INSTALL_DIR/$version"
  mkdir -p $prefix/src
  cd $prefix/src
  wget https://www.python.org/ftp/python/$without_beta_version/Python-$version.tgz
  tar -xzf ./Python-$version.tgz
  cd ./Python-$version

  make clean
  
  ./configure --prefix=$prefix --enable-optimizations --with-ensurepip=install --enable-loadable-sqlite-extensions

  make -j8 build_all && make install

done

# If you don't want to override the links of /usr/local/bin/python3.*, then, remove the rest of the script:
for version in "${VERSIONS[@]}"
do
  short_version="$(short $version)"
  prefix="$INSTALL_DIR/$version"
  sudo ln -sf $prefix/bin/python$short_version $HOME/.local/bin/python$short_version
done
