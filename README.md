# Título

## Sumário:

1. [Motivation](#motivacao)
2. [File description](#file)
3. [Interação com o projeto](#interact)
4. [Autor e referências](#autor)
5. [Base de conhecimento](#ack)

## Motivação <a name="motivacao"></a>
Problemas de compatibilidade de regras de firewall podem impedir a replicação entre servidores DNS primario e secundarios que estão separados por um firewall. O ambiente constrói um laboratório para verificar as regras de firewall necessárias para uma replicação entre os DNS de forma correta.   

## Descrição de arquivos <a name="file"></a>
master.conf.local - Arquivo de configuração do servidor DNS master.
slave.conf.local - Arquivo de configuração do servidor DNS secundário.
db.exemplo - Arquivo de zona DNS.
ns1.sh - script de provisionamento do DNS primário.
ns2.sh - script de provisionamento do DNS secundário.
fw1.sh - script de provisionamento do firewall. As regras para replicação DNS estão na função firewall_config deste script.
rules - Regras secundarias de firewall. Estas regras são usadas no laboratório para testar alguma incompatibilidade. As regras de replicação DNS estão em fw1.sh.

## Interação com o projeto <a name="interact"></a>
Para levantar o laboratório é preciso garantir a ordem de criação das VMs. Para isso damos o comando abaixo:

vagrant up fw1 ns1 ns2

## Autor e referências <a name="autor"></a>
Ricardo Coelho

## Base de conhecimento <a name="ack"></a>
Bind - (Berkeley Internet Name Domain ou, como chamado previamente, Berkeley Internet Name Daemon) é o servidor para o protocolo DNS mais utilizado na Internet, especialmente em sistemas do tipo Unix, onde ele pode ser considerado um padrão.

Iptables - utilizado como ferramenta que configura regras para o protocolo de internet IPv4 na tabela de filtragem de pacotes, utilizando os módulos e framework do kernel Linux.   