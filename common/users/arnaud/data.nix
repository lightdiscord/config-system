{
	name = "arnaud";
	nickname = "LightDiscord";
	email = "root@arnaud.sh";
	website = https://arnaud.sh;

	keys = {
		gpg = builtins.readFile ./keys/gpg.key;
		ssh = builtins.readFile ./keys/ssh.pub;
	};
}
