# My Dot Files

My personal dotfiles, written to run in an update to date installation of MacOS

## Installation

Run the following commands in the terminal; it should prompt you before doing anything destructive.

Also log into the App Store before installing, so it can install App Store packages via `mas`

```terminal
git clone https://github.com/phantomwhale/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install-osx.sh
```

Need to manually run `sudo xcodebuild -license` after XCode is installed

## Manual backup / restores

Some steps are not automated when moving between machines, such as:

- Shell history (`/.zsh_history`)
- Keychains
- TablePlus connections (`~/Library/Application\ Support/com.tinyapp.TablePlus/`) - passwords come over in the Keychain
- Little-snitch rules
- Setup Dropbox for todo.txt synchronising

## Manual installs / preferences

- DBPowerAmp needs manually installation
- System Preferences -> Keyboard -> Turn off "add period for double space"
- May need to run `compaudit | xargs chmod g-w,o-w` (<https://github.com/zsh-users/zsh-completions/issues/680>)
