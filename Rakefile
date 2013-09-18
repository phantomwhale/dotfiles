require 'rake'

desc "install the dot files into user's home directory"
task :install do
  switch_to_zsh
  install_zprezto_zsh
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
      system %Q{git clone --recursive https://github.com/phantomwhale/pretzo.git "$HOME/.zprezto"}
    when 'q'
      exit
    else
      puts "skipping zpretzo, you will need to change ~/.zshrc"
    end
  end
end
