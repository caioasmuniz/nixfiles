{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    profiles.test.extensions = with pkgs.vscode-extensions; [
      continue.continue
      jnoortheen.nix-ide
      mkhl.direnv
      pkief.material-icon-theme
      piousdeer.adwaita-theme
      ms-vscode-remote.remote-ssh
      arrterian.nix-env-selector
    ];
  };
}
