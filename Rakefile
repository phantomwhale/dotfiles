require 'rake'

desc "install the dot files into user's home directory"
task :install => [:submodules] do
  switch_to_zsh
  install_prezto_zsh
  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README LICENSE id_dsa.pub].include? file

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
  install_vundle
end

desc "Init and update submodules"
task :submodules do
  system('git submodule update --init')
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end

def switch_to_zsh
  if ENV["SHELL"] =~ /zsh/
    puts "using zsh"
  else
    print "switch to zsh? (recommended) [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "switching to zsh"
      system %Q{chsh -s `which zsh`}
    when 'q'
      exit
    else
      puts "skipping zsh"
    end
  end
end

def install_prezto_zsh
  if File.exist?(File.join(ENV['HOME'], ".zprezto"))
    puts "found ~/.zprezto"
  else
    print "install zprezto? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing zprezto"
      system %Q{git clone --recursive https://github.com/phantomwhale/pretzo.git "${ZDOTDIR:-$HOME}/.zprezto"}
      system %Q{for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do; ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done}
    when 'q'
      exit
    else
      puts "skipping zpretzo, you will need to change ~/.zshrc"
    end
  end
end


def install_vundle
  if File.exist?(File.join(ENV['HOME'], ".vim", "bundle", "vundle"))
    puts "found ~/.vim/bundle/vundle"
  else
    print "install vundle for vim? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing vundle"
      system %Q{git clone --recursive https://github.com/gmarik/vundle.git "$HOME/.vim/bundle/vundle"}
      system "vim +BundleInstall +qall"
    when 'q'
      exit
    else
      puts "skipping vundle, you will need to manually download it to use vim"
    end
  end
end
