{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pipewire-screenaudio.url = "github:IceDBorn/pipewire-screenaudio";
    nh.url = "github:viperML/nh";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprlock.url = "github:hyprwm/Hyprlock";
    hypridle.url = "github:hyprwm/Hypridle";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nix-gaming.url = "github:fufexan/nix-gaming";
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

  outputs = inputs:
    let
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
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/inspiron
            inputs.home-manager.nixosModules.home-manager
            inputs.nh.nixosModules.default
          ];
        };

        aspire = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/aspire
            inputs.home-manager.nixosModules.home-manager
            inputs.nh.nixosModules.default
          ];
        };
      };
    };
}
