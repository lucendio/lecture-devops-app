Vagrant.configure(2) do |config|
	config.vm.define "devops-box" do |devbox|
		devbox.vm.box = "ubuntu/bionic64"
			devbox.vm.provision "shell", path: "scripts/install.sh"
			devbox.vm.provider "virtualbox" do |v|
				v.memory = 4096
				v.cpus = 2
			end
	end
end
