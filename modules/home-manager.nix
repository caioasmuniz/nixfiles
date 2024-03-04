{ inputs, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.caio.imports = [
      inputs.hyprlock.homeManagerModules.default
      inputs.hypridle.homeManagerModules.default
      ../home
    ];
  };
}
