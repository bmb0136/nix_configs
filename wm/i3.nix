{ pkgs, lib }:
{
  system = {
    services.xserver = {
      enable = true;
      windowManager.i3.enable = true;
    };
    services.displayManager = {
      defaultSession = "none+i3";
    };
    services.picom.enable = true;
  };
  home = {
    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = let
        modifier = "Mod4";
      in {
        inherit modifier;
        gaps.inner = 8;
        gaps.outer = 12;
        defaultWorkspace = "workspace number 1";
        keybindings = lib.mkOptionDefault {
          "${modifier}+Return" = "exec alacritty";
        };
      };
    };
  };
}
