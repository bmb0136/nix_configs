let
  opacity = 0.75;
in {
  home = { lib, ... }: {
    programs.alacritty.settings.window.opacity = lib.mkForce opacity;
  };
  system = { pkgs, ... }: {
    stylix.enable = true;

    stylix.polarity = "dark";
    stylix.image = ./nixos.png;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    stylix.fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
      };
    };

    stylix.opacity.applications = opacity;

    programs.nixvim.plugins.transparent.enable = true;
    programs.nixvim.autoCmd = [
      {
        event = "VimEnter";
        command = "TransparentEnable";
      }
    ];
  };
}
