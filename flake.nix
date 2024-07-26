{
  description = "Dotfiles configuration";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    allowUnfree = true;
    # requires updating trusted-users in /etc/nix/nix.conf
    extra-substituters = [
      "https://nix-community.cachix.org/"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  
  # Specify the sources
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixgl.url = "github:nix-community/nixGL";
    # nixgl.inputs.nixpkgs.follows = "nixpkgs";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    # emacs-overlay.inputs.nixpkgs.follows = "nixpkgs"; # To use cachix dont follow
  };

  outputs = { self, nixpkgs, emacs-overlay, ... }@inputs:
    let
      system = "x86_64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ emacs-overlay.overlay ];
      };
      isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
      username = if isDarwin then "admin" else "prashant";
      homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
      dotfilesPath = "${homeDirectory}/dotfiles";
    in {
      defaultPackage.${system} = pkgs.buildEnv {
        name = "packages-dev";
        paths = with pkgs; [
          git
          fish
          lf
          kitty
          stow
          tmux
          direnv
          nix-direnv
          # mpv # nix is building and not downloading binary
          # emacs-unstable # Takes an hour to build
          # glibcLocales # not needed on darwin

          # utilities
          fzf
          fishPlugins.fzf-fish
          ripgrep
          bat
          fd
          delta
          tmuxPlugins.resurrect

          # dev
          tectonic
          pandoc
          janet
          racket-minimal
          gdb
          go
          gopls
          rustup
          zig
          zls

          # fonts
          victor-mono
          (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
        ];

        pathsToLink = [ "/share/man" "/share/doc" "/share/fonts" "/share/nix-direnv"
                        "/share/fish" "/share/tmux-plugins" "/bin" "/lib" ];
        extraOutputsToInstall = [ "man" "doc" "fonts" "nix-direnv" "fish" "tmux-plugins" ];
      };

      programs.direnv = {
        package = pkgs.direnv;
        silent = false;
        loadInNixShell = true;
        direnvrcExtra = "";
        nix-direnv = {
          enable = true;
          package = pkgs.nix-direnv;
        };
      };
      
      fonts.fontconfig.enable = true;
      
      programs.fish = {
        enable = true;
        plugins = with pkgs.fishPlugins; [
          fzf-fish.src
        ];
      };
      programs.fzf.enableFishIntegration = false;
      environment.shells = with pkgs; [ fish ];
      users.defaultUserShell = pkgs.fish;
    };
}
