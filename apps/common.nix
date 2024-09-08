{ pkgs, ... }: {
  imports = [
    ./nvim.nix
  ];

  environment.systemPackages = with pkgs; [
    tmux
    neovim
    htop
    fastfetch
    git
  ];
}
