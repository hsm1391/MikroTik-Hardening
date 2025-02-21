# MikroTik RouterOS Hardening Guide

This document provides a comprehensive set of best practices to secure your MikroTik RouterOS devices. By following these guidelines, you can significantly reduce the attack surface, protect against common vulnerabilities, and ensure a secure network environment.

---

## Table of Contents
1. [Introduction](#introduction)
2. [Best Practices](#best-practices)
   - [Update RouterOS](#update-routeros)
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

### Change Default Credentials

Replace the default username (admin) and password with a strong, unique password.

```bash
/user add name="YourUserName" password="YourStrongPassword" disabled=no group=full
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
```

---

### Secure Winbox Access

Restrict Winbox access to specific IP addresses or MAC addresses and use a non-default port.

```bash
/ip service set winbox disabled=no port=YourWinboxPort address=YourNetworkAddress
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

---

### Disable VPN Servers

Disable unused VPN servers (e.g., API, IPsec, PPP) to minimize exposure.

---

### Enable MAC Address Filtering

Restrict network access to known MAC addresses for added security.
 
---

### Disable UPnP

Turn off Universal Plug and Play (UPnP) to prevent unauthorized port forwarding.
 
---

### Regular Backups

Schedule regular backups of the configuration and store them securely.

---

### Monitor and Audit

Regularly review logs, firewall rules, and user activity for signs of suspicious behavior.

/log print  

---

## Contributing

Contributions to this guide are welcome! If you have additional tips, suggestions, or corrections, please open an issue or submit a pull request.

---


Disclaimer: This guide is provided for educational purposes only. Always test configurations in a controlled environment before deploying them in production. The authors are not responsible for any damages or issues arising from the use of this guide.