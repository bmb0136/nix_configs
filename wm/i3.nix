{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = {
    services.xserver = {
      enable = true;
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };
    services.displayManager = {
      defaultSession = "none+i3";
    };
    services.picom.enable = true;
    home-manager.sharedModules = [
      {
        xsession.windowManager.i3 = {
          config =
            let
              modifier = "Mod4";
            in
            {
              inherit modifier;
              gaps.inner = 8;
              gaps.outer = 12;
              defaultWorkspace = "workspace number 1";
              keybindings = lib.mkOptionDefault {
                "${modifier}+Return" = "exec alacritty";
                "${modifier}+Shift+Return" = "exec alacritty -e tmux";
              };
            };
        };
      }
    ];
  };
}
