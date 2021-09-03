#!/bin/sh

firewall_config() {

	NS1=192.168.42.20
	NS2=172.16.42.20

	echo 1 > /proc/sys/net/ipv4/ip_forward

	iptables -t filter -F
	iptables -t nat -F

	iptables -P FORWARD DROP

	iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

	iptables -t filter -A FORWARD -p udp -s 172.16.42.0/24 -d 0/0 --dport 53 -j ACCEPT -m comment --comment "Resolução DNS"
	iptables -t filter -A FORWARD -p udp -s 0/0 -d 172.16.42.0/24 --sport 53  -j ACCEPT -m comment --comment "Resolução DNS"

	iptables -t filter -A FORWARD -p tcp -m multiport -s 172.16.42.0/24 -d 0/0 --dport 80,443 -j ACCEPT -m comment --comment "Baixar pacoter apt"
	iptables -t filter -A FORWARD -p tcp -m multiport -s 0/0 -d 172.16.42.0/24 --sport 80,443 -j ACCEPT -m comment --comment "Baixar pacoter apt"

	# Iniciando as Regras
	bash /vagrant/files/rules
}

main() {
	firewall_config
}

main