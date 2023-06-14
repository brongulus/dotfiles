if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

    # Aliases
    if [ -f $HOME/.config/alias ]
    source $HOME/.config/alias
    end
    
    set PATH ~/.emacs.d/bin $PATH
    set PATH ~/bin $PATH
    set PATH ~/.cargo/bin $PATH
    set PATH ~/.local/bin $PATH
    set PATH ~/.local/share/gem/ruby/3.0.0/bin $PATH
    set PATH ~/.spicetify $PATH
    set PATH ~/.guix-profile/bin $PATH

    set --export COLORTERM "truecolor"
    set --export FZF_COMPLETION_TRIGGER "``"
    # set --export FZF_DEFAULT_OPTS "--color=bg+:#3B4252,border:#D8DEE9,bg:#263238,spinner:#81A1C1,hl:#616E88,fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#81A1C1,marker:#81A1C1,fg+:#D8DEE9,prompt:#81A1C1,hl+:#81A1C1"
    set fzf_fd_opts --hidden --exclude=.git
    set fzf_directory_opts --bind "enter:execute(setsid xdg-open {} &> /dev/tty)"

    function fzf-open
       set -l file
       set file (fzf --height 60% --border --reverse --preview 'bat --style changes --color=always {} | head -500') &&
       setsid xdg-open "$file"
    end

		function magit
    	 set -l git_root (git rev-parse --show-toplevel)
    	 vmacs -nw --eval "
			 (progn
				  (add-to-list 'load-path (locate-user-emacs-file \"el-get/dash\"))
				  (add-to-list 'load-path (locate-user-emacs-file \"el-get/compat\"))
  				(add-to-list 'load-path (locate-user-emacs-file \"el-get/transient/lisp\"))
					(add-to-list 'load-path (locate-user-emacs-file \"el-get/ghub/lisp\"))
				  (add-to-list 'load-path (locate-user-emacs-file \"el-get/magit-pop\"))
				  (add-to-list 'load-path (locate-user-emacs-file \"el-get/with-editor/lisp\"))
					(add-to-list 'load-path (locate-user-emacs-file \"el-get/magit/lisp\"))
				  (require 'magit)
					(setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1) (magit-status \"$git_root\"))"
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

    function eman -d "Open man page in emacs"
        command emacsclient -nw --eval "(switch-to-buffer (man \"$argv\"))"
    end

    fzf_configure_bindings --directory=\cf

		bind \eg magit

    bind \cp 'xclip -o'

end
