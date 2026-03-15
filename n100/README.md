# N100

### 📡 Hardware
- **Device**: Ninkear N10 Mini PC
- **CPU**: Intel N100 (4-core, Alder Lake-N)
- **RAM**: 16GB DDR4
- **Storage**: 512GB SSD
- **OS**: Debian GNU/Linux 13 (trixie)

---

### 🧰 Services

- **Immich** - Photo & video backup (Google Photos alternative).
- **Glances** - System resource monitoring (CPU, memory, disk, network).
- **Docker Socket Proxy** - Read-only Docker API proxy exposed on port 2376 for Homepage on RPi4.

---

### 🚀 Deployment

```bash
cd ~/homelab/n100
docker compose --env-file .env up -d
```

Copy `.env.sample` → `.env` and fill in:

```
N100_SSD1_DRIVE:         Mount path of the SSD.
IMMICH_VERSION:          Immich image tag (default: release).
IMMICH_UPLOAD_PATH:      Path on the SSD where photos/videos are stored.
IMMICH_DB_PATH:          Path on the SSD for the Immich PostgreSQL database.
IMMICH_DB_USERNAME:      PostgreSQL username for Immich.
IMMICH_DB_PASSWORD:      PostgreSQL password for Immich.
IMMICH_DB_DATABASE_NAME: PostgreSQL database name for Immich.
```

After first deploy, open `http://<IP>:2283` to create the admin account.
