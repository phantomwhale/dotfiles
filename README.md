# My Dot Files

I am running MacOS. These files (and this README) were many years ago based off Ryan Bates dotfiles, although they have drifted far, far away now !

## Installation

Run the following commands in your terminal. It will prompt you before it does anything destructive. Check out the [Rakefile](https://github.com/ryanb/dotfiles/blob/custom-bash-zsh/Rakefile) to see exactly what it does.

```terminal
git clone https://github.com/phantomwhale/dotfiles ~/.dotfiles
cd ~/.dotfiles
rake install
```

Feel free to customize the .zshrc file to match your preference.

After installing Dropbox, and syncing over the files, you may want to sync up your keychains via:

```terminal
cd ~/.dotfiles
rake keychain
```
