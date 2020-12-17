function ct
    /usr/local/bin/ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./tags $argv[1]
end
