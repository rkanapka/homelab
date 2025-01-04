# Raspberry Pi HomeLab

Welcome to my personal homelab project!<br/>
This repository contains the configuration files, automation scripts, and deployment instructions for managing my Raspberry Pi-based homelab environment.

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
1. Ensure Docker and Docker Compose are installed.
2. Ensure `.env` contains all necessary environment variables. Example provided in `.env.sample` file.
```
IP: RPI server’s IP address.
PLEX_CLAIM: Plex account claim key for linking the server.
SSD1_PATH: Path to your media storage (inside you have to have two dirs for movies & TV shows).
TRANSMISSION_USERNAME: Username for the Transmission torrent client.
TRANSMISSION_PASSWORD: Password for the Transmission torrent client.
PLEX_URL: URL to access the Plex server.
PROWLARR_URL: URL to access the Prowlarr server (torrent indexer).
RADARR_URL: URL to access the Radarr server (movie manager).
SONARR_URL: URL to access the Sonarr server (TV show manager).
TRANSMISSION_URL: URL to access the Transmission client.
PLEX_KEY: Authentication key for Plex server.
PROWLARR_KEY: Authentication key for Prowlarr.
RADARR_KEY: Authentication key for Radarr.
SONARR_KEY: Authentication key for Sonarr.
```
3. Then, run the following command to launch all services (set `.env` file path accordingly):

```bash
docker-compose --env-file ~/homelab/.env up -d
```

4. You will have to additionally configure Plex, Prowlarr, Sonnar, Radarr & Transimission settings via UI.

---

### 📄 Notes

Services can be monitored through the Homepage dashboard.<br/>
For any questions or contributions, feel free to open an issue!
