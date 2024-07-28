{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "gaming-pc";
  time.timeZone = "America/New_York";

  hardware.pulseaudio.enable = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
  services.xserver.videoDrivers = [ "nvidia" ];

  environment.systemPackages = with pkgs; [
  ];

  system.stateVersion = "24.05";

}
