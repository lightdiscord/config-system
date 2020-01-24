{ stdenv, fetchurl }:

stdenv.mkDerivation {
	name = "rtl8125a-3-firmware";

	src = fetchurl {
		urls = [
			"https://github.com/pop-os/linux-firmware/raw/f667c005600bd4fe24a0a439b7a3f3eadcce753a/rtl_nic/rtl8125a-3.fw"
			"http://anduin.linuxfromscratch.org/sources/linux-firmware/rtl_nic/rtl8125a-3.fw"
		];

		sha256 = "168v89nkx6hrwdmmpl85ksdjmfz86psz1v99qxlmkzyfy2534v1z";
	};

	phases = ["installPhase"];

	installPhase = ''
		mkdir -p $out/lib/firmware/rtl_nic
		cp $src $out/lib/firmware/rtl_nic/rtl8125a-3.fw
	'';
}
