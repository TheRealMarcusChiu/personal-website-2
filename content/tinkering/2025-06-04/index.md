+++
date = '2025-06-04T17:36:22-05:00'
draft = false
title = 'Homelab #2 - Proxmox Cluster'
+++

Homelab Series:

- [Homelab #1 - Humble Beginnings](/tinkering/2024-08-26/)
- [Homelab #2 - Proxmox Cluster](/tinkering/2025-06-04/)
- [Homelab #3 - Kubernetes Cluster](/tinkering/2025-06-05/)
- [Homelab #4 - VM/Container Bonanza](/tinkering/2025-06-06/)

# Proxmox Cluster

In this post I will go over setting up a Proxmox Cluster on my 3 Intel NUCs in my [homelab rack](/tinkering/2024-08-26/).

This will allow my servers to run in [high availability](https://en.wikipedia.org/wiki/High_availability) just in case one NUC goes down.

![alt](assets/1.jpeg)

# Download Proxmox ISO and Create USB Boot Device


