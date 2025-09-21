function fish_right_prompt
    set -l last_status $status

    set -g __fish_git_prompt_showdirtystate 1
    set -g __fish_git_prompt_showuntrackedfiles 1
    set -g __fish_git_prompt_showupstream informative
    set -g __fish_git_prompt_showcolorhints 1
    set -g __fish_git_prompt_use_informative_chars 1
    # Unfortunately this only works if we have a sensible locale
    string match -qi "*.utf-8" -- $LANG $LC_CTYPE $LC_ALL
    # and set -g __fish_git_prompt_char_dirtystate \U1F4a9
    set -g __fish_git_prompt_char_untrackedfiles "?"

    # The git prompt's default format is ' (%s)'.
    # We don't want the leading space.
    set -l git_vc (fish_vcs_prompt '[%s]' 2>/dev/null)

    set -l d (set_color brblue)(date "+%R")(set_color normal)

    set -l duration "$cmd_duration$CMD_DURATION"
    if test $duration -gt 100
        set duration (math $duration / 1000)s
    else
        set duration
    end

    set -q VIRTUAL_ENV_DISABLE_PROMPT
    or set -g VIRTUAL_ENV_DISABLE_PROMPT true
    set -q VIRTUAL_ENV
    and set -l venv (set_color --background magenta) (string replace -r '.*/' '' -- "$VIRTUAL_ENV") (set_color --background normal)

    # show flake if direnv active
    set direnv ""
    if set -q DIRENV_DIR
        set direnv ""(set_color blue)"❄" 
    end
    
    # Prompt status only if it's not 0
    set -l prompt_status
    test $last_status -ne 0; and set prompt_status (set_color red)"[$last_status]"(set_color normal)

    set_color normal

    if [ "$TERM" = "eterm-color" ]
        echo -n ""
    else
        if [ -n "$TMUX" ]
            string join -n " " -- $prompt_status $venv $duration $direnv $git_vc $d
        else
            set -l kube (kubectl_status)(set_color normal)
            string join -n " " -- $prompt_status $venv $duration $direnv $kube $git_vc $d
        end
    end
end
