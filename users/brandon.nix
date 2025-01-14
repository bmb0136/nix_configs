{ config, ... }: {
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
  sops.secrets.github_key = {
    sopsFile = ./secrets/brandon.yaml;
    path = "/home/brandon/.ssh/id_git";
    owner = config.users.users.brandon.name;
    group = config.users.users.brandon.group;
  };
  sops.secrets.github_pub_key = {
    sopsFile = ./secrets/brandon.yaml;
    path = "/home/brandon/.ssh/id_git.pub";
    owner = config.users.users.brandon.name;
    group = config.users.users.brandon.group;
  };
}
