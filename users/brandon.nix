{
  system = {
    users.users.brandon = {
      isNormalUser = true;
      home = "/home/brandon";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
    };
    virtualisation.docker.enable = true;
  };
  home = { config, pkgs, lib, ... }:
  {
    home.username = "brandon";
    home.homeDirectory = "/home/brandon";
    home.stateVersion = "24.05";
    home.packages = with pkgs; [
    ];
  };
}
