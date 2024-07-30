{
  description = "bmb0136's NixOS configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.home-manager.follows = "home-manager";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, stylix, nixvim, ... }: let
    inherit (nixpkgs) lib;
    mkSys = { system, users, base, wm, theme } @ inputs: let
      pkgs = nixpkgs.legacyPackages.${system};
      wm = inputs.wm { inherit pkgs lib; };
    in nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit wm; };
      modules = [
        base
        ./systems/common.nix
        stylix.nixosModules.stylix
        nixvim.nixosModules.nixvim
        ((import ./themes/${theme}.nix).system (inputs // { inherit pkgs; }))
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users = let
            combine = a: b: a // b;
            mkUser = name: {
              ${name} = inputs: lib.mkMerge [
                (import ./users/common.nix { inherit wm lib pkgs; })
                ((import ./themes/${theme}.nix).home inputs)
                ((import ./users/${name}.nix).home (inputs // { inherit pkgs; }))
              ];
            };
          in builtins.foldl' combine {} (map mkUser users);
        }
      ] ++ (map (name: (import ./users/${name}.nix).system) users);
    };
  in {
    nixosConfigurations = {
      gaming-pc = mkSys {
        system = "x86_64-linux";
        base = ./systems/gaming-pc/configuration.nix;
        users = [ "brandon" ];
        wm = import ./wm/i3.nix;
        theme = "catppuccin";
      };
      hp-laptop = mkSys {
        system = "x86_64-linux";
	base = ./systems/hp-laptop/configuration.nix;
	users = [ "brandon" ];
	wm = import ./wm/i3.nix;
	theme = "catppuccin";
      };
    };
  };
}
