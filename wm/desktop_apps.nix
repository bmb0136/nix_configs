{ ... }:
{
  home-manager.sharedModules = [
    {
      programs.firefox.enable = true;
      programs.alacritty.enable = true;
    }
  ];
}
