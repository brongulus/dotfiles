if status is-login
    set -l uname (uname)

    fish_add_path ~/.emacs.d/bin
    fish_add_path ~/.cargo/bin
    fish_add_path ~/go/bin
    fish_add_path ~/.local/bin
    fish_add_path ~/.local/share/gem/ruby/3.0.0/bin # FIXME
    fish_add_path ~/.spicetify
    fish_add_path ~/.nix-profile/bin
    fish_add_path ~/.krew/bin
    fish_add_path ~/dotfiles/bin/bin
    fish_add_path ~/bin

    set --export GOPATH "$HOME/go"
    set --export ALTERNATE_EDITOR ""
    set --export EDITOR "emacs -nw"
    set --export COLORTERM "truecolor"
    set --export K9S_CONFIG_DIR "$HOME/.config/k9s/"
    set --export KUBECOLOR_THEME_BASE_MUTED "black:italic"

    # Gardener
    [ -n "$GCTL_SESSION_ID" ] || [ -n "$TERM_SESSION_ID" ] || set -gx GCTL_SESSION_ID (uuidgen)
    if [ "{$uname}" = "Darwin" ];
       set -l BREW_PREFIX "/opt/homebrew" #(brew --prefix)
       if test -x {$BREW_PREFIX}/bin/brew
          eval ({$BREW_PREFIX}/bin/brew shellenv)
       end
       if [ -f "$BREW_PREFIX/share/google-cloud-sdk/path.fish.inc"]
          source "$BREW_PREFIX/share/google-cloud-sdk/path.fish.inc"
       end
    end

    ###########
    ### FZF ###
    ###########
    set --export BAT_THEME "ansi" # Solarized (dark)

    set --export FZF_COMPLETION_TRIGGER "``"
    set --export FZF_DEFAULT_COMMAND "fd --type file --follow --hidden --exclude .git"
    set --export FZF_DEFAULT_OPTS "--bind 'tab:down,shift-tab:up' --style=full
                                   --reverse --cycle --border=sharp --color=dark
                                   --color=fg:-1,bg:-1,hl:#a7bf87,fg+:-1,bg+:-1,hl+:#d9c18c
                                   --color=info:#81a2be,prompt:#a7bf87,pointer:#b294bb
                                   --color=marker:#d9c18c,spinner:#d9c18c"

    switch uname
        case Darwin
             set fzf_directory_opts --bind "enter:become(open {} &> /dev/tty)"
        case '*'
             set fzf_directory_opts --bind "enter:become(setsid xdg-open {} &> /dev/tty)"
    end
    set fzf_fd_opts --hidden --color=never --exclude=.git
    set fzf_diff_highlighter delta --paging=never --width=80

    # z.fish
    mkdir -p $HOME/.local/share/z
    set -U Z_DATA_DIR "$HOME/.local/share/z"
    set -U Z_DATA "$HOME/.local/share/z/data"

    if type -q nix
       set XDG_DATA_DIRS ~/.nix-profile/share/applications $XDG_DATA_DIRS
       # set -gx LC_ALL "C" # messes up emacs -nw icons
       if [ "{$uname}" = "Linux" ]
          set --global --export FONTCONFIG_FILE ~/.config/fontconfig/.conf.d/10-nix-fonts.conf
       end
    end

    if type -q direnv
       # set --export DIRENV_LOG_FORMAT "" # need nix-direnv logs ;-;
       ~/.nix-profile/bin/direnv hook fish | source
    end

    if type -q zoxide
       # export _ZO_DATA_DIR=$Z_DATA
       ~/.nix-profile/bin/zoxide init fish | source
       # zoxide import --from=z $Z_DATA
    end

    # uv.env.fish
    test -f "$HOME/.local/bin/env.fish"; and source "$HOME/.local/bin/env.fish"
end