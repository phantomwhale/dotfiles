require 'rake'

desc "install dotfiles into home directory"
task :install => %i[brew ssh symlink ruby base16 zsh vim_plug]

desc "Get hold of SSH key"
task :ssh do
  puts "Setting up SSH keys"
  STDOUT.puts "Input 1password vault:"
  vault = STDIN.gets.strip
  STDOUT.puts "Input secret key for 1password vault:"
  secret = STDIN.gets.strip
  # TODO: don't override file if it already exists
  system %(eval $(op signin #{vault} ben.turner@pobox.com #{secret}) && op get document id_rsa > ~/.ssh/id_rsa)
  # TODO: retry if file doesn't now exist
  system %(chmod 600 ~/.ssh/id_rsa)
  system %(ssh-add ~/.ssh/id_rsa)
  system %(ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub)
end

desc "Install brew bundle"
task :brew do
  puts "Installing brew and all brewfile packages"
  system %(/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)")
  system %(brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup)
  system %(brew tap Homebrew/bundle)
  system %(brew bundle)
  system %(mkdir ~/.nvm) # NVM needs this to be created
end

desc "Install base16 options"
task :base16 do
  puts "Installing base16 shell options"
  system %(git clone git@github.com:chriskempson/base16-shell.git ~/.config/base16-shell)
end

desc "Install vim plugins"
task :vim_plug do
  puts "Installing vim plugins"
  system %(curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)
  system %(vim -c "PlugInstall 4" -c "qall")
end

desc "Symlink files"
task :symlink do
  puts "Symlinking all dotfiles"
  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile Brewfile README.md LICENSE id_dsa.pub].include? file

    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file}"
        end
      end
    else
      link_file(file)
    end
  end
end

def replace_file(file)
  system %(rm "$HOME/.#{file}")
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %(ln -s "$PWD/#{file}" "$HOME/.#{file}")
end

task :zsh do
  if ENV["SHELL"] =~ /zsh/
    puts "using zsh"
  else
    print "switch to zsh? (recommended) [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "switching to zsh"
      system %(sudo dscl . -create /Users/$USER UserShell `which zsh`)
      system %(exec zsh)
    when 'q'
      exit
    else
      puts "skipping zsh"
    end
  end
end

task :ruby do
  puts "Installing latest ruby version"
  system %(ruby-install ruby)
  #system %(gem install tmuxinator) # will this always be executed for the latest ruby?
  #system %(gem install timetrap) # will this always be executed for the latest ruby?
end

task :backup do
  puts "backing up non-dotfile settings"
  system %(mkdir -p ~/Dropbox/.backup/Sequel\\ Pro/ && cp ~/Library/Application\\ Support/Sequel\\ Pro/Data/Favorites.plist ~/Dropbox/.backup/Sequel\\ Pro/)
  system %(mkdir -p ~/Dropbox/.backup/Keychains/ && cp ~/Library/Keychains/*.keychain ~/Dropbox/.backup/Keychains/)
end

task :restore do
  puts "Restoring non-dotfile settings"
  system %(cp ~/Dropbox/.backup/Sequel\\ Pro/Favorites.plist ~/Library/Application\\ Support/Sequel\\ Pro/Data/)
  system %(cp ~/Dropbox/.backup/Keychains/*.keychain ~/Library/Keychains/)
  system %(security list-keychains -s ~/Library/Keychains/*.keychain)
  system %(security default-keychain -s ~/Library/Keychains/login.keychain)
end
