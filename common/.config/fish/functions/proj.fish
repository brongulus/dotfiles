function proj
    set emacs_project_file $HOME/.emacs.d/projects
    set project (grep -oE '"[^"]*"' {$emacs_project_file} | sed 's|"||g' | fzf --margin=10%)
    if test -d "$project"
       cd $project
    end
end