{
  description = "Dotfiles configuration";
  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [
      "https://nix-community.cachix.org/"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    darwin.url = "github:LnL7/nix-darwin";
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:Homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:Homebrew/homebrew-cask";
      flake = false;
    };
  };
  
  outputs = { self, nixpkgs, darwin, nix-homebrew, homebrew-core, homebrew-cask, emacs-overlay, nixgl, rust-overlay, ... }@inputs:
    let
      system = builtins.currentSystem;
      user = builtins.getEnv "USER";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.input-fonts.acceptLicense = true;
        overlays = [ emacs-overlay.overlay nixgl.overlay rust-overlay.overlays.default ];
      };
      isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
      isLinux = pkgs.stdenv.hostPlatform.isLinux;
      hostname = builtins.getEnv "HOSTNAME";
      
      # Kitty on linux requires nixGL
      wrappedKitty = pkgs.writeShellScriptBin "kitty" ''
        ${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL ${pkgs.kitty}/bin/kitty "$@"
      '';

      # Common packages for all platforms
      commonPackages = with pkgs; [
        # Development tools
        nixVersions.latest
        tectonic pandoc ghostscript
        imagemagick ffmpeg yt-dlp
        rust-bin.nightly.latest.minimal
        rust-analyzer clippy rustfmt
        go_1_24 gopls basedpyright ruff
        uv janet bacon shellcheck
        tree-sitter zig zls lua-language-server

        # Ref: https://mplanchard.com/posts/installing-a-specific-version-of-a-package-with-nix.html
        ruby rubyPackages.pry colorls ruby-lsp # <- LSP not working
        rubyPackages.reline rubyPackages.prism # <- FIXME lsp needs 0.22-0.24
        
        # Core utilities
        wezterm git fish yazi gh stow
        zellij direnv nix-direnv cachix
        
        # CLI tools
        fzf fishPlugins.fzf-fish fishPlugins.z
        ripgrep bat fd delta yq jq tmux
        tmuxPlugins.resurrect
        tmuxPlugins.tmux-fzf
        tmuxPlugins.tmux-thumbs
      ];

      # Linux-specific packages
      linuxPackages = with pkgs; [
        pkgs.nixgl.auto.nixGLDefault
        emacs-git
        racket-minimal
        wrappedKitty
        syncthing
        git-graph
        gdb mpv
        # Fonts
        nerd-fonts.symbols-only
        nerd-fonts.victor-mono
        merriweather input-fonts fira-sans victor-mono
        maple-mono-SC-NF
        # ia-writer-duospace ia-writer-quattro iosevka-comfy.comfy
      ];

      # Darwin-specific packages
      darwinPackages = with pkgs; [
        # moved to brew
      ];
      
      # Create platform-specific outputs
      platformOutputs = if isDarwin then {
        darwinConfigurations.${hostname} = darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ({ config, ... }: {
              homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
            })
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix.settings.trusted-users = [ "${user}" ]; # FIXME
              nix-homebrew = {
                user = "${user}";
                enable = true;
                enableRosetta = true;
                autoMigrate = true;
                mutableTaps = true;
              };

              fonts.packages = [
                pkgs.nerd-fonts.symbols-only
                pkgs.nerd-fonts.victor-mono
                pkgs.victor-mono
                pkgs.merriweather
                pkgs.input-fonts
                pkgs.fira-sans
                pkgs.maple-mono-SC-NF
                pkgs.national-park-typeface
              ];
              
              homebrew = {
                enable = true;
                onActivation = {
                  autoUpdate = true;
                  upgrade = true;
                  cleanup = "zap";
                };
                
                taps = [
                  "derailed/k9s"
                  "gardener/tap"
                  "gitguardian/tap"
                  "int128/kubelogin"
                  "nikitabobko/tap" # aerospace
                ];

                brews = [
                  # deps
                  "coreutils" "gnu-sed" "gnu-tar" "grep" "gzip" "parallel" "iproute2mac"
                  # workPackages
                  "kubernetes-cli" "kubebuilder" "kubectx" "kind" "helm"
                  "lazydocker" "k9s" "kubecolor"
                  "gardenlogin" "gardenctl-v2" "ggshield" "kubelogin"
                  "yaml-language-server" "helm-ls"
                  # personal
                  "minimal-racket" "mpv"
                  # pdf-tools
                  "pkg-config" "poppler" "autoconf" "automake"
                ];
                
                casks = [
                  {
                    name = "emacs@pretest";
                    greedy = true;
                  }
                  "kitty"
                  "syncthing"
                  "rectangle"
                  "aerospace"
                  "jordanbaird-ice"
                  "ubersicht"
                  "docker"
                ];
              };
              
              programs.fish.enable = true;
              programs.zsh.enable = true;
              programs.tmux.enable = true;
              
              environment = {
                shells = [ pkgs.fish ];
                systemPackages = commonPackages ++ darwinPackages;
              };

              # NOTE tmux woes: https://github.com/LnL7/nix-darwin/pull/1344
              security.pam.enableSudoTouchIdAuth = true;
              system = {
                keyboard = {
                  enableKeyMapping = true;
                  remapCapsLockToControl = true;
                };
                defaults = {
                  dock = {
                    tilesize = 50;
                    autohide = false;
                    orientation = "bottom";
                    show-recents = false;
                  };
                  finder = {
                    AppleShowAllExtensions = true;
                    AppleShowAllFiles = true;
                    ShowPathbar = true;
                    FXEnableExtensionChangeWarning = false;
                    _FXSortFoldersFirst = true;
                    # New window use the $HOME path
                    NewWindowTarget = "Home";
                  };
                  trackpad = {
                    Clicking = true;
                    TrackpadThreeFingerDrag = false;
                  };
                  LaunchServices = {
                    # Disable quarantine for downloaded apps
                    LSQuarantine = false;
                  };
                  NSGlobalDomain = {
                    AppleShowAllExtensions = true;
                    InitialKeyRepeat = 15;
                    KeyRepeat = 1;
                  };
                  CustomSystemPreferences = {
                    "com.apple.AdLib" = {
                      # Disable personalized advertising
                      forceLimitAdTracking = true;
                      allowApplePersonalizedAdvertising = false;
                      allowIdentifierForAdvertising = false;
                    };
                  };
                };
                ## run darwin-rebuild changelog to check this
                stateVersion = 5;
              };
              system.activationScripts.setting.text = ''
                  # Allow opening apps from any source
                  sudo spctl --master-disable
              '';
            }
          ];
        };
        
        defaultPackage.${system} = pkgs.buildEnv {
          name = "packages-darwin";
          paths = commonPackages ++ darwinPackages;
        };
      } else {
        defaultPackage.${system} = pkgs.buildEnv {
          name = "packages-linux";
          paths = commonPackages ++ linuxPackages;
        };
      };
      
    in platformOutputs // {
      # Shared configuration that's platform-independent
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
