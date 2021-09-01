bind_install() {

	echo "Instalação..."
	apt-get update
	apt-get install bind9 dnsutils -y

	echo "Inicialização..."
	systemctl start bind9
	systemctl enable bind9
}

ns1_config () {
	
	file_config=$1
	file_bd=$2
	echo "Configuração"
	cp $file_config /etc/bind/named.conf.local  
	
	echo "Popular o Banco"
	cp $file_bd /var/cache/bind

	sed -i 's/OPTIONS="-u bind"/OPTIONS="-u bind -4"/g' /etc/default/bind9

	echo "Reiniciar bind9"
	systemctl restart bind9
}

rota_config() {
	firewall=$1
	echo "configurando rota"
	ip route add default via $firewall
	echo "nameserver 127.0.0.1" >> /etc/resolv.conf 	
}

main() {
	rota_config 192.168.42.10
	bind_install
	ns1_config /vagrant/files/master.conf.local /vagrant/files/db.exemplo
}

main