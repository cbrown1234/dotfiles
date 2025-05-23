if status is-interactive
and not set -q TMUX
    if tmux has-session -t home
        exec tmux attach-session -t home
    else
        tmux new-session -s home
    end
end

# brew
# fish_add_path /home/linuxbrew/.linuxbrew/bin
if test -f /home/linuxbrew/.linuxbrew/bin/brew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

    if test -d (brew --prefix)"/share/fish/completions"
        set -p fish_complete_path (brew --prefix)/share/fish/completions
    end

    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end
end

starship init fish | source

# ruby
# before pyenv to avoid path issue with /bin
if command -q rvm 
    rvm default
end

# pyenv
fish_add_path ~/.pyenv/bin

status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - fish | source
status is-interactive; and pyenv virtualenv-init - | source

# pipx
fish_add_path ~/.local/bin

# cargo
fish_add_path ~/.cargo/bin

# mise
fish_add_path ~/.local/bin
if command -q mise
    mise activate fish | source
end

# direnv
if command -q direnv
    direnv hook fish | source
end
