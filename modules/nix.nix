{ ... }: {
  nixpkgs = {
    config.allowUnfree = true;
    config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    };
  };

  nix.settings = {
    auto-optimise-store = true;
    keep-outputs = true;
    keep-derivations = true;
    experimental-features = [ "nix-command" "flakes" ];
  };
}
