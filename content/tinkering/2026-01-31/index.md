+++
date = '2026-01-31T00:00:00-00:00'
draft = false
title = "Securing Proxmox LXC Containers by Disabling SSH Password Login"
+++

When running **LXC containers on Proxmox**, one of the simplest and most effective security improvements you can make is disabling **SSH password authentication** and enforcing **SSH key–only access**.

This post covers a small utility script from my repository:

- [GitHub Link](https://github.com/TheRealMarcusChiu/proxmox-scripts/tree/master/update-lxc-to-deny-ssh-password)

# 🤔 Why Disable SSH Password Authentication?

SSH password login is one of the most common attack targets:

* Vulnerable to brute-force attacks
* Weak or reused passwords are easy to guess
* Often accidentally enabled in containers

SSH keys are:

* Stronger and harder to brute-force
* Easier to rotate and manage
* The recommended default for servers and containers

If your LXC containers are reachable on your network, disabling password logins is a no-brainer.

# 🛠 Why I Created This Script

I personally have **over a dozen LXC containers** on my Proxmox server. Manually disabling SSH password authentication in each container is **time-consuming and repetitive**.

This script automates the process, saving time and ensuring **consistent security** across all containers.

# 🛠 What This Script Does

The **update-lxc-to-deny-ssh-password** script automates SSH hardening for LXC containers on Proxmox. Specifically, it does the following:

1. Opens the SSH daemon configuration file inside the container:

```bash
vim /etc/ssh/sshd_config
```

2. Edits the file to include the following lines:

```bash
# Marcus Chiu Changes - START
PasswordAuthentication no
ChallengeResponseAuthentication no
UsePAM no
PermitRootLogin prohibit-password
PubkeyAuthentication yes
# Marcus Chiu Changes - END
```

3. Reloads and restarts the SSH daemon to apply changes:

```bash
sudo systemctl reload sshd
sudo systemctl restart sshd
```

# 🛠 How to Use This Script

Clone this project into the proxmox host:

```bash
git clone https://github.com/TheRealMarcusChiu/proxmox-scripts
```

Change directory into:

```bash
cd update-lxc-to-deny-ssh-password
```

Run script:

```bash
./update_ssh_config.sh <container_id>
```

# Conclusion

By using this script, you ensure all your LXC containers **enforce key-based SSH authentication**, reducing the attack surface and improving overall server security.
