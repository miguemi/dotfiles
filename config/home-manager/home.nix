{ config, pkgs, ... }:

# Useful reference: `man home-configuartion.nix`

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "miguemi";
  home.homeDirectory = "/Users/miguemi";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.git
    pkgs.neovim
    pkgs.tmux
    pkgs.gh
    pkgs.fzf
    pkgs.fd
    pkgs.ripgrep
    pkgs.bat
    pkgs.eza
    pkgs.lazygit
    pkgs.gcc
    pkgs.openssh
    pkgs.keychain
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ];

  home.file = {
     ".config/lazygit".source = ../lazygit;
     ".config/git".source = ../git;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # shells
  programs.bash = {
    enable = true;
    shellAliases = {
      vi  = "nvim";
      vif = "fzf --preview 'bat {}' | xargs -r nvim";
      ls  = "eza -l --icons -s extension";
      cat = "bat";
      lg  = "lazygit";
      switch = "home-manager switch --flake ~/.dotfiles/config/home-manager/";
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    defaultKeymap = "emacs";
    shellAliases = {
      vi  = "nvim";
      vif = "fzf --preview 'bat {}' | xargs -r nvim";
      ls  = "eza -l --icons -s extension";
      cat = "bat";
      lg  = "lazygit";
      switch = "home-manager switch --flake ~/.dotfiles/config/home-manager/";
    };
  };

  # other programs
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.keychain = {
    enable = true;
    enableZshIntegration = true;
    keys = [
      "id_ed25519"
    ];
  };

  programs.starship = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.git = {
  enable = true;
    userName = "miguemi";
    userEmail = "manuelmiguel80@hotmail.com";
    extraConfig = {        # Sign all commits using ssh key
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBtM54FhKHEeypbMPp8S0PEQNzNWMDy82mJa1laSPbS+ manuelmiguel80@hotmail.com";
      };
};
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    forwardAgent = true;
    matchBlocks = {
      "alan" = {
        hostname = "pruebas.alanfzf.site";
        user = "ubuntu";
      };
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
}
