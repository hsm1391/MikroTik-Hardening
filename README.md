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
   - [Enable Logging](#enable-logging)
   - [Restrict Management Access](#restrict-management-access)
   - [Disable IP Services](#disable-ip-services)
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
--
### Update RouterOS
Ensure your MikroTik device is running the latest stable version of RouterOS to patch known vulnerabilities.

```console
/system package update download;
/system reboot;
```

When device booted make sure to update the firmware with this command

```bash
/system routerboard upgrade;
/system reboot;
```

### Change Default Credentials

Replace the default username (admin) and password with a strong, unique password.

### Disable Unused Services

Turn off unnecessary services (e.g., FTP, Telnet, Winbox, API) to reduce the attack surface.  

### Secure Winbox Access

Restrict Winbox access to specific IP addresses or MAC addresses and use a non-default port.



### Enable Firewall

Configure a robust firewall to block unauthorized access, including dropping invalid connections and limiting access to management interfaces.
 

### Use Strong Encryption

Disable weak encryption protocols (e.g., SSLv3, TLS 1.0) and use strong encryption for VPNs and wireless networks.
 

### Disable Unused Interfaces

Turn off unused physical and virtual interfaces to prevent unauthorized access.


### Enable Logging

Set up logging to monitor and audit system activity, including firewall drops and login attempts.


### Restrict Management Access

Allow management access (Winbox, SSH, WebFig) only from trusted IP addresses or networks.


### Disable IP Services

Disable unused IP services (e.g., API, IPsec, PPP) to minimize exposure.

### Enable MAC Address Filtering

Restrict network access to known MAC addresses for added security.
 
### Disable UPnP

Turn off Universal Plug and Play (UPnP) to prevent unauthorized port forwarding.
 
### Regular Backups

Schedule regular backups of the configuration and store them securely.


### Monitor and Audit

Regularly review logs, firewall rules, and user activity for signs of suspicious behavior.

/log print  

## Contributing

Contributions to this guide are welcome! If you have additional tips, suggestions, or corrections, please open an issue or submit a pull request.


Disclaimer: This guide is provided for educational purposes only. Always test configurations in a controlled environment before deploying them in production. The authors are not responsible for any damages or issues arising from the use of this guide.