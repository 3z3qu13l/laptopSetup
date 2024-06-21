chsh -s /bin/zsh
#######################################################################
# To start using the Z Shell, log out of the terminal and log back in #
# You can run echo $SHELL from a new terminal to confirm              #
#######################################################################

# homebrew https://brew.sh/
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
source ~/.zprofile
brew tap buo/cask-upgrade

brew install bat cmake eza git btop jq stats terminator tldr vim unzip wget
brew install awscli aws-sam-cli
brew install font-meslo-lg-nerd-font
brew install --cask brave-browser iterm2 visual-studio-code postman

# Import color schemes
git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git /tmp/iTerm2-Color-Schemes
cd /tmp/iTerm2-Color-Schemes/
tools/import-scheme.sh -v 'lovelace Dracula+ VibrantInk'

#######################################################################
# Manually set terminal font to MesloLGS NF                           #
# You can also change terminal opacity/transparency                   #
# You can also change terminal font colors                            #
#######################################################################

# ohmyzsh https://github.com/ohmyzsh/ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew install zsh-autosuggestions zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

#######################################################################
# manually replace the plugins line from ~/.zshrc to
# plugins=(git git-prompt gh zsh-syntax-highlighting zsh-autosuggestions)
#######################################################################
source ~/.zshrc

echo "alias ..='cd ..'" >> ~/.zshrc
echo "alias ...='cd ../..'" >> ~/.zshrc
echo "alias cat='bat'" >> ~/.zshrc
echo "alias ls='eza -a --icons=always --group-directories-first'" >> ~/.zshrc
echo "alias ll='ls -ll'" >> ~/.zshrc

# powerlevel10k https://github.com/romkatv/powerlevel10k
brew install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
#######################################################################
# manually replace the ZSH_THEME from ~/.zshrc to
# powerlevel10k/powerlevel10k
#######################################################################

# Shorter Prompt Line
# vim ~/.p10k.zsh
# remove "os_icon" from POWERLEVEL9K_LEFT_PROMPT_ELEMENTS
source ~/.zshrc

# terminal hotkeys
# iTerm → Preferences → Profiles → Keys, set left ⌥ key acts as ESC+
# add a new Key Mapping. — -Press ⌥ + ←. Select "Send Escape Sequence" for action. Input 'b'
# add a new Key Mapping. — -Press ⌥ + →. Select "Send Escape Sequence" for action. Input 'f'

brew install nvm
#######################################################################
# Add the following to your shell profile e.g. ~/.profile or ~/.zshrc:
# export NVM_DIR="$HOME/.nvm"
#   [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh" # This loads nvm
#   [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
#######################################################################
nvm install 22

brew install --cask alt-tab vlc
# brew install --cask libreoffice
# brew install --cask discord slack whatsapp
# brew install --cask spotify

# docker https://desktop.docker.com/mac/main/arm64/Docker.dmg

# filezilla https://filezilla-project.org/download.php
