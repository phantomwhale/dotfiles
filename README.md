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

Some things are not automated when moving between machines, such as:

* Copying SequelPro favourites (there are two files you need to copy over for this) - passwords come over in the keychains
* Little-snitch rules need to be backed up and imported
* Go to iTerm2 > Preferences > “General” tab, and in the “Selection” section, check the box which says “Applications in terminal may access clipboard” if it isn’t checked.
