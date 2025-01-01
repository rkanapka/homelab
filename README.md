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
  
- **Behavior**:
  - Fan activates at **65°C** and deactivates at **40°C** to maintain optimal temperature.
  
---

### 🚀 How to Start the Project
1. Ensure Docker and Docker Compose are installed.
2. Ensure `.env` contains all necessary environment variables. Example provided in `.env.sample` file.
    * PLEX_CLAIM – Plex claim token for server linking.
    * SSD1_PATH – Path to the SSD for storing media and downloads.
    * TRANSMISSION_USERNAME – Username for Transmission web interface.
    * TRANSMISSION_PASSWORD – Password for Transmission web interface.
3. Then, run the following command to launch all services (set `.env` file path accordingly):

```bash
docker-compose --env-file ~/homelab/.env up -d
```

4. You will have to additionally configure Plex, Prowlarr, Sonnar, Radarr & Transimission settings via UI.

---

### 📄 Notes

Services can be monitored through the Homepage dashboard.<br/>
For any questions or contributions, feel free to open an issue!
