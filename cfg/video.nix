{ config, lib, pkgs, ... }:

let 
    videoDrivers = [
        "nvidia"
    ];

    xrandrHeads = [
        "DVI-I-0"
        { output = "HDMI-0"; primary = true; }
    ];

    nvidia = config.boot.kernelPackages.nvidia_x11;
in {
    services.xserver = {
        exportConfiguration = true;
        config = ''
            Section "Device"
                Identifier     "Device0"
                Driver         "nvidia"
                VendorName     "NVIDIA Corporation"
                BoardName      "GeForce GTX 770"
            EndSection
        '';

        screenSection = ''
            Option         "metamodes" "HDMI-0: nvidia-auto-select +1920+0, DVI-I-0: nvidia-auto-select +0+0"
        '';

        inherit videoDrivers xrandrHeads;
    };

    fonts.fonts = with pkgs; [
        emojione
        powerline-fonts
    ];

    environment.variables.DISPLAY = ":0.0";
}
