{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stash.url = "github:caioasmuniz/stash";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };
  };

  outputs =
    { self, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        allowUnfree = true;
      };
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nixfmt-rfc-style
          nixd
        ];
      };
      nixosConfigurations = {
        inspiron = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./hosts/inspiron
            inputs.home-manager.nixosModules.home-manager
          ];
        };

        aspire = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./hosts/aspire
            inputs.home-manager.nixosModules.home-manager
          ];
        };
      };
    };
}
