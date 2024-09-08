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

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { ... }@inputs:
    let lib = inputs.nixpkgs.lib;
    in {
      formatter.x86_64-linux =
        inputs.nixpkgs.legacyPackages.x86_64-linux.nixfmt-classic;
      nixosConfigurations = let
        specialArgs = {
          inherit inputs;
          outputs = inputs.self.outputs;
        };
        commonModules = [
          ./apps/common.nix
          ./users/common.nix
          ./systems/common.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
          }
        ];
      in {
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
        wsl = lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs;
          modules = [
            ./apps/common.nix
            ./users/common.nix
            ./users/brandon.nix
            ./themes/catppuccin.nix
            inputs.nixos-wsl.nixosModules.default
            {
              system.stateVersion = "24.05";
              wsl.enable = true;
              wsl.defaultUser = "brandon";
            }
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = specialArgs;
            }
          ];
        };
      };
    };
}
