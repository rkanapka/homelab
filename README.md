# Raspberry Pi HomeLab

Welcome to my personal homelab project!<br/>
This repository contains the configuration files, automation scripts, and deployment instructions for managing my Raspberry Pi-based homelab environment.

### Key Features:
* Local-Only Services – All services are accessible only within the local network.
* Secure Access – Services are secured with HTTPS using DuckDNS for dynamic DNS.
* Temperature Control – The Raspberry Pi is equipped with an automatic fan controlled by a custom GPIO script to manage CPU/GPU temperatures.

---

### 📡 Hardware
- **Device**: Raspberry Pi 4 Model B (Rev 1.4)
- **SoC**: Broadcom BCM2711
- **CPU**: Quad-core ARM Cortex-A72 @ 1.8GHz (ARMv8, 64-bit)
- **RAM**: 2GB LPDDR4
- **Storage**: 32GB microSD (OS) + 512GB external SSD (data)

---

### 🖥️ Operating System
- **OS**: Debian GNU/Linux 11 (bullseye)  

---

### 🧰 Applications
A collection of essential services running in Docker containers, all orchestrated via `docker compose`.

- **Homepage** – Central dashboard for accessing all homelab services.
- **Nginx Proxy Manager (NPM)** - Simple web interface for managing Nginx proxy hosts.
- **Pi-hole** - Network-wide ad blocker and tracker blocker.

#### ⚠️ Disabled Services

**Immich** (photo & video backup — Google Photos alternative)
Disabled: hardware requirements not met. Immich requires a minimum of 6GB RAM (recommended 8GB). The RPi 4 (2GB) is below the minimum.
To re-enable: upgrade to hardware with 6GB+ RAM, then uncomment the relevant lines in `docker-compose.yml`, `homepage/docker-compose.yml`, and `homepage/config/services.yaml`.

**Plex Stack** — migrated to Stremio + RealDebrid.
To re-enable, uncomment the relevant lines in `docker-compose.yml`, `homepage/docker-compose.yml`, and `homepage/config/services.yaml`.

- **Plex** – Media server to stream movies, TV shows, and music.
- **Prowlarr** – Torrent indexer manager.
- **Sonarr** – TV series downloader and organizer.
- **Radarr** – Automated movie downloader and manager.
- **Transmission** – Lightweight torrent client for downloading files.
---

### 🔧 Scripts
#### **fan_control.py**
Controls a 5V GPIO fan via an NPN transistor. Activates at 65°C, deactivates at 40°C.

→ See [docs/fan-control.md](docs/fan-control.md) for wiring diagram and setup instructions.

---

### 🚀 How to Start the Project

The setup uses Docker Compose and environment variables to manage services.<br/>
Some services require initial configuration via their UIs after first deployment.

1. Ensure Docker and Docker Compose are installed.
2. Ensure `.env` contains all necessary environment variables. Example provided in `.env.sample` file.

**Active services:**
```
IP:               RPi server’s static IP address.
HOMEPAGE_HOST:    Allowed hostname(s) for the Homepage dashboard.
SSD1_DRIVE:       Mount path of the external SSD connected to the RPi.
NPM_IP:           Internal IP address of Nginx Proxy Manager.
NPM_URL:          URL to access the Nginx Proxy Manager UI.
NPM_USERNAME:     Username to log in to Nginx Proxy Manager.
NPM_PASSWORD:     Password to log in to Nginx Proxy Manager.
PIHOLE_IP:        Internal IP address of the Pi-hole server.
PIHOLE_URL:       URL to access the Pi-hole UI.
PIHOLE_PASSWORD:  Pi-hole v6 password or app password.
```

**Disabled services (uncomment when re-enabling):**
```
# Immich (requires 6GB+ RAM):
IMMICH_IP:              Internal IP address of the Immich server.
IMMICH_URL:             URL to access the Immich UI.
IMMICH_API_KEY:         Immich API key (generate in Account Settings → API Keys).
IMMICH_DB_USERNAME:     PostgreSQL username for Immich.
IMMICH_DB_PASSWORD:     PostgreSQL password for Immich.
IMMICH_DB_DATABASE_NAME: PostgreSQL database name for Immich.
IMMICH_UPLOAD_PATH:     Path on the SSD where photos/videos are stored.
IMMICH_DB_PATH:         Path on the SSD for the Immich PostgreSQL database.

# Plex stack (migrated to Stremio + RealDebrid):
PLEX_CLAIM:           Plex account claim key for linking the server.
PLEX_IP:              Internal IP address of the Plex server.
PLEX_URL:             URL to access the Plex UI.
PLEX_KEY:             Authentication key for Plex.
PROWLARR_IP:          Internal IP address of Prowlarr.
PROWLARR_URL:         URL to access Prowlarr UI.
PROWLARR_KEY:         Authentication key for Prowlarr.
RADARR_IP:            Internal IP address of Radarr.
RADARR_URL:           URL to access Radarr UI.
RADARR_KEY:           Authentication key for Radarr.
SONARR_IP:            Internal IP address of Sonarr.
SONARR_URL:           URL to access Sonarr UI.
SONARR_KEY:           Authentication key for Sonarr.
TRANSMISSION_IP:      Internal IP address of Transmission.
TRANSMISSION_URL:     URL to access the Transmission UI.
TRANSMISSION_USERNAME: Username for Transmission.
TRANSMISSION_PASSWORD: Password for Transmission.
```
3. Then, run the following command to launch all services (set `.env` file path accordingly):

```bash
docker compose --env-file ~/homelab/.env up -d
```

4. You will have to additionally configure all settings of services via UI.
   
5. Configure Pi-hole and Router

   Set a static IP for the RPi, then point your router’s DNS to Pi-hole’s IP.

   → See [docs/pihole-router-setup.md](docs/pihole-router-setup.md) for step-by-step instructions with screenshots.

---

### Screenshots

### Homepage dashboard
Old version:
![homepage](https://github.com/user-attachments/assets/6a5b1b59-a72f-49dc-9be2-526b64f997e8)
Latest version:
<img width="2344" height="1303" alt="image" src="https://github.com/user-attachments/assets/ba76effe-94b4-4ce9-897c-a6d91c57bee8" />

### Ads Before and After running Pi-hole


![Before and After Ads](https://github.com/user-attachments/assets/00247326-19f5-4a5a-8fa8-6c2bb8e82240)
---

### 📄 Notes

Services can be monitored through the Homepage dashboard.<br/>
For any questions or contributions, feel free to open an issue!
