{ config, pkgs, ... }: {
  home = {
    packages = with pkgs; [
      zplug
      zsh
      neofetch
      fzf
      exa
      bat
      btop
      direnv
    ];
  };

  programs = {
    starship = {
      enable = true;
      settings = { };
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      enableVteIntegration = true;
      historySubstringSearch.enable = true;
      shellAliases = {
        update = "sudo nix flake update /etc/nixos;sudo nixos-rebuild switch --upgrade --flake /etc/nixos";
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
        neofetch
      '';
    };
  };
}

