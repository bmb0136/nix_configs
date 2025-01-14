{ ... }: {
  imports = [
    ./langs.nix
    ./files.nix
  ];

  config.vim = {
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = false;
    };

    binds = {
      whichkey.enable = true;
      cheatsheet.enable = true;
    };

    tabstop = 2;
    shiftwidth = 2;
  };
}
