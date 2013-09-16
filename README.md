# My Dot Files

I am running Linux. These files (and this README) are based off Ryan Bates dotfiles, although they have drifted quite far away now !

## Installation

Run the following commands in your terminal. It will prompt you before it does anything destructive. Check out the [Rakefile](https://github.com/ryanb/dotfiles/blob/custom-bash-zsh/Rakefile) to see exactly what it does.

```terminal
git clone git://github.com/phantomwhale/dotfiles ~/.dotfiles
cd ~/.dotfiles
rake install

# Vim plugins need vundle

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
```

After installing, open a new terminal window to see the effects.

Feel free to customize the .zshrc file to match your preference.

