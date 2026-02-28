# Pi-hole Router Setup

How to configure your router to use Pi-hole as the DNS server.

**Router tested on:** Asus RT-AX58U (Firmware 3.0.0.4.388_25210)
📘 [How to configure router to use Pi-Hole? (Asus support)](https://www.asus.com/support/faq/1046062/)

---

## Step 1: Set a Static IP for the Raspberry Pi

Go to your router's **LAN → DHCP Server** settings and assign a static IP to your Raspberry Pi.

![Set Static IP](https://github.com/user-attachments/assets/56088dd1-6ec2-4bc3-9684-69129a31c641)

---

## Step 2: Set Pi-hole as Your DNS Server

Under **WAN → Internet Connection**, set the DNS Server fields to the Pi-hole's static IP address.

![Set DNS to Pi-hole](https://github.com/user-attachments/assets/f2209f29-fc92-478e-a934-95e3dadca035)

---

## Step 3: (Optional) Allow All Origins in Pi-hole

If you get a `DNS_PROBE_FINISHED_BAD_CONFIG` error, go to **Pi-hole Admin → Settings → DNS** and enable "Permit all origins" to allow DNS requests from all devices.

![Allow All Origins](https://github.com/user-attachments/assets/61172b78-edf3-44a6-898b-25cfb1a24808)
