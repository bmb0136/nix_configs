{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];
  config = let
    opacity = 0.75;
  in {
    stylix = {
      enable = true;
      image = ./keep_coding.png;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      fonts = {
        monospace = {
          # package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
      };
      opacity.applications = opacity;
    };
    home-manager.sharedModules = [
      {
        programs.alacritty.settings.window.opacity = lib.mkForce opacity;
        programs.alacritty.settings.font.size = lib.mkForce 8;
      }
    ];
  };
}
