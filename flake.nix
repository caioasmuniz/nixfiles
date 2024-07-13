{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pipewire-screenaudio.url = "github:IceDBorn/pipewire-screenaudio";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    nix-gaming.url = "github:fufexan/nix-gaming";
    ags.url = "github:Aylur/ags";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };
    swayosd = {
      url = "github:ErikReider/SwayOSD";
      flake = false;
    };
    swaync = {
      url = "github:ErikReider/SwayNotificationCenter";
      flake = false;
    };
  };

  outputs = { self, ... }@inputs:
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
        buildInputs = with pkgs; [ nixpkgs-fmt nil ];
      };
      nixosConfigurations = {
        inspiron = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/inspiron
            inputs.home-manager.nixosModules.home-manager
          ];
        };

        aspire = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/aspire
            inputs.home-manager.nixosModules.home-manager
          ];
        };
      };
    };
}
