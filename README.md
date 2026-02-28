# Raspberry Pi HomeLab

Welcome to my personal homelab project!<br/>
This repository contains the configuration files, automation scripts, and deployment instructions for managing my Raspberry Pi-based homelab environment.

### Key Features:
* Local-Only Services – All services are accessible only within the local network.
* Secure Access – Services are secured with HTTPS using DuckDNS for dynamic DNS.
* Temperature Control – The Raspberry Pi is equipped with an automatic fan controlled by a custom GPIO script to manage CPU/GPU temperatures.

---

### 📡 Hardware
- **Device**: Raspberry Pi 4 Model B  
- **RAM**: 8GB

---

### 🖥️ Operating System
- **OS**: Debian GNU/Linux 11 (bullseye)  

---

### 🧰 Applications
A collection of essential services running in Docker containers, all orchestrated via `docker-compose`.

- **Homepage** – Central dashboard for accessing all homelab services.
- **Immich** - Self-hosted photo and video backup (Google Photos alternative).
- **Nginx Proxy Manager (NPM)** - Simple web interface for managing Nginx proxy hosts.
- **Pi-hole** - Network-wide ad blocker and tracker blocker.

#### ⚠️ Disabled Services (Plex Stack)
These services are configured but not running. Migrated to Stremio + RealDebrid.
To re-enable, uncomment the relevant lines in `docker-compose.yml` and `homepage/config/services.yaml`.

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
Plex and other apps require initial configuration via their UIs after deployment.

1. Ensure Docker and Docker Compose are installed.
2. Ensure `.env` contains all necessary environment variables. Example provided in `.env.sample` file.

```
IP: RPI server’s IP address.
HOMEPAGE_HOST: List of hosts for Homepage.
PLEX_CLAIM: Plex account claim key for linking the server.
SSD1_DRIVE: Additional drive path which is connected  to RPI.
SSD1_PATH: Path to your media storage (inside you have to have two dirs for movies & TV shows).
TRANSMISSION_USERNAME: Username for the Transmission torrent client.
TRANSMISSION_PASSWORD: Password for the Transmission torrent client.
PLEX_IP: Internal IP address of the Plex server.
PLEX_URL: URL to access the Plex UI.
PROWLARR_IP: Internal IP address of the Prowlarr server.
PROWLARR_URL: URL to access the Prowlarr server (torrent indexer) UI.
RADARR_IP: Internal IP address of the Radarr server.
RADARR_URL: URL to access the Radarr server (movie manager) UI.
SONARR_IP: Internal IP address of the Sonarr server.
SONARR_URL: URL to access the Sonarr server (TV show manager) UI.
TRANSMISSION_IP: Internal IP address of the Transmission client.
TRANSMISSION_URL: URL to access the Transmission client.
NPM_IP: Internal IP address of Nginx Proxy Manager.
NPM_URL: URL to access Nginx Proxy Manager UI.
NPM_USERNAME: Username to log in to Nginx Proxy Manager.
NPM_PASSWORD: Password to log in to Nginx Proxy Manager.
PIHOLE_IP: Internal IP address of the Pi-hole server (ad blocker/DNS).
PIHOLE_URL: URL to access the Pi-hole UI.
PIHOLE_PASSWORD: Works with Pi-hole v6. Can be your password or app password.
PLEX_KEY: Authentication key for Plex server.
PROWLARR_KEY: Authentication key for Prowlarr.
RADARR_KEY: Authentication key for Radarr.
SONARR_KEY: Authentication key for Sonarr.
```
3. Then, run the following command to launch all services (set `.env` file path accordingly):

```bash
docker-compose --env-file ~/homelab/.env up -d
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
