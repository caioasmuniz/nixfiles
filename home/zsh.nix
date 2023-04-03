{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    btop
    micro
    git
  ];

  programs = {
    exa.enable = true;
    bat.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    starship = {
      enable = true;
      settings = { };
    };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      enableVteIntegration = true;
      historySubstringSearch.enable = true;
      shellAliases = {
        update = "sudo nixos-rebuild switch --upgrade --flake github:caioasmuniz/nixfiles";
        update-local = "sudo nixos-rebuild switch --upgrade --flake ~/Documents/nixfiles";
        update-flake = "sudo nix flake update ~/Documents/nixfiles;";
        ls = "exa --color=always --icons";
        cat = "bat";
      };
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      zplug = {
        enable = true;
        plugins = [
          { name = "Aloxaf/fzf-tab"; }
        ];
      };
      initExtra = ''
        ${pkgs.neofetch}/bin/neofetch
      '';
    };
  };
}

