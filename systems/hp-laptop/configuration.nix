{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "hp-laptop";
  time.timeZone = "America/Chicago";

  environment.systemPackages = with pkgs; [ brightnessctl ];

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  systemd.services.no-touchscreen-pls = {
    script = ''
      ${pkgs.xorg.xinput} disable "eGalax Inc. eGalaxTouch EXC3200-2505-09.00.00.00"
    '';
    wantedBy = [ "graphical-session.target" ];
  };

  security.pki.certificates = [
    (builtins.readFile ../../certs/auburn.cer)
    (builtins.readFile ../../certs/usertrust.pem)
  ];

  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  system.stateVersion = "24.05";

}
