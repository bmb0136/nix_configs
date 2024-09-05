{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [ inputs.stylix.nixosModules.stylix ];
  config =
    let
      opacity = 0.75;
    in
    {
      stylix = {
        enable = true;
        image = ./nixos.png;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        fonts = {
          monospace = {
            package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
            name = "JetBrainsMono Nerd Font";
          };
        };
        opacity.applications = opacity;
      };
      programs.nixvim = {
        plugins.transparent.enable = true;
        autoCmd = [
          {
            event = "VimEnter";
            command = "TransparentEnable";
          }
        ];
      };
      home-manager.sharedModules = [
        {
          programs.alacritty.settings.window.opacity = lib.mkForce opacity;
          programs.alacritty.settings.font.size = lib.mkForce 8;
        }
      ];
    };
}
