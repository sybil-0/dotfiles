# pretty prompt
curl -sS https://starship.rs/install.sh | sh

git config --global user.name "Kevin Hermann"
git config --global user.email "hermannkevin@gmail.com"

# nordvpn
sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)

# better history
/bin/bash -c "$(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)"

chsh -s /usr/bin/fish

# uv, fast python environment management
curl -LsSf https://astral.sh/uv/install.sh | sh

# Brave Browser 
curl -fsS https://dl.brave.com/install.sh | sh

# Zed Editor 
curl -f https://zed.dev/install.sh | sh

# zsh setup 
# Define the Oh My Zsh custom plugin directory
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
echo "🔹 Installing Zsh Plugins..."
# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
# Install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# Install zsh-completions
git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
# Install zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-history-substring-search $ZSH_CUSTOM/plugins/zsh-history-substring-search
# Install zsh-you-should-use
git clone https://github.com/MichaelAquilina/zsh-you-should-use $ZSH_CUSTOM/plugins/zsh-you-should-use
# Install zsh-abbr
git clone https://github.com/olets/zsh-abbr $ZSH_CUSTOM/plugins/zsh-abbr
