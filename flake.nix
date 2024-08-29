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
  };

  outputs = { ... } @ inputs: let 
    lib = inputs.nixpkgs.lib;
  in {
    nixosConfigurations = let
      specialArgs = {
        inherit inputs;
        outputs = inputs.self.outputs;
      };
      commonModules = [
        ./apps/nvim.nix
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
    };
  };
}
