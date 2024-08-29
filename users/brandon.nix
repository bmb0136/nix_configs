{ ... }: {
  users.users.brandon = {
    isNormalUser = true;
    home = "/home/brandon";
    description = "Brandon Buckley";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
  };
  home-manager.users.brandon = { ... }: {
    home.username = "brandon";
    home.homeDirectory = "/home/brandon";
    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
    xsession.windowManager.i3.enable = true;
  };
}
