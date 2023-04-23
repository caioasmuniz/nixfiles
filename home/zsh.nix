{ config, lib, pkgs, ... }: {
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
      settings = {
        format = lib.concatStrings [
          "[](blue)"
          "$os"
          "$username"
          "[](bg:red fg:blue)"
          "$directory"
          "[](fg:red bg:yellow)"
          "$git_branch"
          "$git_status"
          "[](fg:yellow bg:purple)"
          "$c"
          "$elixir"
          "$golang"
          "$haskell"
          "$java"
          "$nodejs"
          "$rust"
          "[](fg:purple bg:blue)"
          "$nix_shell"
          "[](fg:blue bg:green)"
          "$time"
          "[ ](fg:green)\n"
          "$character"
        ];
        # Disable the blank line at the start of the prompt
        # add_newline = true;

        # You can also replace your username with a neat symbol like   or disable this
        # and use the os module below
        username = {
          show_always = true;
          style_user = "bg:blue";
          style_root = "bg:blue";
          format = "[$user ]($style)";
          disabled = false;
        };

        # An alternative to the username module which displays a symbol that
        # represents the current operating system
        os = {
          style = "bg:blue bold";
          disabled = false; # Disabled by default
          symbols.NixOS = " ";
        };
        nix_shell = {
          format = "[ $symbol$state( \($name\))]($style)";
          style = "bg:blue bold";
          disabled = false; # Disabled by default
          heuristic = true;
          symbol = " ";
        };
        git_branch = {
          symbol = "";
          style = "bg:yellow";
          format = "[ $symbol $branch ]($style)";
        };
        git_status = {
          style = "bg:yellow";
          format = "[$all_status$ahead_behind ]($style)";
        };
        directory = {
          style = "bg:red";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
          substitutions = {
            "Documents" = " ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
            "nixfiles" = " ";
          };
        };
        time = {
          disabled = false;
          time_format = "%R"; # Hour:Minute Format
          style = "bg:green";
          format = "[ ♥ $time ]($style)";
        };
      };
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
      plugins = [{
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.zsh";
      }];
      initExtra = ''
        ${pkgs.neofetch}/bin/neofetch
      '';
    };
  };
}

