#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 31/05/2016
# Data de atualização: 21/11/2016
# Versão: 0.7
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Configuração dos serviços da sexta etapa, indicado para a distribuição GNU/Linux Ubuntu Server 16.04 LTS x64
#
# Configuração do arquivo interfaces
#	vim /etc/network/interfaces
#
# Configuração do Serviço de SSHD, arquivo sshd_config
#	vim /etc/ssh/sshd_config
#
# Configuração dos arquivos hosts.allow e hosts.deny, utilizando a lib: libwrap.so.0
#	vim /etc/hosts.allow
#	vim /etc/hosts.deny
#
# Configuração do Serviço de DHCPD, arquivo dhcpd.conf
#	vim /etc/dhcp/dhcpd.conf
#
# Configuração dos avisos de acesso remoto, arquivo issue.net
#	vim /etc/issue.net
#
# Utilizar o comando: sudo -i para executar o script
#
# Caminho para o Log do Script-05.sh
LOG="/var/log/script-05.log"
#
# Variável da Data Inicial para calcular tempo de execução do Script
DATAINICIAL=`date +%s`
#
# Validando o ambiente, verificando se o usuário e "root"
USUARIO=`id -u`
UBUNTU=`lsb_release -rs`
KERNEL=`uname -r | cut -d'.' -f1,2`

if [ "$USUARIO" == "0" ]
then
	if [ "$UBUNTU" == "16.04" ]
		then
			if [ "$KERNEL" == "4.4" ]
				then		
					 clear
					 echo -e "Usuário é `whoami`, continuando a executar o Script-05.sh"
					 echo
					 echo -e "Configurando as opções de Rede"
					 echo -e "Configuração do arquivo interfaces"
					 echo -e "Configuração do Serviço de SSHD"
					 echo -e "Configuração dos arquivos hosts.allow e hosts.deny"
					 echo -e "Configuração do Serviço de DHCPD"
					 echo -e "Aguarde..."
					 echo
					 echo -e "Rodando o Script-05.sh em: `date`" > $LOG
					 
					 echo -e "Atualizando as Listas do Apt-Get" >> $LOG
					 echo -e "Atualizando as Listas do Apt-Get"
					 # Exportando o recurso de Noninteractive do Debconf
					 export DEBIAN_FRONTEND=noninteractive
					 #Atualizando as listas do apt-get
					 apt-get update &>> $LOG
					 echo -e "Listas Atualizadas com Sucesso!!!"
					 echo
					 echo -e "Listas Atualizadas com Sucesso!!!" >> $LOG
					 echo >> $LOG
					 echo ============================================================ >> $LOG

					 echo -e "Atualizando o Sistema" >> $LOG
					 echo -e "Atualizando o Sistema"
					 #Fazendo a atualização de todos os pacotes instalados no servidor
					 apt-get -o Dpkg::Options::="--force-confold" upgrade -q -y --force-yes &>> $LOG
					 echo -e "Sistema Atualizado com Sucesso!!!"
					 echo
					 echo -e "Sistema Atualizado com Sucesso!!!" >> $LOG
					 echo >> $LOG
					 echo ============================================================ >> $LOG
					 
					 echo -e "Serviços atualizados com sucesso!!!, pressione <Enter> para continuar com o script"
					 read
					 sleep 2
					 clear
					 echo ============================================================ >> $LOG

					 echo -e "Atualizando o arquivo INTERFACES" >> $LOG
					 echo -e "Editando o arquivo /etc/network/interfaces para acrescentar as informações de endereçamento IP"
					 echo
					 echo -e "Linhas a serem editadas no arquivo /etc/network/interfaces"
					 echo -e "`cat -n /etc/network/interfaces | tail -n3`"
					 echo
					 echo -e "Obs: no Ubuntu 16.04 não é habilitado por padrão as configurações de ETHx nas interfaces"
					 echo -e "No procedimento: script-02.sh foi executado a mudança do GRUB"
					 echo
					 echo -e "Interface padrão no GNU/Linux Ubuntu Server versão: $UBUNTU: `lshw -class network | grep -i "logical name" | cut -d: -f2`"
					 echo -e "Pressione <Enter> para editar o arquivo"
					 echo 
					 read
					 #Fazendo o backup do arquivo de configuração interfaces
					 mv -v /etc/network/interfaces /etc/network/interfaces.old >> $LOG
					 #Copiando o arquivo de configuração interfaces
					 cp -v conf/interfaces /etc/network/interfaces >> $LOG
					 #Editando o arquivo de configuração interfaces
					 vim +23 /etc/network/interfaces
					 #Verificando as informações de Interfaces
					 ifup --verbose --no-act --force --all /etc/network/interfaces >> $LOG
					 echo -e "Atualização feita com sucesso!!!" >> $LOG
					 echo -e "INTERFACES atualizado com sucesso!!!, pressione <Enter> continuando com o script"
					 read
					 sleep s
					 clear
					 echo ============================================================ >> $LOG

					 echo -e "Atualizando o arquivo HOSTS.ALLOW" >> $LOG
					 echo -e "Editando o arquivo /etc/hosts.allow para acrescentar as informações de liberação de acesso remoto"
					 echo
					 echo -e "Linhas a serem editadas no arquivo /etc/hosts.allow"
					 echo -e "`cat -n /etc/hosts.allow`"
					 echo -e "Pressione <Enter> para editar o arquivo"
					 echo 
					 read
					 #Fazendo o backup do arquivo de configuração hosts.allow
					 mv -v /etc/hosts.allow /etc/hosts.allow.old >> $LOG
					 #Copiando o arquivo de configuração hosts.allow
					 cp -v conf/hosts.allow /etc/hosts.allow >> $LOG
					 #Editando o arquivo de configuração hosts.allow
					 vim +24 /etc/hosts.allow
					 echo -e "Atualização feita com sucesso!!!" >> $LOG
					 echo -e "HOSTS.ALLOW atualizado com sucesso!!!, pressione <Enter> para continuando com o script"
					 read
					 sleep 2
					 clear
					 echo ============================================================ >> $LOG

					 echo -e "Atualizando o arquivo HOSTS.DENY" >> $LOG
					 echo -e "Editando o arquivo /etc/hosts.deny para acrescentar as informações de bloqueio de acesso remoto"
					 echo
					 echo -e "Linhas a serem editadas no arquivo /etc/hosts.deny"
					 echo -e "`cat -n /etc/hosts.deny`"
					 echo -e "Pressione <Enter> para editar o arquivo"
					 echo 
					 read
					 #Fazendo o backup do arquivo de configuração hosts.deny
					 mv -v /etc/hosts.deny /etc/hosts.deny.old >> $LOG
					 #Copiando o arquivo de configuração hosts.deny
					 cp -v conf/hosts.deny /etc/hosts.deny >> $LOG
					 #Editando o arquivo de confguração hosts.deny
					 vim +32 /etc/hosts.deny
					 echo -e "Atualização feita com sucesso!!!" >> $LOG
					 echo -e "HOSTS.DENY atualizado com sucesso!!!, pressione <Enter> para continuando com o script"
					 read
					 sleep 2
					 clear
					 echo ============================================================ >> $LOG

					 echo -e "Atualizando o arquivo SSHD_CONFIG" >> $LOG
					 echo -e "Editando o arquivo /etc/ssh/sshd_config para acrescentar as informações de acesso remoto seguro"
					 echo -e "Pressione <Enter> para editar o arquivo"
					 echo 
					 read
					 #Fazendo o backup do arquivo de configuração sshd_config
					 mv -v /etc/ssh/sshd_config /etc/ssh/sshd_config.old >> $LOG
					 #Copiando o arquivo de configuração do sshd_config
					 cp -v conf/sshd_config /etc/ssh/sshd_config >> $LOG
					 #Editando o arquivo de configuração do sshd_config
					 vim /etc/ssh/sshd_config
					 echo -e "Atualização feita com sucesso!!!, pressione <Enter> para testar o arquivo sshd_config"
					 echo -e "Pressione Q para sair"
					 read
					 echo
					 #Verificando as configurações do sshd
					 sshd -T >> $LOG
					 echo
					 echo -e "SSHD_CONFIG atualizado com sucesso!!!, pressione <Enter> para continuando com o script"
					 read
					 sleep 2
					 clear
					 echo ============================================================ >> $LOG

					 echo -e "Atualizando o arquivo DHCPD.CONF" >> $LOG
					 echo -e "Editando o arquivo /etc/dhcp/dhcpd.conf para acrescentar as informações de rede"
					 echo -e "Pressione <Enter> para editar o arquivo"
					 echo 
					 read
					 #Fazendo o backup do arquivo de configuração dhcpd.conf
					 mv -v /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.old >> $LOG
					 #Copiando o arquivo de configuração do dhcpd.conf
					 cp -v conf/dhcpd.conf /etc/dhcp/dhcpd.conf >> $LOG
					 #Editando o arquivo de configuração do dhcpd.conf
					 vim /etc/dhcp/dhcpd.conf
					 echo -e "Atualização feita com sucesso!!!, pressione <Enter> para testar o arquivo dhcpd.conf"
					 read
					 echo
					 #Verificando as configurações do dhcpd
					 dhcpd -t >> $LOG
					 echo
					 echo -e "DHCPD.CONF atualizado com sucesso!!!, pressione <Enter> para continuando com o script"
					 read
					 sleep 2
					 clear
					 echo ============================================================ >> $LOG

					 echo -e "Atualizando o arquivo ISSUE.NET é ISSUE" >> $LOG
					 echo -e "Editando o arquivo /etc/issue.net para acrescentar as informações de acesso remoto"
					 echo -e "Geração do logo do Ubuntu no arquivo /etc/issue utilizando o screenfetch"
					 echo -e "Pressione <Enter> para editar o arquivo"
					 echo 
					 read
					 #Fazendo o backup do arquivo de configuração do issue.net
					 mv -v /etc/issue.net /etc/issue.net.old >> $LOG
					 #Copiando o arquivo de configuração do issue.net
					 cp -v conf/issue.net /etc/issue.net >> $LOG
					 #Editando o arquivo de configuração do issue.net
					 vim /etc/issue.net
					 #Atualizando o arquivo de configuração issue para o comando screenfetch, gerando uma imagem do Ubuntu com códigos ASCII
					 screenfetch > /etc/issue
					 echo -e "Atualização feita com sucesso!!!" >> $LOG
					 echo -e "ISSUE.NET atualizado com sucesso!!!, pressione <Enter> continuando com o script"
					 read
					 sleep 2
					 clear
					 echo ============================================================ >> $LOG

					 echo >> $LOG
					 echo -e "Fim do Script-05.sh em: `date`" >> $LOG

					echo
					echo -e "Configuração de Rede feita com sucesso!!!!!"
					echo
					# Script para calcular o tempo gasto para a execução do script-05.sh
						DATAFINAL=`date +%s`
						SOMA=`expr $DATAFINAL - $DATAINICIAL`
						RESULTADO=`expr 10800 + $SOMA`
						TEMPO=`date -d @$RESULTADO +%H:%M:%S`
					echo -e "Tempo gasto para execução do script-05.sh: $TEMPO"
					echo -e "Pressione <Enter> para concluir o processo e reinicializar o servidor."
					read
					sleep 2
					reboot
					else
						 echo -e "Versão do Kernel: $KERNEL não homologada para esse script, versão: >= 4.4 "
						 echo -e "Pressione <Enter> para finalizar o script"
					read
			fi					
		else
			 echo -e "Distribuição GNU/Linux: `lsb_release -is` não homologada para esse script, versão: $UBUNTU"
			 echo -e "Pressione <Enter> para finalizar o script"
			read
		fi
else
	 echo -e "Usuário não é ROOT, execute o comando com a opção: sudo -i <Enter> depois digite a senha do usuário `whoami`"
	 echo -e "Pressione <Enter> para finalizar o script"
	read
fi
