{ ... }:
{
  home-manager.sharedModules = [
    {
      programs.tmux = {
        enable = true;
        baseIndex = 1;
        escapeTime = 0;
        extraConfig = ''
          set-option -sa terminal-overrides ",xterm*:Tc"
          set -g default-terminal "screen-256color"
        '';
      };

      services.ssh-agent.enable = true;

      home.sessionVariables = {
        EDITOR = "nvim";
        BROWSER = "firefox";
      };
    }
  ];
}
