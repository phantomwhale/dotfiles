require 'rake'

desc "install dotfiles into home directory"
task :install => %i[brew ssh symlink zsh base16 vim_plug ruby]

desc "Init and update submodules"
task :submodules do
  system('git submodule update --init')
end

desc "Get hold of SSH key"
task :ssh do
  STDOUT.puts "Input 1password vault:"
  vault = STDIN.gets.strip
  STDOUT.puts "Input secret key for 1password vault:"
  secret = STDIN.gets.strip
  system %Q{eval $(op signin #{vault} ben.turner@pobox.com #{secret}) && op get document id_rsa > ~/.ssh/my_key}
  system %Q{chmod 600 ~/.ssh/my_key}
end

desc "Install brew bundle"
task :brew do
  system %Q{/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"}
  system %Q{brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup}
  system %Q{brew tap Homebrew/bundle}
  system %Q{brew bundle}
  system %q{mkdir ~/.nvm} # NVM needs this to be created
end

desc "Install base16 options"
task :base16 do
  system %Q{git clone git@github.com:chriskempson/base16-shell.git ~/.config/base16-shell}
end

desc "Install vim plugins"
task :vim_plug do
  system %Q{curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim}
  system %Q{vim -c "PlugInstall 4" -c "qall"}
end

desc "Symlink files"
task :symlink do
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
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end

task :switch_to_zsh do
  if ENV["SHELL"] =~ /zsh/
    puts "using zsh"
  else
    print "switch to zsh? (recommended) [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "switching to zsh"
      system %Q{sudo dscl . -create /Users/$USER UserShell `which zsh`}
    when 'q'
      exit
    else
      puts "skipping zsh"
    end
  end
end

task :ruby do
  system %Q{ruby-install ruby}
  system %Q{gem install tmuxinator} # will this always be executed for the latest ruby?
  system %Q{gem install timetrap} # will this always be executed for the latest ruby?
end

task :prezto do
  if File.exist?(File.join(ENV['HOME'], ".zprezto"))
    puts "found ~/.zprezto"
  else
    print "install zprezto? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing zprezto"
      system %Q{git clone --recursive https://github.com/phantomwhale/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"}
      system %Q{for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do; ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done}
    when 'q'
      exit
    else
      puts "skipping zpretzo, you will need to change ~/.zshrc"
    end
  end
end
