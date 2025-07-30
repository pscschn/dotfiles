# dotfiles

This is my personal **dotfiles repository**, built for fast, reproducible setups by using **Ansible**, and testable via **Vagrant**.
> 💡 My Neovim configuration is maintained separately here: [pscschn/nvim-385](https://github.com/pscschn/nvim-385)

---

![VirtualBox Screenshot](./screenshot.png "example")

---

## 🔧 Overview

- **Hyprland** as Wayland window manager
- **Neovim** with **Tmux** for terminal-based workflows
- **Ansible**-based provisioning
- **Vagrant**-based testing

## 🎹 Keymaps

> Note: see all keymaps in the [hyprland.conf](./ansible/roles/dotfiles/templates/hypr/hyprland.conf)

## 🚀 Deployment

### Quick Vagrant Setup

To roll out a test VM:

```bash
vagrant up
```

### Ansible Local Setup

The inventory is setup so ansible deploys to itself by default.

Run the playbook:

```
ansible-playbook \
  -e target_user=<target-user> \
  -i ansible/inventory.yml \
  -e ansible_user=<auth-user> \
  ansible/everything.yml
```

> Note: Might need to generate a local SSH key.
