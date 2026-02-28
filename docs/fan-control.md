# Fan Control Setup

The `fan_control.py` script manages CPU & GPU temperatures by controlling a 5V fan through a GPIO pin.

## Hardware

The fan connects to an NPN 2N2222A transistor, enabling automatic on/off control via GPIO.

Example circuit diagram:
![Circuit Diagram](https://github.com/user-attachments/assets/dfefdb75-9d30-48e5-855b-3c200305644f)

## Behavior

- Fan activates at **65°C**
- Fan deactivates at **40°C**

Check current CPU temperature:
```bash
vcgencmd measure_temp
```

## Setup (run on boot)

1. Edit `fan_control.sh` — replace `/path/to/homelab/` with the actual path to your homelab directory (e.g. `/home/youruser/homelab/`)
2. Copy the script to `/etc/init.d`:
   ```bash
   sudo cp fan_control.sh /etc/init.d/fan_control
   sudo chmod +x /etc/init.d/fan_control
   ```
3. Enable it to run automatically on every boot:
   ```bash
   sudo update-rc.d fan_control defaults
   ```
4. Start it now (without rebooting):
   ```bash
   sudo /etc/init.d/fan_control start
   ```

To disable autostart:
```bash
sudo update-rc.d fan_control remove
```

## Verify

Check if autostart is registered (look for symlinks in runlevel directories):
```bash
ls /etc/rc*.d/ | grep fan_control
```

Expected output when enabled:
```
K01fan_control   ← runlevels 0, 1, 6 (halt/reboot — K = Kill)
S01fan_control   ← runlevels 2, 3, 4, 5 (normal boot — S = Start)
```

Check if the script is currently running:
```bash
ps aux | grep fan_control
```
