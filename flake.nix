{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nh.url = "github:viperML/nh";
    hyprland.url = "github:hyprwm/Hyprland";
    waybar.url = "github:Alexays/Waybar";
  };

  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs { inherit system; allowUnfree = true; };
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nixpkgs-fmt
          nil
        ];
      };
      nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./modules
          inputs.home-manager.nixosModules.home-manager
          inputs.nh.nixosModules.default
          {
            programs.hyprland.enable = true;
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs.inputs = inputs;
              users.caio.imports = [
                ./home
              ];
            };
          }
        ];
      };
    };
}
