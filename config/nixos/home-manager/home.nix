{
  homeUser,
  config,
  lib,
  pkgs,
  ...
}:
{

  home.username = homeUser;
  home.homeDirectory = (
    if pkgs.stdenv.hostPlatform.isLinux then
      "/home/${config.home.username}"
    else
      "/Users/${config.home.username}"
  );

  home.stateVersion = "24.11";

  # Handle app symlinks
  # targets.genericLinux.enable = true;
  # xdg.mime.enable = true;
  # xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.shellAliases = {
    vi = "nvim";
    vif = "fzf --preview 'bat {}' | xargs -r nvim";
    ls = "eza -l --icons -s extension";
    cat = "bat";
    lg = "lazygit";
  };

  home.packages = with pkgs; [
    awscli2
    bat
    eza
    fd
    fzf
    gcc
    gh
    git
    jq
    lazygit
    lua-language-server
    marksman
    neovim
    stylua
    tmux
    unzip
    lf
    nixfmt-rfc-style
    nerd-fonts.jetbrains-mono
  ];

  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/nvim"
    );
    ".config/tmux".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/tmux"
    );
    ".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/starship.toml"
    );
    ".config/lazygit".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/lazygit"
    );
    ".config/alacritty".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/alacritty"
    );
  };

  programs = {
    home-manager = {
      enable = true;
    };

    bash = {
      enable = true;
      enableCompletion = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      defaultKeymap = "emacs";
    };

    readline = {
      enable = true;
      variables = {
        expand-tilde = true;
        completion-ignore-case = true;
        show-all-if-ambiguous = true;
      };
    };

    zoxide = {
      enable = true;
    };

    starship = {
      enable = true;
    };

    direnv = {
      enable = true;
      silent = true;
    };

    git = {
      enable = true;
      userName = "miguemi";
      userEmail = "manuelmiguel80@hotmail.com";
      extraConfig = {
        # Sign all commits using ssh key
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBtM54FhKHEeypbMPp8S0PEQNzNWMDy82mJa1laSPbS+ manuelmiguel80@hotmail.com";
      };
      aliases = {
        "subup" = "submodule update --init --recursive";
        "co" = "checkout";
        "cob" = "checkout -b";
        "br" = "branch";
        "st" = "status";
        "cm" = "commit -m";
        "amend" = "commit --amend -m";
        "po" = "push origin";
        "cp" = "cherry-pick";
        "gone" = "! git fetch -p && git for-each-ref --format '%(refname:short) %(upstream:track)' | awk '$2 == \"[gone]\" {print $1}' | xargs -r git branch -D";
        "rmcache" = "rm -rf --cached .";
    
      };
    
    };

    ripgrep = {
      enable = true;
      arguments = [
        "--hidden"
        "--follow"
        "--glob=!{.git,node_modules,vendor}"
        "--glob=!*.{lock}"
        "--glob=!{package-lock.json}"
        "--max-columns=10000"
        "--smart-case"
        "--sort=path"
      ];
    };

    keychain = {
      enable = true;
      keys = [
        "id_ed25519"
      ];
    };

    ssh = {
      enable = true;
      addKeysToAgent = "yes";
      forwardAgent = true;
      serverAliveInterval = 240;
      matchBlocks = {
        "ftp" = {
          hostname = "ftp.finanssoreal.com";
          user = "ubuntu";
          identityFile = "~/.ssh/ed25519_finanssoreal";
        };
        "testing" = {
          hostname = "testing.finanssoreal.com";
          user = "debian";
          identityFile = "~/.ssh/ed25519_finanssoreal";
        };
        "prod" = {
          hostname = "control.finanssoreal.com";
          user = "debian";
          identityFile = "~/.ssh/ed25519_finanssoreal";
        };
      };
    };
  };
}
