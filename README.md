# My Dot Files

I am running MacOS. These files (and this README) were many years ago based off Ryan Bates dotfiles, although they have drifted far, far away now !

## Installation

Run the following commands in your terminal. It will prompt you before it does anything destructive. Check out the [Rakefile](https://github.com/ryanb/dotfiles/blob/custom-bash-zsh/Rakefile) to see exactly what it does.

```terminal
git clone https://github.com/phantomwhale/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install-osx.sh
```

Feel free to customize the .zshrc file to match your preference.

## Manual steps

Some things are not automated when moving between machines, such as:

* Copying TablePlus connections (`~/Library/Application\ Support/com.tinyapp.TablePlus/`) - passwords come over in the keychains
* Little snitch doesn't seem to install automatically via MAS
* Little-snitch rules need to be backed up and imported
* DBPowerAmp needs manually installation
* Go to iTerm2 > Preferences > “General” tab, and in the “Selection” section, check the box which says “Applications in terminal may access clipboard” if it isn’t checked.
* Logitech mouse software https://support.logi.com/hc/en-us/articles/360024700534--Downloads-Performance-Mouse-MX
