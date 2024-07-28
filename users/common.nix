{ wm, pkgs, lib, ... }:
{
  programs.home-manager.enable = true;

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
    TERMINAL = "alacritty";
  };

  programs.firefox.enable = true;
  programs.alacritty.enable = true;
} // wm.home
