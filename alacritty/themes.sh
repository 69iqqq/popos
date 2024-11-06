#!/bin/zsh
# Define the theme directory
THEME_DIR="$HOME/.config/alacritty/themes"

# Define the available themes and their corresponding Neovim colorschemes
typeset -A THEME_MAP=(
    "rose_pine_moon.toml" "rose-pine"             # Alacritty => Neovim
    "rose_pine_dark.toml" "rose-pine"             # Alacritty => Neovim
    "tokyo_night.toml" "tokyonight"               # Alacritty => Neovim
    "catppuccin_mocha.toml" "catppuccin"          # Alacritty => Neovim
    "eldritch.toml" "eldritch"                     # Alacritty => Neovim
    "solarized_osaka.toml" "solarized-osaka"      # Alacritty => Neovim
)

# Use fzf to select a theme
SELECTED_THEME=$(printf "%s\n" "${(@k)THEME_MAP}" | fzf --height 40% --reverse)

if [ -n "$SELECTED_THEME" ]; then
    cp "$THEME_DIR/$SELECTED_THEME" "$HOME/.config/alacritty/theme.toml"

    NVIM_THEME=${THEME_MAP[$SELECTED_THEME]}

    echo "Switched to theme: $SELECTED_THEME (Neovim: $NVIM_THEME)"


    # Update Neovim configuration You should use your plugins path for example ~/.config/nvim/lua/plugins/colorscheme-sh.lua
    NVIM_CONFIG="$HOME/.config/LazyVim/lua/plugins/colorscheme-sh.lua"

    # Check if the configuration file exists, create it if not
    if [ ! -f "$NVIM_CONFIG" ]; then
        echo "Creating new colorscheme configuration file at $NVIM_CONFIG"
    fi

    # Create new configuration content
    CONFIG_CONTENT=$(cat << EOF
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "$NVIM_THEME",
    },
  },
}
EOF
)

    # Write the new configuration to the file
    echo "$CONFIG_CONTENT" > "$NVIM_CONFIG"

    # Reload Neovim (assumes Neovim is already running)
    if pgrep nvim > /dev/null; then
        nvim --headless -c "source $NVIM_CONFIG" -c "qa!"
    fi
fi

