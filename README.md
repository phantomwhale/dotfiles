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
- TablePlus connections (Settings -> Locations -> select folder in iCloud Drive)
- Setup Dropbox for todo.txt synchronising

## Manual installs / preferences

- Dash license: Download and installed from 1Password vault
- DBPowerAmp needs manually installation
- System Preferences -> Keyboard -> Turn off "add period for double space"
- May need to run `compaudit | xargs chmod g-w,o-w` (<https://github.com/zsh-users/zsh-completions/issues/680>)
