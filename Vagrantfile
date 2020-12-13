Vagrant.configure(2) do |config|
	config.vm.define "devops-polz-box" do |devopsbox|
		devopsbox.vm.box = "ubuntu/bionic64"
    		devopsbox.vm.network "private_network", ip: "192.168.50.4"
    		devopsbox.vm.hostname = "devops-polz-box"
      		devopsbox.vm.provision "shell", path: "scripts/install.sh"
    		devopsbox.vm.provider "virtualbox" do |v|
    		  v.memory = 4096
    		  v.cpus = 2
    		end
	end
end
