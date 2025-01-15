{ config, ... }:
{
  users.users.brandon = {
    isNormalUser = true;
    home = "/home/brandon";
    description = "Brandon Buckley";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
  };
  home-manager.users.brandon =
    { ... }:
    {
      home.username = "brandon";
      home.homeDirectory = "/home/brandon";
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
      xsession.windowManager.i3.enable = true;
    };
  sops.secrets =
    let
      base = {
        sopsFile = ./secrets/brandon.yaml;
        owner = config.users.users.brandon.name;
        group = config.users.users.brandon.group;
      };
    in
    builtins.mapAttrs (_: x: x // base) {
      github_key.path = "/home/brandon/.ssh/id_git";
      github_pub_key.path = "/home/brandon/.ssh/id_git.pub";
    };
}
