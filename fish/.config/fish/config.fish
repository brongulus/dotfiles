# To benchmark: fish --profile-startup /tmp/start.prof -lic exit
# To sort: cat /tmp/start.prof | sort -nk2 | tac | head
## In fish with nix on mac: sourcing /etc/fish/config.fish was causing immense slowdown

if status is-interactive
    test -f "$HOME/.config/alias"; and source "$HOME/.config/alias"

    # Gardener
    [ -n "$GCTL_SESSION_ID" ] || [ -n "$TERM_SESSION_ID" ] || set -gx GCTL_SESSION_ID (uuidgen)

    # Commands to run in interactive sessions can go here
    # source ~/.config/fish/eat
    # alias find-file="_eat_msg ff"

    # if [ -z "$TMUX" ]; and [ "$TERM" = "xterm-kitty" ];
    #     tmux attach || exec tmux new-session && exit;
    # end
end

set fish_greeting

# z.fish
mkdir -p $HOME/.local/share/z
set -U Z_DATA_DIR "$HOME/.local/share/z"
set -U Z_DATA "$HOME/.local/share/z/data"

if [ "$(uname)" = "Darwin" ];
   set -l BREW_PREFIX "/opt/homebrew" #(brew --prefix)
   if test -x {$BREW_PREFIX}/bin/brew
      # eval ({$BREW_PREFIX}/bin/brew shellenv)
      set --global --export HOMEBREW_PREFIX "/opt/homebrew";
      set --global --export HOMEBREW_CELLAR "/opt/homebrew/Cellar";
      set --global --export HOMEBREW_REPOSITORY "/opt/homebrew/Library/.homebrew-is-managed-by-nix";
      fish_add_path --global --move --path "/opt/homebrew/bin" "/opt/homebrew/sbin";
      
      set PATH {$BREW_PREFIX}/opt/coreutils/libexec/gnubin $PATH
      set PATH {$BREW_PREFIX}/opt/gnu-sed/libexec/gnubin $PATH
      set PATH {$BREW_PREFIX}/opt/gnu-tar/libexec/gnubin $PATH
      set PATH {$BREW_PREFIX}/opt/grep/libexec/gnubin $PATH
      set PATH {$BREW_PREFIX}/opt/gzip/bin $PATH
      
     if test -n "$MANPATH[1]"; set --global --export MANPATH '' $MANPATH; end;
      if not contains "/opt/homebrew/share/info" $INFOPATH; set --global --export INFOPATH "/opt/homebrew/share/info" $INFOPATH; end;
   end
   if [ -f "$BREW_PREFIX/share/google-cloud-sdk/path.fish.inc" ]
      source "$BREW_PREFIX/share/google-cloud-sdk/path.fish.inc"
   end
end
###########
### FZF ###
###########
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
            (package-activate-all)
            (setq magit-auto-revert-mode nil
                  magit-display-buffer-function
                  #'magit-display-buffer-fullframe-status-v1)
            (require 'magit)
            (magit-status \"$git_root\")))"
end

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

function k --wraps kubectl
  command kubecolor $argv
end

function ky --wraps kubectl
  command kubecolor $argv -oyaml
end

# reuse "kubectl" completions on "kubecolor"
function kubecolor --wraps kubectl
  command kubecolor $argv
end

# toggle kube-ps
function kps
  set -U __kube_ps_enabled (math abs\((math $__kube_ps_enabled - 1)\))
end

function kcfg
    export KUBECONFIG="$argv"
    if [ -n "$TMUX" ]
      tmux set-option -p @kubeconfig "$KUBECONFIG"
      tmux refresh-client -S
    end
end
