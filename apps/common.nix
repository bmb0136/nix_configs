{ pkgs, ... }: {
  imports = [ ./nvf ];

  environment.systemPackages = with pkgs; [ tmux neovim htop fastfetch git ];
}
