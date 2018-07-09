#!/bin/bash

check_exit_status() {

	if [ $? -eq 0 ]
	then
		echo
		echo "Success"
		echo
	else
		echo
		echo "[ERROR] Process Failed!"
		echo
	fi
}


install_ssh() {

	sudo apt-get install openssh-server -y;
	check_exit_status

	sudo systemctl restart ssh;
	check_exit_status

	sudo systemctl enable ssh;
	check_exit_status
}


replace_default_keys() {

	sudo mkdir /etc/ssh/default_keys;
	check_exit_status

	sudo mv /etc/ssh/ssh_host_* /etc/ssh/default_keys;
	check_exit_status

	sudo dpkg-reconfigure openssh-server;
	check_exit_status

	sudo systemctl restart ssh;
	check_exit_status
}


leave() {

	echo
	echo "---------------------"
	echo "- Process Complete! -"
	echo "---------------------"
	echo
	exit
}

install_ssh
replace_default_keys
leave
