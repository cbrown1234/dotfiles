if status is-interactive
and not set -q TMUX
    if tmux has-session -t home
        exec tmux attach-session -t home
    else
        tmux new-session -s home
    end
end

starship init fish | source

# pyenv
fish_add_path /home/chris/.pyenv/bin

status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source
status is-interactive; and pyenv virtualenv-init - | source

# pipx
fish_add_path /home/chris/.local/bin
