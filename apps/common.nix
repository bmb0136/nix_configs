{ pkgs, outputs, ... }: {
  environment.systemPackages = with pkgs;
    [ tmux neovim htop fastfetch git ]
    ++ [ outputs.packages.${pkgs.system}.nvfConfig.neovim ];
}
