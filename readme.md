# dotfiles

This is my personal dotfiles repository, built for deployment with Ansible.

### Vagrant Setup

To roll out a test VM:

```bash
vagrant up
```

### Ansible Local Setup

```
ansible-playbook \
  -e target_user=<target-user> \
  -i ansible/inventory.yml \
  -e ansible_user=<auth-user> \
  ansible/everything.yml
```
