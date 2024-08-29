{ config, ... }:
{
  home-manager.sharedModules = [{
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      escapeTime = 0;
      extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      '';
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
    };

    programs.firefox.enable = true;
    programs.alacritty.enable = true;
  }];
}
