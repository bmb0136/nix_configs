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
