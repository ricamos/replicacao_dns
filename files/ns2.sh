source /vagrant/files/ns1.sh

main() {
	#rota_config
	bind_install
	ns1_config /vagrant/files/slave.conf.local /vagrant/files/db.exemplo
}

main