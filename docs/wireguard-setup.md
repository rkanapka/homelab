# WireGuard VPN Setup (WG-Easy)

How to configure external access to your homelab via WireGuard VPN using WG-Easy.

**Router tested on:** Asus RT-AX58U

---

## Overview

WG-Easy runs as a Docker container and provides both the WireGuard VPN server and a web UI for managing clients.

External access requires:
1. A DuckDNS domain pointing to your **public** IP
2. Port forwarding on your router (UDP 51820)
3. A WireGuard client app on your device

---

## Step 1: DuckDNS Setup

1. Go to [duckdns.org](https://duckdns.org) and log in
2. Create a subdomain (e.g. `yourname-vpn`) — this will give you `yourname-vpn.duckdns.org`
3. Set its IP to your **public IP** (not your local `192.168.x.x` IP)
   - Find your public IP with: `curl https://api.ipify.org`
4. Click **Update IP** and confirm it saved

> **Important:** The DuckDNS domain must point to your public IP, not your local network IP.
> Set `WG_HOST` in your `.env` to the full domain, e.g. `yourname-vpn.duckdns.org`.

## Step 2: Router Port Forwarding (Asus RT-AX58U)

1. Log in to the Asus router admin page
2. Go to **Settings → WAN → Port Forwarding**
3. Add a new rule:

| Field | Value |
|-------|-------|
| Service Name | `WireGuard` |
| Protocol | `UDP` |
| Port Range | `51820 : 51820` |
| Local IP | your RPi's static IP (e.g. `192.168.1.x`) |
| Local Port | `51820` |
| Source IP | *(leave empty)* |

4. Click **Add** then **Apply**

> **Note:** The RPi must have a static IP. If using DHCP, add a MAC address reservation under
> **LAN → IP Binding → IP Binding List** so the router always assigns the same IP.

---

## Step 3: Connect a Client

1. Open WG-Easy web UI → click **New** → enter a device name → **Create**
2. Install the WireGuard app on your device:
   - **Mobile:** [iOS](https://apps.apple.com/app/wireguard/id1441195209) / [Android](https://play.google.com/store/apps/details?id=com.wireguard.android)
   - **Desktop:** [wireguard.com/install](https://www.wireguard.com/install/)
3. In WG-Easy, click the **QR code** icon on your client → scan with the mobile app
   - Or click the **download** icon to get the `.conf` file for desktop
4. Enable the VPN tunnel on your device

---

## Verify It Works

Turn off WiFi on your phone (mobile data only), enable WireGuard, then try accessing a local service:

```
http://YOUR_RPI_IP:9080   ← Pi-hole
http://YOUR_RPI_IP:3001   ← Uptime Kuma
```

On the RPi, confirm the handshake completed:
```bash
docker exec wg-easy wg show
```

Look for `latest handshake` under your peer — it should show a recent time and non-zero `transfer` bytes.
