{ lib, ... }:
{
  programs.starship = {
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
}
