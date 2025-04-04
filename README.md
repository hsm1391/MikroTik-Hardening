# MikroTik RouterOS Hardening Guide

This document provides a comprehensive set of best practices to secure your MikroTik RouterOS devices. By following these guidelines, you can significantly reduce the attack surface, protect against common vulnerabilities, and ensure a secure network environment.

__You can use the automated script to apply all changes, edit predefined values and paste it into terminal.__
[Hardening-Rules.rsc](https://github.com/hsm1391/MikroTik-Hardening/blob/main/Hardening-Rules.rsc)

---

## Table of Contents
1. [Introduction](#introduction)
2. [Best Practices](#best-practices)
   - [Update RouterOS](#update-routeros)
   - [Create Interface List](#create-interface-list)
   - [Change Default Credentials](#change-default-credentials)
   - [Disable Unused Services](#disable-unused-services)
   - [Secure Winbox Access](#secure-winbox-access)
   - [Enable Firewall](#enable-firewall)
   - [Use Strong Encryption](#use-strong-encryption)
   - [Disable Unused Interfaces](#disable-unused-interfaces)
   - [Disable VPN Servers](#disable-vpn-servers)
   - [Enable MAC Address Filtering](#enable-mac-address-filtering)
   - [Disable UPnP](#disable-upnp)
   - [Regular Backups](#regular-backups)
   - [Monitor and Audit](#monitor-and-audit)
3. [Contributing](#contributing)

---

## Introduction
MikroTik RouterOS is a powerful and versatile operating system used in networking devices. However, its flexibility also makes it a target for attackers if not properly secured. This guide outlines essential steps to harden your MikroTik device, ensuring it remains resilient against potential threats.

---

## Best Practices
### Update RouterOS
Ensure your MikroTik device is running the latest stable version of RouterOS to patch known vulnerabilities.

```bash
/system package update download;
/system reboot;
```

When device booted make sure to update the firmware with this command

```bash
/system routerboard upgrade;
/system reboot;
```

---

### Create Interface List
Create WAN and LAN interface lists to be used in firewall rules and other configurations throughout this guide. Ensure that the relevant interfaces are added to the appropriate lists.

```bash
/interface list add name=LAN
/interface list add name=WAN
/interface list member add disabled=no list=LAN interface=YourLanInterface;
/interface list member add disabled=no list=WAN interface=YourWanInterface;
```

---

### Change Default Credentials

Replace the default username (admin) and password with a strong, unique password.

```bash
/user add name="YourUserName" password="YourStrongPassword" disabled=no group=full;
```

---

### Disable Unused Services

Turn off unnecessary services (e.g., FTP, Telnet, Winbox, API) and change default port number associated to them to reduce the attack surface.

```bash
/ip service
  set api disabled=yes
  set api-ssl disabled=yes
  set ftp disabled=yes
  set ssh disabled=yes
  set telnet disabled=yes
  set winbox disabled=no
  set www disabled=yes
  set www-ssl disabled=yes

/ip ssh regenerate-host-key;
/ip dns set allow-remote-requests=no;
/tool bandwidth-server set enabled=no;
/ip cloud set ddns-enabled=no update-time=no;
/ip settings set send-redirects=no accept-redirects=no secure-redire cts=no accept-source-route=no;
```

If you are not using IPV6 it's better to disable it.
```bash
/ipv6 settings set forward=no;
/ipv6/settings/set disable-ipv6=yes;
/ipv6 nd set [find] disabled=yes;
```

If you do not use neighbor discovery you should disabled it or make it only work on LAN side.
```bash
/ip neighbor discovery-settings set discover-interface-list=!WAN;
/ip neighbor/discovery-settings/set mode=rx-only;
```


---

### Secure Winbox Access

Restrict Winbox access to specific IP addresses or MAC addresses and use a non-default port.

```bash
/ip service set winbox disabled=no port=YourWinboxPort address=YourNetworkAddress;
```

---

### Enable Firewall

Configure a robust firewall to block unauthorized access, including dropping invalid connections and limiting access to management interfaces.
You can use my advanced mikrotik firewall from the link below:

[Advanced-MikroTik-Firewall](https://github.com/hsm1391/Advanced-MikroTik-Firewall)

---

### Use Strong Encryption

Disable weak encryption protocols (e.g., SSLv3, TLS 1.0) and use strong encryption for VPNs and wireless networks.

---

### Disable Unused Interfaces

Turn off unused physical and virtual interfaces to prevent unauthorized access.
You can also turn off lcd for added security.

```bash
/lcd set enabled=no;
```

---

### Disable VPN Servers

Disable unused VPN servers to minimize exposure.

```bash
/interface pptp-server server set enabled=no;
/interface l2tp-server set disabled=yes;
/interface sstp-server set disabled=yes;
/interface ovpn-server set disabled=yes;
/interface pppoe-server set disabled=yes [find];
/ip proxy set enabled=no;
/ip socks set enabled=no;
/ip ssh set forwarding-enabled=no;
```

---

### Enable MAC Address Filtering

Restrict Wireless network access to known MAC addresses for added security.

```bash
/add action=accept disabled=no mac-address=YourDeviceMacAddress mac-address-mask=FF:FF:FF:FF:FF:FF;
/interface wifi access-list add action=reject disabled=no;
```
 
---

### Disable UPnP

Turn off Universal Plug and Play (UPnP) to prevent unauthorized port forwarding.
 
```bash
/ip upnp set enabled=no;
```

---

### Regular Backups

Schedule regular backups of the configuration and store them securely.

```bash
/system backup save name=YourDeviceIdentity;
/export file=YourDeviceIdentity;
```

---

### Monitor and Audit

Regularly review logs, firewall rules, and user activity for signs of suspicious behavior.

```bash
/log print;
```

---

## Contributing

Contributions to this guide are welcome! If you have additional tips, suggestions, or corrections, please open an issue or submit a pull request.

---


Disclaimer: This guide is provided for educational purposes only. Always test configurations in a controlled environment before deploying them in production. The authors are not responsible for any damages or issues arising from the use of this guide.