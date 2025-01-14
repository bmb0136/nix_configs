{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [ tmux neovim htop fastfetch git ] ++ [ inputs.self.outputs.packages.${pkgs.system}.nvfConfig.neovim ];
}
