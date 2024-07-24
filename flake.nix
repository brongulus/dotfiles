{
  description = "Dotfiles configuration";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    allowUnfree = true;
  };
  
  # Specify the sources
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, emacs-overlay, ... }@inputs:
    let
      system = "x86_64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
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
          # mpv # nix is building and not downloading binary
          stow
          tmux

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
          rustup # rust and rust-analyzer
          zig
          zls

          # fonts
          victor-mono
        ];

        pathsToLink = [ "/share/man" "/share/doc" "/share/fonts" "/bin" "/lib" ];
        extraOutputsToInstall = [ "man" "doc" "fonts" ];
      };

      # emacs-overlay
      services.emacs.package = pkgs.emacs-unstable;

      nixpkgs.overlays = [ (import self.inputs.emacs-overlay) ];

      programs.emacs = {
        install = true;
        enable = true;
        package = with pkgs; (emacsWithPackagesFromUsePackage
          pkgs.emacs-unstable
        );
        # extraPackages = epkgs: [ epkgs.vterm ];
      };

      # fonts.fontconfig.enable = true;
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
