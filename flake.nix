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
    copyparty = {
      url = "github:9001/copyparty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    doxx = {
      url = "github:bgreenwell/doxx";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # rust-overlay = {
    #   url = "github:oxalica/rust-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # zig = {
    #   url = "github:mitchellh/zig-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
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

  outputs = { self, nixpkgs, darwin, nix-homebrew, homebrew-core, homebrew-cask,
  copyparty, doxx, emacs-overlay, nixgl, ... }@inputs: # rust-overlay, zig
    let
      system = builtins.currentSystem;
      hostname = builtins.getEnv "HOSTNAME";
      user = builtins.getEnv "USER";
      sudo_user = builtins.getEnv "SUDO_USER";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.input-fonts.acceptLicense = true;
        overlays = [ copyparty.overlays.default emacs-overlay.overlay nixgl.overlay ]; # rust-overlay.overlays.default zig.overlays.default
      };
      isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
      isLinux = pkgs.stdenv.hostPlatform.isLinux;

      # Kitty on linux requires nixGL
      wrappedKitty = pkgs.writeShellScriptBin "kitty" ''
        ${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL ${pkgs.kitty}/bin/kitty "$@"
      '';

      fzf-fish = pkgs.fishPlugins.fzf-fish.overrideAttrs {
        nativeCheckInputs = [];
        checkPlugins = [];
        checkPhase = "";
      };

      # Common packages for all platforms
      commonPackages = with pkgs; [
        # Development tools
        nixVersions.latest gawk
        tectonic pandoc ghostscript
        imagemagick ffmpeg yt-dlp
        rustc rust-analyzer clippy rustfmt
        go-tools gopls reftools golangci-lint
        python314 basedpyright ruff
        uv janet bacon hyperfine shellcheck
        sqlite gobang litecli elinks
        zig zls gnuplot graphviz # zigpkgs.master
        tree-sitter lua-language-server
        ocaml dune_3 opam
        ocamlPackages.utop ocamlPackages.ocaml-lsp
        # copilot-language-server

        # Ref: https://mplanchard.com/posts/installing-a-specific-version-of-a-package-with-nix.html
        ruby rubyPackages.pry colorls ruby-lsp
        rubyPackages.reline rubyPackages.prism

        # Core utilities
        wezterm git fish zoxide yazi gh stow
        zellij direnv nix-direnv cachix helix

        # CLI tools
        fzf fishPlugins.fishtape_3 fzf-fish
        fishPlugins.z
        ripgrep bat fd delta difftastic ansifilter
        yq-go jq fx miller tmux
        tmuxPlugins.resurrect tmuxPlugins.tmux-fzf
        tmuxPlugins.tmux-thumbs

        # Misc
        # modlist: modmenu, simplefog, betterclouds
        # iris, simplynoshading, fabulouslyoptimized
        copyparty mg durden cat9 anki-bin prismlauncher
        doxx.packages.${system}.default tickrs ollama viddy
      ];

      # Linux-specific packages
      linuxPackages = with pkgs; [
        pkgs.nixgl.auto.nixGLDefault
        emacs-git
        racket-minimal
        wrappedKitty
        syncthing
        git-graph
        go gdb mpv
        # Fonts
        nerd-fonts.symbols-only
        nerd-fonts.victor-mono
        merriweather input-fonts fira-sans victor-mono
        maple-mono.NF-CN
        # ia-writer-duospace ia-writer-quattro iosevka-comfy.comfy
      ];

      # Darwin-specific packages
      darwinPackages = with pkgs; [
        # gcc
        gdlv yabai jankyborders
      ];

      # create platform-specific outputs
      platformOutputs = if isDarwin then {
        darwinConfigurations.${hostname} = darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ({ config, ... }: {
              homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
            })
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix.settings.trusted-users = [ user ]; # FIXME
              nix-homebrew = {
                user = user;
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
                pkgs.maple-mono.NF-CN
                pkgs.national-park-typeface
              ];

              homebrew = {
                user = sudo_user;
                enable = true;
                onActivation = {
                  autoUpdate = true;
                  upgrade = true;
                  cleanup = "uninstall";
                };

                taps = [
                  "derailed/k9s"
                  "gardener/tap"
                  "gitguardian/tap"
                  "int128/kubelogin"
                  "nikitabobko/tap" # aerospace
                  "damascenorafael/tap" # reminders-menubar
                  "smudge/smudge" # nightlight
                  "socsieng/tap" # sendkeys
                ];

                brews = [
                  # deps
                  "coreutils" "gnu-sed" "gnu-tar" "grep" "gzip" "parallel" "iproute2mac"
                  # workPackages
                  "kubernetes-cli" "kubebuilder" "kubectx" "kind" "helm"
                  "lazydocker" "k9s" "kubecolor" "krew" "stern" "delve"
                  "gardenlogin" "gardenctl-v2" "ggshield" "kubelogin"
                  "yaml-language-server" "helm-ls" "prometheus" "kwok"
                  "openstackclient" "awscli" "azure-cli" "aliyun-cli"
                  # personal
                  "minimal-racket" "mpv" "gnu-time" "gcc"
                  "nightlight" "cliclick" "sendkeys"
                  # pdf-tools / doc-view
                  "pkg-config" "poppler" "autoconf" "automake" "mupdf-tools"
                ];

                casks = [
                  {
                    name = "emacs-app@nightly";
                    greedy = true;
                  }
                  "gcloud-cli" # work
                  "kitty" "syncthing-app"
                  "hammerspoon" "jordanbaird-ice"
                  "zen" "ubersicht" # "logi-options+" "dash"
                  "docker-desktop" "reminders-menubar"
                  "battery" "breaktimer" # "shortcat"
                ];
              };

              programs.fish.enable = true;
              programs.zsh.enable = true;
              programs.tmux.enable = true;

              environment = {
                shells = [ pkgs.fish ];
                systemPackages = commonPackages ++ darwinPackages;
              };

              security.pam.services.sudo_local = {
                enable = true;
                reattach = true;
                touchIdAuth = true;
              };

              system.primaryUser = user;
              system = {
                keyboard = {
                  enableKeyMapping = true;
                  remapCapsLockToControl = true;
                };
                defaults = {
                  dock = {
                    tilesize = 50;
                    autohide = true;
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
                    AppleWindowTabbingMode = "always";
                    # NSStatusItemSpacing = 2;
                    # NSStatusItemSelectionPadding = 2;
                  };
                  CustomSystemPreferences = {
                    "com.apple.AdLib" = {
                      # Disable personalized advertising
                      forceLimitAdTracking = true;
                      allowApplePersonalizedAdvertising = false;
                      allowIdentifierForAdvertising = false;
                    };
                  };
                  CustomUserPreferences = {
                    "org.hammerspoon.Hammerspoon" = {
                      MJConfigFile = "~/.config/hammerspoon/init.lua";
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
          fishtape.src
          fzf-fish.src
          z.src
        ];
      };
      programs.fzf.enableFishIntegration = false;
      environment.shells = with pkgs; [ fish ];
      users.defaultUserShell = pkgs.fish;
    };
}
