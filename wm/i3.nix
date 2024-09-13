{ pkgs, lib, ... }: {
  config = {
    services.xserver = {
      enable = true;
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };
    services.displayManager = { defaultSession = "none+i3"; };
    services.picom.enable = true;
    home-manager.sharedModules = [
      (let
        locker = "${pkgs.i3lock-fancy}/bin/i3lock";
      in {
        services.screen-locker = {
          enable = true;
          lockCmd = locker;
        };
        xsession.windowManager.i3 = {
          config = let modifier = "Mod4";
          in {
            inherit modifier;
            gaps.inner = 8;
            gaps.outer = 12;
            defaultWorkspace = "workspace number 1";
            keybindings = lib.mkOptionDefault {
              "${modifier}+Return" = "exec alacritty";
              "${modifier}+Shift+Return" = "exec alacritty -e tmux";
              "${modifier}+L" = "exec ${locker}";
            };
          };
        };
      })];
  };
}
