set -U STARSHIP_CONFIG "$HOME/.sel/starship/starship.toml"
set -U STARSHIP_CACHE "$HOME/.sel/.xdg/cache/starship"
starship init fish | source
