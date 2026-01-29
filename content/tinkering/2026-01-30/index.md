+++
date = '2026-01-30T00:00:00-00:00'
draft = false
title = "How to Uninstall Fedora Asahi Linux from an M1 MacBook Pro"
+++

If you’ve experimented with **Fedora Asahi Linux** on Apple Silicon and want to reclaim the disk space and return to a clean **macOS-only** setup, this guide walks through the **safe, manual removal process using the `diskutil` CLI**.

> ⚠️ **Warning**: These steps permanently delete Linux data. Double‑check disk identifiers before running destructive commands.

# Step 1: Boot into macOS (Set as Default OS)

If your Mac still defaults to Fedora Asahi Linux:

1. Shut down the Mac
2. Hold **Power** → *Loading startup options*
3. Select **macOS**
4. Click **Always Use**

# Step 2: Inspect APFS Containers

List all APFS containers:

```bash
diskutil apfs list
```

You’ll typically see:

* **Container 1** → macOS (System + Data)
* **Container 2** → Fedora Asahi Linux

Example (simplified):

```text
APFS Container (disk2)
├─ Fedora-Root
├─ Fedora-Home
└─ Fedora-Swap
```

> 📝 Take note of the **APFS Container disk identifier** used by Fedora (e.g. `disk2`).

# Step 3: Unmount the Fedora APFS Container

Unmount the entire container:

```bash
sudo diskutil apfs unmountContainer disk2
```

If it refuses:

```bash
sudo diskutil unmountDisk force disk2
```

# Step 4: Delete the Fedora APFS Container

Once unmounted, delete the container:

```bash
sudo diskutil apfs deleteContainer disk2
```

This:

* Removes all Fedora volumes
* Frees the partition space

# Step 5: Verify Free Space

Re-run:

```bash
diskutil list
```

You should now see **Free Space** where Fedora lived.

# Step 6: Reclaim the Space for macOS

If the free space is adjacent to the macOS container:

```bash
sudo diskutil apfs resizeContainer disk1 0
```

(`0` means “use all available space”)


---

Enjoy your reclaimed SSD space!!!! 🚀
