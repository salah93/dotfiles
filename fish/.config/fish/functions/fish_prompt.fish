function fish_prompt --description 'Write out the prompt'
	if test -z "$WINDOW"
        printf '%s%s@%s%s%s%s %s%s%s%s%s> ' (set_color yellow) (whoami) (set_color purple) (prompt_hostname) (set_color $fish_color_cwd) (prompt_pwd) (set_color yellow) (parse_git_branch) (set_color red) (find_git_dirty) (set_color normal)
    else
        printf '%s%s@%s%s%s(%s)%s%s %s%s%s%s%s> ' (set_color yellow) (whoami) (set_color purple) (prompt_hostname) (set_color white) (echo $WINDOW) (set_color $fish_color_cwd) (prompt_pwd) (set_color yellow) (parse_git_branch) (set_color red) (find_git_dirty) (set_color normal)
    end
end
