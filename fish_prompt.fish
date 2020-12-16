function fish_prompt
    set -l exit_code $status

    # Colors
    set -l brblack (set_color brblack)
    set -l bold (set_color -o)
    set -l magenta (set_color magenta)
    set -l green (set_color green)
    set -l blue (set_color blue)
    set -l yellow (set_color yellow)
    set -l red (set_color red)
    set -l cyan (set_color cyan)
    set -l reset (set_color normal)

    # Config
    test -z "$omf_theme_dv_prompt"
    and set -l omf_theme_dv_prompt '»'

    # Return Statuses
    set -l statuses

    test $CMD_DURATION -ge 10
    and set -a statuses $brblack'took '$yellow(math $CMD_DURATION / 1000)'s'$reset

    test $exit_code -ne 0
    and set -a statuses $brblack'returned '$red$exit_code$reset

    set -q statuses[1]; and echo $statuses

    # Seperator
    echo "$brblack"(string repeat -m $COLUMNS '-')"$normal"

    # Prompt Details
    set -l prompt_details "$bold$magenta"(whoami)"$reset" "$bold$green"(hostname)"$reset"

    set -l git_dir (command git rev-parse --show-toplevel ^ /dev/null)
    and set -a prompt_details \
        "$bold$blue"(echo (basename "$git_dir")"$reset$blue/"(git rev-parse --show-prefix) \
            | string trim --chars='/')"$reset" \
        $brblack'git/'$bold$yellow(command git status | head -n1 | cut -d ' ' -f3)( \
            command git diff --shortstat --quiet ^/dev/null; and echo ""; or echo )$reset
    or set -a prompt_details "$bold$blue"(prompt_pwd)"$reset"

    [ "$omf_theme_dv_show_venv" = 'no' -o -z "$VIRTUAL_ENV" ]
    or set -a prompt_details $brblack'env/'$bold$red(basename "$VIRTUAL_ENV")$reset

    echo $prompt_details

    # Prompt
    echo "$cyan$omf_theme_dv_prompt$bold$omf_theme_dv_prompt$reset "
end
