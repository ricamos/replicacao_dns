firewall_config() {

	NS1=192.168.42.20
	NS2=172.16.42.20

	echo 1 > /proc/sys/net/ipv4/ip_forward

	iptables -t filter -F
	iptables -t nat -F

	iptables -P FORWARD DROP

	iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

	iptables -t filter -A FORWARD -p udp -s $NS2 -d $NS1 --dport 53 -j ACCEPT -m comment --comment "Transferencia de zona DNS - AXFR"
	iptables -t filter -A FORWARD -p udp -s $NS1  -d $NS2 --sport 53 -j ACCEPT -m comment --comment "Transferencia de zona DNS - AXFR"

	iptables -t filter -A FORWARD -p tcp -s $NS2 -d $NS1 --dport 53 -j ACCEPT -m comment --comment "Transferencia de zona DNS - AXFR"
	iptables -t filter -A FORWARD -p tcp -s $NS1 -d $NS2 --sport 53 -j ACCEPT -m comment --comment "Transferencia de zona DNS - AXFR"

	iptables -t filter -A FORWARD -p udp -s $NS1 -d $NS2 --dport 53 -j ACCEPT -m comment --comment "Notify DNS secundario"
	iptables -t filter -A FORWARD -p udp -s $NS2  -d $NS1 --sport 53 -j ACCEPT -m comment --comment "Notify DNS secundario"

	iptables -t filter -A FORWARD -p udp -s 0/0 -d 0/0 --dport 53 -j ACCEPT -m comment --comment "Resolução DNS"
	iptables -t filter -A FORWARD -p udp -s 0/0 -d 0/0 --sport 53  -j ACCEPT -m comment --comment "Resolução DNS"

	iptables -t filter -A FORWARD -p tcp -m multiport -s 0/0 -d 0/0 --dport 80,443 -j ACCEPT -m comment --comment "Baixar pacoter apt"
	iptables -t filter -A FORWARD -p tcp -m multiport -s 0/0 -d 0/0 --sport 80,443 -j ACCEPT -m comment --comment "Baixar pacoter apt"
}

main() {
	firewall_config
}

main