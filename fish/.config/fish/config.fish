if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    # function fish_greeting
    #     clear
    # end
    ########################
    ### Aliases and Vars ###
    ########################
    if [ -f $HOME/.config/alias ]
        source $HOME/.config/alias
    end

    source ~/.config/fish/eat
    alias find-file="_eat_msg ff"

    fish_add_path ~/.emacs.d/bin
    fish_add_path ~/bin
    fish_add_path ~/.cargo/bin
    fish_add_path ~/go/bin
    fish_add_path ~/.local/bin
    fish_add_path ~/.local/share/gem/ruby/3.0.0/bin
    fish_add_path ~/.spicetify
    fish_add_path ~/.nix-profile/bin
    fish_add_path ~/dotfiles/bin/bin
    fish_add_path ~/.krew/bin

    # gardener kind setup
    set --export GOPATH "$HOME/go"
    if [ "$(uname)" = "Darwin" ];
       set PATH $(brew --prefix)/opt/coreutils/libexec/gnubin $PATH
       set PATH $(brew --prefix)/opt/gnu-sed/libexec/gnubin $PATH
       set PATH $(brew --prefix)/opt/gnu-tar/libexec/gnubin $PATH
       set PATH $(brew --prefix)/opt/grep/libexec/gnubin $PATH
       set PATH $(brew --prefix)/opt/gzip/bin $PATH
    end
    [ -n "$GCTL_SESSION_ID" ] || [ -n "$TERM_SESSION_ID" ] || set -gx GCTL_SESSION_ID (uuidgen)

    set --export ALTERNATE_EDITOR ""
    set --export EDITOR "emacs --init-directory='~/.emacs.d/nano' -nw"
    set --export COLORTERM "truecolor"

    set --export K9S_CONFIG_DIR "$HOME/.config/k9s/"

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
                                   
    set fzf_fd_opts --hidden --color=never --exclude=.git
    switch (uname)
        case Darwin
             set fzf_directory_opts --bind "enter:become(open {} &> /dev/tty)"
        case '*'
             set fzf_directory_opts --bind "enter:become(setsid xdg-open {} &> /dev/tty)"
    end
    set fzf_diff_highlighter delta --paging=never --width=80

    function fzf-open
       set -l file
       set file (fzf --height 60% --border --reverse \
                     --preview 'bat --style changes --color=always {} | head -500') &&
       switch (uname)
           case Darwin
                open "$file"
           case '*'
                setsid xdg-open "$file"
        end
    end

    # fzf --preview 'fzf-preview.sh {}'

    function frg --description "rg tui built with fzf and bat"
      rg --ignore-case --color=always --line-number --no-heading "$argv" |
         fzf --ansi \
              # --color 'hl:-1:underline,hl+:-1:underline:reverse' \
              --delimiter ':' \
              # --preview "bat --color=always {1} --theme='OneHalfDark' --highlight-line {2}" \
              --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
              --bind 'enter:become(emacs -nw +{2} {1})'
    end

    function zi --description "Like z, but choose with fzf"
      if test (count $argv) -ge 1
        set -g prev_z_argv $argv
      end
      if not set result (__z $prev_z_argv -l 2> /dev/null | fzf)
        return
      end
      cd (echo $result | sed -E 's/^[0-9.]+[ \t]+//')
    end
    ############
    ### Misc ###
    ############
    # Source: https://zenn.dev/takeokunn/articles/56010618502ccc
    function magit
        set -l git_root (git rev-parse --show-toplevel)
        emacs -nw --eval "
            (progn
                (require 'magit)
                (when (require 'popper nil t)
                  (popper-mode -1))
                  (setq magit-display-buffer-function
                  #'magit-display-buffer-fullframe-status-v1)
                (magit-status \"$git_root\"))"
    end

    bind \eg magit
    
    function mkcd -d "Create a directory and set CWD"
      command mkdir $argv
        if test $status = 0
            switch $argv[(count $argv)]
                case '-*'

                case '*'
                    cd $argv[(count $argv)]
                return
            end
        end
    end

    function yy
      set tmp (mktemp -t "yazi-cwd.XXXXXX")
      yazi $argv --cwd-file="$tmp"
      if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
         cd -- "$cwd"
      end
      rm -f -- "$tmp"
    end

    # Source: hlissner/hey
    function eman -d "Open man page in emacs"
        command emacs -nw --eval "(progn
                                    (switch-to-buffer (man \"$argv\"))
                                    (delete-other-windows))"
    end

    # z.fish
    mkdir -p $HOME/.local/share/z
    set -U Z_DATA_DIR "$HOME/.local/share/z"
    set -U Z_DATA "$HOME/.local/share/z/data"

    function k --wraps kubectl
      command kubecolor $argv
    end

    # reuse "kubectl" completions on "kubecolor"
    function kubecolor --wraps kubectl
      command kubecolor $argv
    end

    # toggle kube-ps
    function kps
      set -U __kube_ps_enabled (math abs\((math $__kube_ps_enabled - 1)\))
    end

    if type -q nix
       set XDG_DATA_DIRS ~/.nix-profile/share/applications $XDG_DATA_DIRS
       # set -gx LC_ALL "C" # messes up emacs -nw icons
       if test $(uname) = Linux
          set --global --export FONTCONFIG_FILE ~/.config/fontconfig/.conf.d/10-nix-fonts.conf
       end
    end

    if type -q direnv
       # set --export DIRENV_LOG_FORMAT "" # need nix-direnv logs ;-;
       direnv hook fish | source
    end

    if type -q zoxide
       # export _ZO_DATA_DIR=$Z_DATA
       zoxide init fish | source
       # zoxide import --from=z $Z_DATA
    end

    # if [ -z "$TMUX" ]; and [ "$TERM" = "xterm-kitty" ];
    #     tmux attach || exec tmux new-session && exit;
    # end
end
