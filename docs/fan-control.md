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

1. Edit `fan_control.sh` — replace `/path/to/` with the actual path to `fan_control.py`
2. Copy the script to `/etc/init.d`:
   ```bash
   sudo cp fan_control.sh /etc/init.d/fan_control
   sudo chmod +x /etc/init.d/fan_control
   ```
3. Start the service:
   ```bash
   sudo /etc/init.d/fan_control start
   ```
