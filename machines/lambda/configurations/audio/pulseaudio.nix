{ ... }:

{
	hardware.pulseaudio = {
		enable = true;
		support32Bit = true;
		tcp = {
			enable = true;
			anonymousClients.allowedIpRanges = ["127.0.0.1"];
		};
	};
}
