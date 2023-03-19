{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, hyprland, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs.inputs = inputs;
      modules = [
        ./modules
        hyprland.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          programs.hyprland.enable = true;
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs.inputs = inputs;
            users.caio.imports = [
              hyprland.homeManagerModules.default
              ./home
            ];
          };
        }
        # ...
      ];
    };
  };
}
