[
	# External
  (builtins.fetchTarball https://github.com/LightDiscord/ProtonVPN-Nix/archive/master.tar.gz)

	# Config
	./config/networking.nix

	# Hardware

	## Video
	./hardware/video/lightdm.nix
	./hardware/video/nvidia.nix

	# Programs
	./programs/gnome-keyring.nix

	# Security
	./security/yubikey.nix
]
