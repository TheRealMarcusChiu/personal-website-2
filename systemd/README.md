Copy the `hugo.service` into your linux systemd `/etc/systemd/system/hugo.service`

- sudo systemctl daemon-reload
- sudo systemctl enable hugo
- sudo systemctl start hugo
- journalctl -u hugo -f
