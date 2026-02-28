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
Used to manage CPU & GPU temperatures by controlling a 5V fan through GPIO.  

- **Setup**:
  - The fan connects to an NPN 2N2222A transistor, enabling automatic on/off control via GPIO.
  - Example circuit diagram:  
    ![Circuit Diagram](https://github.com/user-attachments/assets/dfefdb75-9d30-48e5-855b-3c200305644f)
- **Setup script to run automatically**
  1. Change `/path/to/` in `fan_control.sh` to match path of `fan_control.py`
  2. Put script in `/etc/init.d`
  3. You can start automatic script with command `/etc/init.d/fan_control start`<br/>
  NOTE: Check RPI temperature with command `vcgencmd measure_temp`
  
- **Behavior**:
  - Fan activates at **65°C** and deactivates at **40°C** to maintain optimal temperature.
  
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

**Router Model:** Asus RT-AX58U  
**Firmware Version:** 3.0.0.4.388_25210  
📘 [[Wireless Router] How to configure router to use Pi-Hole?](https://www.asus.com/support/faq/1046062/)

### Step 5.1: Set a Static IP for Raspberry Pi

Go to your router’s **LAN → DHCP Server** settings and assign a static IP to your Raspberry Pi.

![Set Static IP](https://github.com/user-attachments/assets/56088dd1-6ec2-4bc3-9684-69129a31c641)

---

### Step 5.2: Set Pi-hole as Your DNS Server

Under **WAN → Internet Connection**, set the DNS Server fields to the Pi-hole’s static IP address.

![Set DNS to Pi-hole](https://github.com/user-attachments/assets/f2209f29-fc92-478e-a934-95e3dadca035)

---

### Step 5.3: (Optional) Allow All Origins in Pi-hole

If get DNS_PROBE_FINISHED_BAD_CONFIG error, go to **Pi-hole Admin → Settings → DNS**, and enable "Permit all origins" to allow DNS requests from different devices.

![Allow All Origins](https://github.com/user-attachments/assets/61172b78-edf3-44a6-898b-25cfb1a24808)

---

### Screenshots

### Homepage dashboard
![homepage](https://github.com/user-attachments/assets/6a5b1b59-a72f-49dc-9be2-526b64f997e8)

### Ads Before and After running Pi-hole


![Before and After Ads](https://github.com/user-attachments/assets/00247326-19f5-4a5a-8fa8-6c2bb8e82240)
---

### 📄 Notes

Services can be monitored through the Homepage dashboard.<br/>
For any questions or contributions, feel free to open an issue!
