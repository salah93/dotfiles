# echo "bashrc executed"
# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Define environment variables
# Directories
export PROJECTS=~/Projects
export DB_FOLDER=~/.db
export WORKON_HOME=~/.virtualenvs
export TEMPLATES=${PROJECTS}/scripts/.templates
export LOGS=~/.logs
export EDITOR=vim
export TESSDATA_PREFIX=/usr/share/tesseract

mkdir -p ${PROJECTS}
if [ ! -d ${PROJECTS}/scripts ]
then
    git clone -q git@github.com:salah93/scripts ${PROJECTS}/scripts
    chown -R ${USER}:${USER} ${PROJECTS}/scripts/tools/*
    chmod -R 755 ${PROJECTS}/scripts/tools/*
fi
if [ ! -d ${HOME}/.scripts ]
then
    ln -s ${PROJECTS}/scripts/tools ${HOME}/.scripts
fi
# Scala
export SCALA_HOME=/usr/local/share/scala-2.12.3

# PATH
LD_LIBRARY_PATH=~/.boost/stage/lib/:$LD_LIBRARY_PATH
LD_LIBRARY_PATH=/usr/lib64/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
PATH=${PATH}:$SCALA_HOME/bin
PATH=${PATH}:$HOME/.scripts
export PATH=$PATH:$HOME/.local/bin:$HOME/bin

# Add aliases

#alias ls='ls -G'
alias ls='ls --color'
#alias ll='ls -Gl'
alias ll='ls -lh --color'
alias cdp='cd -P'
#alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
alias grep-vim="grep -wrn --exclude-dir .git '#TODO' *"
alias vi="vim"
alias h='head'
alias c='cat'
alias t='tail'



# functions
git-grep() {
    string=$1
    if [ $# -eq 1 ]; then
        echo here
        git grep $string $(git rev-list --all)
    else
        shift
        git grep $string $@
    fi
}

v() {
    . ${WORKON_HOME}/env3/bin/activate;
}

i() {
    ipython;
}

n() {
    jupyter lab;
}

# templates
mkhtml() {
    cp $TEMPLATES/index.html $1
}

mkfl(){
    cp -n $TEMPLATES/flask.py $1
}

mkmodels(){
    cp -n $TEMPLATES/models.py $1
}

mkapp(){
    cp -n $TEMPLATES/app.py $1
}

# virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh

# command line interface
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# PS1
export PS1="\u@\h \[\033[32m\]\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\]$ "
#"]]]"

start() {
    echo "What are you working on?"
    read mission
    starting=$(date +%s)
    export CURRJOURNAL=$LOGS/$starting.journal
    echo "# Mission" >> $CURRJOURNAL
    echo $mission >> $CURRJOURNAL
    export STARTTIME=$starting
}

log() {
    t=$(date +%Y%m%d-%s)
    echo "## $t" >> $CURRJOURNAL
    read log
    echo $log >> $CURRJOURNAL
}

end() {
    end=$(date +%s)
    continue='y'
    echo "What did you complete?"
    echo "## Completed" >> $CURRJOURNAL
    while [ $continue == 'y' ]; do
        read accomplished
        echo "+ $accomplished" >> $CURRJOURNAL
        echo "add more? y/n "
        read continue
    done
    total=$(($end - $STARTTIME))
    echo "## Time `date -d @$STARTTIME +%Y%m%d-%s`:`date -d @$end +%Y%m%d-%s` $(($total / 60)) minutes" >> $CURRJOURNAL
    export CURRJOURNAL=''
    export STARTTIME=''
}

greplog() {
    grep -Hn $@ $LOGS/*
}
