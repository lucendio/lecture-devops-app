Vagrant.configure(2) do |config|
	config.vm.define "devops" do |devopsbox|
		devopsbox.vm.box = "ubuntu/bionic64"
    		devopsbox.vm.network "private_network", ip: "172.30.1.5"
    		devopsbox.vm.hostname = "devops"
    		devopsbox.vm.provider "virtualbox" do |v|
    		  v.memory = 4096
    		  v.cpus = 2
    		end
	end
end
