Vagrant.configure("2") do |config|
  config.vm.box = "generic/arch"

  config.vm.provider "virtualbox" do |v|
      v.memory = 4076
      v.cpus = 2

    v.customize ["modifyvm", :id, "--graphicscontroller", "VBoxVGA"]
    #v.customize ["modifyvm", :id, "--accelerate3d", "on"]
    #v.customize ["modifyvm", :id, "--vram", "128"]
  end

  config.vm.synced_folder "./", "/vagrant"

  config.vm.provision "shell", inline: <<-'SCRIPT'
    sudo pacman -Sy --noconfirm archlinux-keyring
    sudo pacman -Syu --noconfirm
    sudo pacman -Sy --noconfirm virtualbox-guest-utils
    sudo systemctl enable vboxservice
    sudo systemctl start vboxservice

    echo "" > /home/vagrant/.bashrc
    echo 'if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then' >> /home/vagrant/.bashrc
    echo "  exec hyprland" >> /home/vagrant/.bashrc
    echo "fi" >> /home/vagrant/.bashrc
  SCRIPT

  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "/vagrant/ansible/everything.yml"
    ansible.extra_vars = {
        target_user: "vagrant",
    }
  end
end
