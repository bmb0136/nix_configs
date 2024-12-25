{ ... }: {
  users.users.jelly = {
    isNormalUser = true;
    home = "/home/jelly";
    description = "Jelly Admin";
    extraGroups = [ "wheel" "networkmanager" ];
  };
  home-manager.users.jelly = { ... }: {
    home.username = "jelly";
    home.homeDirectory = "/home/jelly";
    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
  };
}
