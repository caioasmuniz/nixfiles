{
  config,
  lib,
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      ripgrep
      procs
    ];
    sessionVariables = {
      EDITOR = "micro";
      SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
    };
    file.".profile".text = ''
      . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
    '';
  };
  programs = {
    eza = {
      enable = true;
      icons = "auto";
      git = true;
      extraOptions = [
        "--color=always"
        "--group-directories-first"
        "--header"
      ];
    };
    bat = {
      enable = true;
      config = {
        theme = "base16";
      };
      extraPackages = with pkgs.bat-extras; [
        prettybat
        batman
      ];
    };
    btop = {
      enable = true;
      settings = {
        proc_gradient = false;
        theme_background = false;
        color_theme = "TTY";
        truecolor = true;
        update_ms = 1000;
      };
    };
    micro = {
      enable = true;
      settings = {
        autosu = true;
        clipboard = "external";
        mkparents = true;
        saveundo = true;
        colorscheme = "simple";
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    starship = {
      enable = true;
      enableTransience = true;
      settings = {
        format = lib.concatStrings [
          "[](blue)"
          "$os"
          "$username"
          "$hostname"
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
          "$cmd_duration"
          "[ ](fg:green)\n"
          "$character"
        ];
        # Disable the blank line at the start of the prompt
        # add_newline = true;

        # You can also replace your username with a neat symbol like   or disable this
        # and use the os module below
        username = {
          show_always = true;
          style_user = "fg:white bg:blue";
          style_root = "fg:white bg:black";
          format = "[$user ]($style)";
          disabled = false;
        };

        hostname = {
          ssh_only = true;
          ssh_symbol = "󰢹 ";
          format = "[on $hostname $ssh_symbol]($style)";
          style = "fg:white bg:blue";
          trim_at = ".";
          disabled = false;
        };

        # An alternative to the username module which displays a symbol that
        # represents the current operating system
        os = {
          style = "fg:white bg:blue bold";
          disabled = false; # Disabled by default
          symbols.NixOS = " ";
        };
        nix_shell = {
          format = "[ $symbol $state( \($name\))]($style)";
          style = "fg:white bg:blue bold";
          disabled = false; # Disabled by default
          heuristic = true;
          symbol = "";
        };
        git_branch = {
          symbol = "";
          style = "fg:black bg:yellow";
          format = "[ $symbol $branch ]($style)";
        };
        git_status = {
          style = "fg:black bg:yellow";
          format = "[$all_status$ahead_behind ]($style)";
        };
        directory = {
          style = "fg:white bg:red";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
          substitutions = {
            "Documents" = " ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
            "nixfiles" = " files";
          };
        };

        rust = {
          symbol = "󱘗";
          style = "fg:white bg:purple";
          format = "[ $symbol ($version)]($style)";
        };

        nodejs = {
          symbol = "󰎙";
          style = "fg:white bg:purple";
          format = "[ $symbol ($version)]($style)";
        };

        c = {
          symbol = "󰙱";
          style = "fg:white bg:purple";
          format = "[ $symbol ($version)]($style)";
        };

        java = {
          symbol = "󰬷";
          style = "fg:white bg:purple";
          format = "[ $symbol ($version)]($style)";
        };

        python = {
          symbol = "󰌠";
          style = "fg:white bg:purple";
          format = "[ $symbol ($version)]($style)";
        };

        cmd_duration = {
          disabled = false;
          style = "fg:black bg:green";
          format = "[ 󱫌 took $duration]($style)";
          show_notifications = true;
          min_time_to_notify = 30000;
        };
      };
    };
    fzf.enable = true;
    fd.enable = true;
    broot.enable = true;
    fish = {
      enable = true;
      plugins = [
        {
          name = "fzf";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
        {
          name = "fifc";
          src = pkgs.fishPlugins.fifc.src;
        }
      ];
      interactiveShellInit = ''
        set fish_greeting 
        ${lib.getExe pkgs.fastfetch}'';
      shellAliases = {
        update = "nh os switch ~/Documents/nixfiles";
        update-flake = "nh os switch --update ~/Documents/nixfiles";
        update-remote = "nh os switch github:caioasmuniz/nixfiles";
        ls = "eza";
        cat = "bat";
      };
    };
  };
}
