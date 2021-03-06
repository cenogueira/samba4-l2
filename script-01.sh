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
# Instalação dos pacotes principais para a segunda etapa, indicado para a distribuição GNU/Linux Ubuntu Server 16.04 LTS x64
#
# NTP (Network Time Protocol) Servidor de Data/Hora
# KRB5 (Kerberos) Protocolo de Autenticação Segura
# NFS (Network File System) Protocolo de Transferência de Arquivos
# ACL (Access Control List) Permissões de Arquivos e Diretórios
# ATTR (Extended Attributes) Atributos Extendidos
#
# Após o reboot fazer as mudanças do arquivo /etc/fstab para suportar os recursos de ACL e XATTR EXT4
#	vim /etc/fstab
#	defaults,barrier=1
#
# Se tiver utilizando o sistema de arquivos BTRFS, deixar o padrão
#	vim /etc/fstab
#	defaults,subvol=@
#
# Após o reboot configurar o arquivo /etc/ntp.conf para atualizar data e hora dos servidores do NTP.br
#	 mv /etc/ntp.conf /etc/ntp.conf.old
#	 cp ntp.drift /etc/
#	 cp ntp.conf /etc/
#
# Na instalação fazer a criação do REALM do Kerberos
#	REALM: 	PTI.INTRA
#	SERVER:	ptispo01dc01.pti.intra	
#	ADMIN:	ptispo01dc01.pti.intra
#	debconf-show krb5-config
#
# Configuração do NFS será feita no final do curso
#
# Utilizar o comando: sudo -i para executar o script
#
# Caminho para o Log do Script-01.sh
LOG="/var/log/script-01.log"
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
					 # Variáveis de configuração do Kerberos
					 REALM="PTI.INTRA"
					 SERVERS="ptispo01dc01.pti.intra"
					 ADMIN="ptispo01dc01.pti.intra"
					 NTP="a.st1.ntp.br"
					 #
					 # Exportando o recurso de Noninteractive do Debconf
					 export DEBIAN_FRONTEND="noninteractive"
					 #
					 echo -e "Usuário é `whoami`, continuando a executar o Script-01.sh"
					 echo
					 echo -e "Instalação dos principais pacotes de rede e suporte ao sistema de arquivos"
					 echo -e "NTP (Network Time Protocol) Servidor de Data é Hora"
					 echo -e "KRB5 (Kerberos) Protocolo de Autenticação Segura"
					 echo -e "NFS (Network File System) Protocolo de Transferência de Arquivos"
					 echo -e "ACL (Access Control List) Permissões de Arquivos e Diretórios"
					 echo -e "ATTR (Extended Attributes) Atributos Extendidos"
					 echo -e "Configuração do FSTAB para suporte a ACL e XATTR"
					 echo
					 echo -e "Após o término o Servidor será reinicializado"
					 echo
					 echo -e "Aguarde..."
					 echo
					 echo -e "Rodando o Script-01.sh em: `date`" > $LOG
					 echo ============================================================ >> $LOG
					 echo -e "Atualizando as Listas do Apt-Get" >> $LOG
					 echo -e "Atualizando as Listas do Apt-Get"
					 #Atualizando as listas do apt-get
					 apt-get update &>> $LOG
					 echo -e "Listas Atualizadas com Sucesso!!!"
					 echo
					 echo -e "Listas Atualizadas com Sucesso!!!" >> $LOG
					 echo ============================================================ >> $LOG

					 echo -e "Atualizando o Sistema" >> $LOG
					 echo -e "Atualizando o Sistema"
					 #Fazendo a atualização de todos os pacotes instalados no servidor
					 apt-get -o Dpkg::Options::="--force-confold" upgrade -q -y --force-yes &>> $LOG
					 echo -e "Sistema Atualizado com Sucesso!!!"
					 echo
					 echo -e "Sistema Atualizado com Sucesso!!!" >> $LOG
					 echo ============================================================ >> $LOG

					 echo -e "Instalando as Dependências da Parte de Rede" >> $LOG
					 echo -e "Instalando as Dependências da Parte de Rede, aguarde..."
					 #Instalando os principais pacotes para o funcionamento correto dos serviços de rede
					 apt-get -y install ntp ntpdate build-essential libacl1-dev libattr1-dev libblkid-dev libgnutls-dev libreadline-dev python-dev libpam0g-dev python-dnspython gdb pkg-config libpopt-dev libldap2-dev dnsutils libbsd-dev docbook-xsl libcups2-dev nfs-kernel-server nfs-common acl attr debconf-utils screenfetch figlet sysv-rc-conf &>> $LOG
					 echo -e "Instalação das Dependências Feita com Sucesso!!!"
					 echo
					 echo -e "Instalação das Dependências Feita com Sucesso!!!" >> $LOG
					 echo ============================================================ >> $LOG

					 echo -e "Configurando o Kerberos" >> $LOG
					 echo -e "Configurando o Kerberos"
					 #Configurando o Debconf para a configurações do Kerberos trabalhar com Nointeractive
					 echo "krb5-config krb5-config/default_realm string $REALM" |  debconf-set-selections
					 echo "krb5-config krb5-config/kerberos_servers string $SERVERS" |  debconf-set-selections
					 echo "krb5-config krb5-config/admin_server string $ADMIN" |  debconf-set-selections
					 echo "krb5-config krb5-config/add_servers_realm string $REALM" |  debconf-set-selections
					 echo "krb5-config krb5-config/add_servers boolean true" |  debconf-set-selections
					 echo "krb5-config krb5-config/read_config boolean true" |  debconf-set-selections
					 echo  >> $LOG
					 #Exibindo as configurações do Debconf do Kerberos
					 debconf-show krb5-config >> $LOG
					 echo  >> $LOG
					 echo -e "Instalando o Kerberos"  >> $LOG
					 echo -e "Instalando o Kerberos"
					 #Instalando o Kerberos
					 apt-get -y install krb5-user krb5-config &>> $LOG
					 echo -e "Kerberos Configurado com Sucesso!!!"
					 echo
					 echo -e "Kerberos Configurado com Sucesso!!!" >> $LOG
					 echo ============================================================ >> $LOG
					 echo  >> $LOG
					 
					 echo -e "Limpando o Cache do Apt-Get" >> $LOG
					 echo -e "Limpando o Cache do Apt-Get"
					 #Limpando o diretório de cache do apt-get
					 apt-get clean &>> $LOG
					 echo -e "Cache Limpo com Sucesso!!!"
					 echo
					 echo -e "Cache Limpo com Sucesso!!!" >> $LOG
					 echo
					 echo -e "Instalação dos principais software feita com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 echo ============================================================ >> $LOG
					 echo  >> $LOG
					
					 echo -e "Configurando o Serviço do NTP" >> $LOG
					 echo -e "Fazendo o Backup do arquivo ntp.conf" >> $LOG
					 #Fazendo o backup do arquivos de configuração do NTP Server
					 mv -v /etc/ntp.conf /etc/ntp.conf.old >> $LOG
					 echo -e "Backup do arquivo ntp.conf feito com sucesso!!!" >> $LOG
					 echo >> $LOG
					 echo -e "Criando o arquivo ntp.drift" >> $LOG
					 #Copiando o arquivo ntp.drift
					 cp -v conf/ntp.drift /etc/ntp.drift >> $LOG
					 #Adicionando o contéudo de 0.0 dentro do arquivo ntp.drift
					 echo 0.0 > /etc/ntp.drift
					 echo -e "Arquivo criado com sucesso!!!" >> $LOG
					 echo >> $LOG
					 echo -e "Atualizando o arquivo ntp.conf" >> $LOG
					 #Copiando o arquivo de configuração do NTP Server
					 cp -v conf/ntp.conf /etc/ntp.conf >> $LOG
					 echo -e "Arquivo atualizado com sucesso!!!" >> $LOG
					 echo >> $LOG
					 echo -e "Atualizando Data/Hora do Servidor" >> $LOG
					 #Para o serviço do NTP Server para fazer a sua configuração
					 sudo service ntp stop
					 echo -e "Editando o arquivo /etc/ntp.conf para acescentar as informações de Servidores NTP"
					 echo -e "Pressione <Enter> para editar o arquivo"
					 echo
					 read
					 #Editando o arquivo ntp.conf
					 vim /etc/ntp.conf
					 echo -e "Atualização do ntpdate" >> $LOG
					 #Atualizando data/hora do servidor NTP.br
					 #d=debug, q=query, u=unprivileged, v=verbose
					 ntpdate -dquv $NTP &>> $LOG
					 #Iniciando o serviço do NTP Server
					 sudo service ntp start
					 echo -e "Verificação dos servidores NTP" >> $LOG
					 #Verificando as informações de Servidores NTP e seu sincronismo
					 #p=print, n=all andress
					 ntpq -pn >> $LOG
					 echo -e "Hora do Hardware" >> $LOG
					 #Verificando data/hora de hardware (BIOS)
					 hwclock >> $LOG
					 echo -e "Hora da Máquina" >> $LOG
					 #Verificando data/hora de sistema operacional
					 date >> $LOG
					 echo -e "Atualização do NTP feito com sucesso!!!" >> $LOG
					 echo -e "NTP.CONF atualizado com sucesso, pressione <Enter> para continuar com o script"
					 read
					 sleep 2
					 clear
					 echo ============================================================ >> $LOG

					 echo -e "Atualizando o FSTAB" >> $LOG
					 echo -e "Editando o arquivo /etc/fstab para acrescentar as informações de ACL e XATTR"
					 echo -e "Informações de ACL e XATTR na Raiz e no diretório Var"
					 echo 
					 echo -e "Linhas a serem editadas no arquivo /etc/fstab" 
					 #Listando a linha 8
					 echo -e "`cat -n /etc/fstab | sed -n '8p'`"
					 echo
					 #Listando a linha 9
					 echo -e "`cat -n /etc/fstab | sed -n '9p'`"
					 echo
					 #Listando a linha 12
					 echo -e "`cat -n /etc/fstab | sed -n '12p'`"
					 echo
					 echo -e "Informações a serem acrescentadas depois de ext4: defaults,barrier=1"
					 echo -e "Se tiver utilizando o BTRFS, deixar o padrão"
					 echo -e "Pressione <Enter> para editar o arquivo"
					 echo 
					 read
					 #Fazendo o backup do arquivo fstab
					 cp -v /etc/fstab /etc/fstab.old >> $LOG
					 #Editando o arquivo fstab
					 vim /etc/fstab
					 echo -e "Atualização feita com sucesso!!!" >> $LOG
					 echo -e "FSTAB atualizado com sucesso, pressione <Enter> para continuar com o script"
					 read
					 sleep s
					 clear
					 echo ============================================================ >> $LOG

					 echo -e "Atualizando o KRB5.CONF" >> $LOG
					 echo -e "Editando o arquivo /etc/krb5.conf para acrescentar as informações SAMBA4"
					 echo -e "Linha a ser editada no arquivo /etc/krb5.conf" 
					 echo -e "`cat -n /etc/krb5.conf | head -n3`"
					 echo -e "Informações a serem acrescentadas depois de default_realm"
					 echo -e "Pressione <Enter> para editar o arquivo"
					 echo 
					 read
					 #Fazendo o backup do arquivo de confguração do Kerberos
					 mv -v /etc/krb5.conf /etc/krb5.conf.old >> $LOG
					 #Atualizando o arquivo de configuração do Kerberos
					 cp -v conf/krb5.conf /etc/krb5.conf >> $LOG
					 #Editando o arquivo de configuração do Kerberos
					 vim /etc/krb5.conf
					 echo -e "Atualização feita com sucesso!!!" >> $LOG
					 echo -e "KRB5.CONF atualizado com sucesso, pressione <Enter> para continuar com o script"
					 read
					 sleep 2
					 clear
					 echo ============================================================ >> $LOG

					 echo -e "Fim do Script-01.sh em: `date`" >> $LOG
					 echo
					 echo -e "Instalação das Dependências de Rede Feito com Sucesso!!!!!" 
					 echo
					 # Script para calcular o tempo gasto para a execução do script-01.sh
						DATAFINAL=`date +%s`
						SOMA=`expr $DATAFINAL - $DATAINICIAL`
						RESULTADO=`expr 10800 + $SOMA`
						TEMPO=`date -d @$RESULTADO +%H:%M:%S`
					 echo -e "Tempo gasto para execução do script-01.sh: $TEMPO"
					 echo -e "Pressione <Enter> para concluir o processo."
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
