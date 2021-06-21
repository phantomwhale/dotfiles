# My Dot Files

I am running MacOS. These files (and this README) were many years ago based off Ryan Bates dotfiles, although they have drifted far, far away now !

## Installation

Run the following commands in your terminal. It will prompt you before it does anything destructive. 

You should also log into the App Store before installing, so it can install App Store packages via `mas`

```terminal
git clone https://github.com/phantomwhale/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install-osx.sh
```

Need to manually run `sudo xcodebuild -license` after installing XCode
Feel free to customize the .zshrc file to match your preference.

## Manual backup / restores

Some things are not automated when moving between machines, such as:

* Copying TablePlus connections (`~/Library/Application\ Support/com.tinyapp.TablePlus/`) - passwords come over in the keychain
* Little-snitch rules need to be backed up and imported

## Manual installs 

* DBPowerAmp needs manually installation
* Logitech mouse software https://support.logi.com/hc/en-us/articles/360024700534--Downloads-Performance-Mouse-MX
* System Preferences -> Keyboard -> Turn off "add period for double space"
* May need to run `compaudit | xargs chmod g-w,o-w` (https://github.com/zsh-users/zsh-completions/issues/680)
