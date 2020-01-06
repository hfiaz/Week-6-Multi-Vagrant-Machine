required_plugins = %w(vagrant-hostsupdater)

 

plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
end

def set_env vars
  command = <<~HEREDOC
      echo "Setting Environment Variables"
      source ~/.bashrc
  HEREDOC

 

  vars.each do |key, value|
    command += <<~HEREDOC
      if [ -z "$#{key}" ]; then
          echo "export #{key}=#{value}" >> ~/.bashrc
      fi
    HEREDOC
  end

 

  return command
end

 

Vagrant.configure("2") do |config|
  config.vm.define "app" do |app|
  app.vm.box = "ubuntu/xenial64"
  app.vm.network "private_network", ip:"192.168.10.150"
  app.hostsupdater.aliases = ["app.local"]
  app.vm.synced_folder "environment/app", "/home/vagrant/app"
  app.vm.provision "shell", path: "environment/app/provision.sh"
  app.vm.provision "shell", inline: set_env({ DB_HOST: "mongodb://192.168.10.100:27017/posts" }), privileged: false
  end

 

  config.vm.define "db" do |db|
  db.vm.box = "ubuntu/xenial64"
  db.vm.network "private_network", ip:"192.168.10.100"
  db.hostsupdater.aliases = ["database.local"]
  db.vm.synced_folder "environment/db", "/home/ubuntu/environment"
  db.vm.provision "shell", path: "environment/db/provision.sh"
  end
end