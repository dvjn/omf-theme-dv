function fish_title
    [ "$omf_theme_dv_show_venv" = 'no' -o -z "$VIRTUAL_ENV" ]
    and echo "($_) "
    or echo '('(basename $VIRTUAL_ENV)') '

    set -l git_dir (command git rev-parse --show-toplevel ^ /dev/null)
    and echo (echo (basename $git_dir)/(git rev-parse --show-prefix) | string trim --chars='/')
    or echo (prompt_pwd)
end
