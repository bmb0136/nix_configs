{
  description = "bmb0136's NixOS Configs V2";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.treefmt-nix.flakeModule
      ];
      systems = [ "x86_64-linux" ];
      perSystem =
        { pkgs, ... }:
        {
          treefmt = import ./treefmt.nix;

          packages.nvfConfig =
            (inputs.nvf.lib.neovimConfiguration {
              inherit pkgs;
              modules = [ ./apps/nvf ];
            }).neovim;
        };
      flake = {
        nixosConfigurations =
          let
            specialArgs = {
              inherit inputs;
              inherit (inputs.self) outputs;
            };
            commonModules = [
              inputs.sops-nix.nixosModules.sops
              ./apps/common.nix
              ./users/common.nix
              ./systems/common.nix
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = specialArgs;
                };
              }
            ];
            inherit (inputs.nixpkgs) lib;
          in
          {
            hp-laptop = lib.nixosSystem {
              system = "x86_64-linux";
              inherit specialArgs;
              modules = [
                ./systems/hp-laptop/configuration.nix
                ./users/brandon.nix
                ./themes/catppuccin.nix
                ./wm/i3.nix
              ] ++ commonModules;
            };
            manta = lib.nixosSystem {
              system = "x86_64-linux";
              inherit specialArgs;
              modules = [
                ./themes/catppuccin.nix
                ./users/jelly.nix
                ./systems/manta/configuration.nix
              ] ++ commonModules;
            };
            wsl = lib.nixosSystem {
              system = "x86_64-linux";
              inherit specialArgs;
              modules = [
                inputs.sops-nix.nixosModules.sops
                {
                  sops.age.sshKeyPaths = [ "/var/lib/sops-nix/ssh_host_ed25519_key" ];
                }
                { programs.ssh.startAgent = true; }
                ./apps/common.nix
                ./users/common.nix
                ./users/brandon.nix
                ./themes/catppuccin.nix
                inputs.nixos-wsl.nixosModules.default
                {
                  system.stateVersion = "24.05";
                  wsl.enable = true;
                  wsl.defaultUser = "brandon";
                  networking.hostName = "wsl";
                  nix.settings.experimental-features = [
                    "nix-command"
                    "flakes"
                  ];
                }
                inputs.home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    extraSpecialArgs = specialArgs;
                  };
                }
              ];
            };
          };
      };
    };
}
