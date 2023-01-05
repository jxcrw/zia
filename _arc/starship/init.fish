set -U STARSHIP_CONFIG "$HOME/.zia/starship/starship.toml"
set -U STARSHIP_CACHE "$HOME/.zia/.xdg/cache/starship"
starship init fish | source
