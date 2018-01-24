# get command line tools
xcode-select --install

# download homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# update hombrew
brew update
packages=('tmux' 'python' 'vim' 'git');
for i in ${packages[@]}; do
    brew install $i
done

# python packages
packages=('pip' 'ipython' 'virtualenv');
for i in ${packages[@]}; do
    pip install -U $i
done

# this will replace some dot files if you have any. change destination if you want to merge or preserve your scripts
if git clone https://github.com/salah93/scripts ~/Projects/scripts; then
    ln -s ~/Projects/scripts/dotfiles/bashrc  ~/.bashrc
    ln -s ~/Projects/scripts/dotfiles/bash_profile  ~/.bashrc
    ln -s ~/Projects/scripts/dotfiles/vimrc  ~/.vimrc
    ln -s ~/Projects/scripts/dotfiles/tmux.conf  ~/.tmux.conf
    ln -s ~/Projects/scripts/mailrc  ~/.mailrc
fi
