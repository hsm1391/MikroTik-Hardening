# =======================================================
#                     MikroTik Hardening
# =======================================================
# Author:            [hsm1391]
# Version:           [Version 1.0]
# =======================================================
# Usage Instructions:
# [Edit predefined values and then copy and paste it into terminal]
# =======================================================
# Known Issues:
# - [Issue 1]: [To be discovered]
# =======================================================
# Change Log:
# - [2-21-2025]: [Release date]
# =======================================================
# Future Work:
# [To be planned]
# =======================================================
# Contact Information:
# - Author Email: [hsm1391business@gmail.com]
# =======================================================
# Description:
# Do not copy & paste it into terminal blindly, you could lose access to your device.
# =======================================================
# Predefined values


# Insert your new admin account name here
:global ChangeDefaultLogin true
:global NewAccount ""
:global NewPassword ""

# Insert your new management ports here
:global ManagementServices true
:global WinboxPort ""
:global SSHPort ""

:global DNSRemoteRequests true
:global IPv6Disabler true
:global DisableBTest true
:global DisableUCL true
:global DisableND true
:global SourceValidationAndSYNCookies false
:global VPNServers true


# Change Default Login User Account
# =======================================================
{
:if ($ChangeDefaultLogin) do={
  :if ( [/user find where name=$NewAccount] ) do={
    /user set [find name=$NewAccount] password=$NewPassword
    :log warning "New Account Already Exist, Password Changed."
  } else={
    /user add name=$NewAccount password=$NewPassword disabled=no group=full
    /user set [find name=$NewAccount] password=$NewPassword
    :log warning "New Account Was Not Found, Created One."
  }

  :if ( [/user find where name=admin] ) do={
    /user remove [find name=admin]
    :log warning "Default Login User Terminated."
  } 
	:log warning message="Default Login Account Secured."
}
}
# =======================================================


# Change Management Services Defaults
# =======================================================
{
:if ($ManagementServices) do={
  /ip service
  set api address="" disabled=yes port=8728
  set api-ssl address="" disabled=yes port=8729
  set ftp address="" disabled=yes port=21
  set ssh address="" disabled=no port=$SSHPort
  set telnet address="" disabled=yes port=23
  set winbox address="" disabled=no port=$WinboxPort
  set www address="" disabled=yes port=80
  set www-ssl address="" disabled=yes port=443

  :log warning message="Management Services Secured"
}
}
# =======================================================


# Disable DNS Remote Requests And Add Basic DNS
# =======================================================
{
:if ($DNSRemoteRequests) do={
  /ip dns set servers=8.8.8.8,8.8.4.4 allow-remote-requests=no
  :log warning message="DNS Remote Request Disabled And Basic DNS Set."
}
}
# =======================================================


# Disable IPv6
# =======================================================
{
:if ($IPv6Disabler) do={
  /ipv6 settings set forward=no
  /ipv6/settings/set disable-ipv6=yes
  /ipv6 nd set [find] disabled=yes
  :log warning message="IPv6 Disabled."
}
}
# =======================================================


# Disable BandwithTest-Server
# =======================================================
{
:if ($DisableBTest) do={
  /tool bandwidth-server set enabled=no
  :log warning message="Bandwidth-server Disabled."
}
}
# =======================================================


# Disable Proxy Socks Upnp Cloud LCD
# =======================================================
{
:if ($DisableUCL) do={
  /ip upnp set enabled=no
  /ip cloud set ddns-enabled=no update-time=no
  /lcd set enabled=no
  :log warning message="Disabled Proxy Socks Upnp Cloud LCD."
}
}
# =======================================================


# Disable NeighborDiscovery On WAN
# =======================================================
{
:if ($DisableND) do={
  /ip neighbor discovery-settings set discover-interface-list=!WAN
  /ip neighbor/discovery-settings/set mode=rx-only
  :log warning message="ND Disabled On WAN."
}
}
# =======================================================


# Enable Source Validation & SYNCookies & ICMP Rate Limit
# =======================================================
{
:if ($SourceValidationAndSYNCookies) do={
  /ip settings set rp-filter=loose
  /ip settings set tcp-syncookies=yes
  /ip settings set icmp-rate-limit=10
  :log warning message="Enabled Source Validation & SYNCookies & ICMP Rate Limit";
}
}


# Disable Unused VPN Servers
# =======================================================
{
:if ($VPNServers) do={
/interface pptp-server server set enabled=no;
/interface l2tp-server set disabled=yes;
/interface sstp-server set disabled=yes;
/interface ovpn-server set disabled=yes;
/interface pppoe-server set disabled=yes [find];
/ip proxy set enabled=no
/ip socks set enabled=no
}
}
# =======================================================


#Reboot device to clear ENV variable cache
/system reboot

