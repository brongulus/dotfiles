{
  description = "Dotfiles configuration";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
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
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    # emacs-overlay.inputs.nixpkgs.follows = "nixpkgs"; # To use cachix dont follow
    nixgl.url = "github:nix-community/nixGL";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, emacs-overlay, nixgl, ... }@inputs:
    let
      system = builtins.currentSystem; # --impure
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ emacs-overlay.overlay nixgl.overlay ];
      };
      isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
      isLinux = pkgs.stdenv.hostPlatform.isLinux;
      username = if isDarwin then "admin" else "prashant";
      homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
      dotfilesPath = "${homeDirectory}/dotfiles";
      # Claude kitty nixgl wrapper
      wrappedKitty = if isLinux then
        pkgs.writeShellScriptBin "kitty" ''
          ${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL ${pkgs.kitty}/bin/kitty "$@"
        ''
      else
        pkgs.kitty;
    in {
      defaultPackage.${system} = pkgs.buildEnv {
        name = "packages-dev";
        paths = with pkgs; [
          # dev
          nixVersions.latest
          
          tectonic pandoc ghostscript
          imagemagick ffmpeg yt-dlp
          janet racket-minimal
          gdb go gopls rustup
          tree-sitter zig zls

          # misc
          git fish yazi wrappedKitty stow
          tmux direnv nix-direnv cachix
          syncthing emacs-git
          # mpv # nix is building and not downloading binary
          (if isLinux
           then (import nixgl {inherit pkgs; }).auto.nixGLDefault # --impure
           else rectangle)

          # utilities
          fzf fishPlugins.fzf-fish fishPlugins.z
          ripgrep bat fd delta
          tmuxPlugins.resurrect
          tmuxPlugins.tmux-fzf
          tmuxPlugins.tmux-thumbs

          # fonts
          (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "VictorMono" ]; })
          merriweather ia-writer-duospace ia-writer-quattro # iosevka-comfy.comfy
        ];

        # pathsToLink = [ "/share/man" "/share/doc" "/share/fonts" "/share/nix-direnv"
        #                 "/share/fish" "/share/tmux-plugins" "/share/applications"
        #                 "/bin" "/lib" "/Applications" ];
        # extraOutputsToInstall = [ "man" "doc" "fonts" "nix-direnv" "fish" "tmux-plugins" ];

        postBuild =  ''
          if [ "$(uname)" == "Darwin" ]; then
            ~/dotfiles/bin/bin/nix-mac-app
          fi 
        '';
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
      
      fonts.fontconfig.enable = true; # export FONTCONFIG in bash on linux

      programs.bash.enable = true;
      
      programs.fish = {
        enable = true;
        plugins = with pkgs.fishPlugins; [
          fzf-fish.src
          z.src
        ];
      };
      programs.fzf.enableFishIntegration = false;
      environment.shells = with pkgs; [ fish ];
      users.defaultUserShell = pkgs.fish;
    };
}
