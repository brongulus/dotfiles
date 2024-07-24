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
          # mpv
          stow
          tmux
        ];
        pathsToLink = [ "/share/man" "/share/doc" "/bin" "/lib" ];
        extraOutputsToInstall = [ "man" "doc" ];
      };

      # emacs-overlay
      services.emacs.package = pkgs.emacs-unstable;

      nixpkgs.overlays = [
        (import (builtins.fetchTarball {
          url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
        }))
      ];

      programs.emacs = {
        enable = true;
        package = pkgs.emacs-unstable;
        # extraPackages = epkgs: [ epkgs.vterm ];
      };
      
      programs.fish.enable = true;
      environment.shells = with pkgs; [ fish ];
      users.defaultUserShell = pkgs.fish;
    };
}
