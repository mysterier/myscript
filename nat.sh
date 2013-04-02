#!/bin/bash
#p_conntrack
#modprobe ip_conntrack_ftp
#modprobe ip_nat_ftp
#modprobe ip_conntrack_irc
#modprobe ip_nat_irc

/sbin/iptables -F
/sbin/iptables -X
/sbin/iptables -Z
/sbin/iptables -F -t filter
/sbin/iptables -X -t filter
/sbin/iptables -Z -t filter
/sbin/iptables -F -t nat
/sbin/iptables -X -t nat
/sbin/iptables -Z -t nat

/sbin/iptables -P INPUT DROP
/sbin/iptables -P OUTPUT ACCEPT
/sbin/iptables -P FORWARD ACCEPT

#deny IP
/sbin/iptables -A INPUT -i eth0 -s 66.249.69.243 -j DROP
/sbin/iptables -A INPUT -i eth0 -s 66.249.71.218 -j DROP
/sbin/iptables -A INPUT -i eth0 -s 65.55.3.174   -j DROP
#-----------ACCEPT From Moker's IPs-------------#
/sbin/iptables -A INPUT -i lo -j ACCEPT
/sbin/iptables -A INPUT -s 192.168.2.0/24 -j ACCEPT

#Allow Ping
/sbin/iptables -A INPUT -p icmp -j ACCEPT

#DNS,time.stdtime.gov.tw
#ptables -A INPUT -i eth0 -s  168.95.1.1 -j ACCEPT
#/sbin/iptables -A INPUT -i eth0 -s  59.124.196.84 -j ACCEPT

#Drop Ping From Outside
#/sbin/iptables -A INPUT -p icmp --icmp-type 8 -j DROP

#Shanghai IDC
/sbin/iptables -A INPUT -s  222.73.208.86 -j ACCEPT
#SLICEHOST
/sbin/iptables -A INPUT -s 174.143.153.38 -j ACCEPT


#-----------ACCEPT From OutSide-------------#
/sbin/iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
/sbin/iptables -A INPUT -i eth0 -p tcp --dport 80 -j ACCEPT
/sbin/iptables -A INPUT -i eth0 -p tcp --dport 443 -j ACCEPT
/sbin/iptables -A INPUT -i eth0 -p tcp --dport 2222 -j ACCEPT
/sbin/iptables -A INPUT -i eth0 -p tcp --dport 11211 -j ACCEPT
/sbin/iptables -A INPUT -i eth0 -p tcp --dport 3306 -j ACCEPT
/sbin/iptables -A INPUT -i eth0 -p tcp --dport 22 -j ACCEPT
/sbin/iptables -A INPUT -i eth0 -p tcp --dport 21 -j ACCEPT
/sbin/iptables -A INPUT -i eth0 -p tcp --dport 20 -j ACCEPT
/sbin/iptables -A INPUT -i eth0 -p tcp --dport 50000:51000 -j ACCEPT

/sbin/iptables-save > /etc/sysconfig/iptables

