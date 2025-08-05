{ pkgs, lib, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      continue.continue
      jnoortheen.nix-ide
      mkhl.direnv
      pkief.material-icon-theme
      piousdeer.adwaita-theme
      ms-vscode-remote.remote-ssh
      arrterian.nix-env-selector
      ms-vsliveshare.vsliveshare
      redhat.ansible
      redhat.vscode-yaml
      ms-python.python
      ms-azuretools.vscode-docker
      alefragnani.project-manager
      bradlc.vscode-tailwindcss
    ];
  };
  wayland.windowManager.hyprland.settings.bind = [
    "SUPER,C,exec, ${lib.getExe pkgs.vscode} ~/Documents/nixfiles/nixfiles.code-workspace"
  ];
}
