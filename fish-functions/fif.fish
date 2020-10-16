function fif
    if test (count $argv) != 1
        echo need argument
        exit 1
    else
        vim (rg --files-with-matches --no-messages "$argv[1]" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$argv[1]' || rg --ignore-case --pretty --context 10 '$argv[1]' {}")
        exit 0
    end
end
