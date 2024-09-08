{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "hp-laptop";
  time.timeZone = "America/Chicago";

  environment.systemPackages = with pkgs; [ brightnessctl ];

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
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
