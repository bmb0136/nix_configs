{ ... }: {
  imports = [
    ./langs.nix
    ./files.nix
  ];

  programs.nvf = {
    enable = true;
  };

  config.vim = {
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = false;
    };

    tabstop = 2;
    shiftwidth = 2;
  };
}
