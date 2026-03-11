# RPi4

### 📡 Hardware
- **Device**: Raspberry Pi 4 Model B (Rev 1.4)
- **SoC**: Broadcom BCM2711
- **CPU**: Quad-core ARM Cortex-A72 @ 1.8GHz (ARMv8, 64-bit)
- **RAM**: 2GB LPDDR4
- **Storage**: 32GB microSD (OS) + 512GB external SSD (data)
- **OS**: Debian GNU/Linux 11 (bullseye)

---

### 🧰 Services

- **Homepage** - Central dashboard for accessing all homelab services.
- **Nginx Proxy Manager** - Reverse proxy with SSL via Let's Encrypt.
- **Pi-hole** - Network-wide ad blocker and DNS server.
- **Vaultwarden** - Self-hosted Bitwarden-compatible password manager.
- **Uptime Kuma** - Service uptime monitor with alerting.
- **WG-Easy** - WireGuard VPN with web UI for remote access.
- **Sound Vault** - [Music app](https://github.com/rkanapka/sound-vault) (Navidrome + Soulseek UI).
- **Glances** - System resource monitoring (CPU, memory, disk, network).
- **Docker Socket Proxy** - Read-only Docker API proxy (port 2375, internal Docker network only) for Homepage container status widgets.

---

### 🔧 Scripts

#### **fan_control.py**
Controls a 5V GPIO fan via an NPN transistor. Activates at 65°C, deactivates at 40°C.

→ See [../docs/fan-control.md](../docs/fan-control.md) for wiring diagram and setup instructions.

---

### 🚀 Deployment

```bash
cd ~/homelab/rpi4
docker compose --env-file .env up -d
```

Copy `.env.sample` → `.env` and fill in:

```
IP:               RPi server's static IP address.
HOMEPAGE_HOST:    Allowed hostname(s) for the Homepage dashboard.
SSD1_DRIVE:       Mount path of the external SSD connected to the RPi.
WG_HOST:          Public hostname for WireGuard (your DuckDNS domain, e.g. yourdomain.duckdns.org).
WG_PASSWORD_HASH: Bcrypt hash of the WG-Easy web UI password. Generate with:
                  docker run --rm ghcr.io/wg-easy/wg-easy wgpw YOUR_PASSWORD
WGEASY_IP:        Internal IP address of the WG-Easy web UI.
WGEASY_URL:       URL to access the WG-Easy web UI.
VAULTWARDEN_IP:   Internal IP address of the Vaultwarden server.
VAULTWARDEN_URL:  Public URL for Vaultwarden (used as the DOMAIN for HTTPS cookies).
KUMA_IP:          Internal IP address of the Uptime Kuma server.
KUMA_URL:         URL to access the Uptime Kuma UI.
KUMA_SLUG:        Slug of the status page created in Kuma UI (used for Homepage widget).
SOUNDVAULT_IMAGE_TAG: Docker image tag for Sound Vault (example: 0.1.0).
SOUNDVAULT_URL:   URL to access Sound Vault UI.
MUSIC_DIR:        Base path for Sound Vault music stack data/library.
NAVIDROME_USER:   Navidrome admin username used by Sound Vault API calls.
NAVIDROME_PASS:   Navidrome admin password used by Sound Vault API calls.
SLSKD_USERNAME:   Soulseek username for slskd.
SLSKD_PASSWORD:   Soulseek password for slskd.
NPM_IP:           Internal IP address of Nginx Proxy Manager.
NPM_URL:          URL to access the Nginx Proxy Manager UI.
NPM_USERNAME:     Username to log in to Nginx Proxy Manager.
NPM_PASSWORD:     Password to log in to Nginx Proxy Manager.
PIHOLE_IP:        Internal IP address of the Pi-hole server.
PIHOLE_URL:       URL to access the Pi-hole UI.
PIHOLE_PASSWORD:  Pi-hole v6 password or app password.
N100_IP:              Static IP of the N100.
GLANCES_RPI4_URL:     Public URL for the RPi4 Glances dashboard.
GLANCES_N100_URL:     Public URL for the N100 Glances dashboard.
IMMICH_IP:            Internal URL of the Immich server on the N100 (e.g. http://$N100_IP:2283).
IMMICH_URL:           Public URL for Immich.
IMMICH_API_KEY:       Immich API key (create in Immich UI → Account Settings → API Keys).
```

---

### ⚙️ Post-deploy Configuration

**Uptime Kuma**: Open Kuma UI → Status Page → New → set slug to `homelab` → add your monitors.

**Pi-hole**: Set a static IP for the RPi, then point your router's DNS to Pi-hole's IP.
→ See [../docs/pihole-router-setup.md](../docs/pihole-router-setup.md)

**WireGuard VPN**: Set up DuckDNS, router port forwarding, and connect your devices.
→ See [../docs/wireguard-setup.md](../docs/wireguard-setup.md)
