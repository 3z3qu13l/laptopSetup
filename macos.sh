chsh -s /bin/zsh
#######################################################################
# To start using the Z Shell, log out of the terminal and log back in #
# You can run echo $SHELL from a new terminal to confirm              #
#######################################################################

# homebrew https://brew.sh/
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
source ~/.zprofile

brew install bat cmake eza ffmpeg git jq terminator vim

brew tap homebrew/cask-fonts
brew install font-meslo-lg-nerd-font
#######################################################################
# Manually install fonts                                              #
# Manually set terminal font to MesloLGS NF                           #
# You can also change terminal opacity/transparency                   #
#######################################################################

# ohmyzsh https://github.com/ohmyzsh/ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew install zsh-autosuggestions
echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
source ~/.zshrc

brew install zsh-syntax-highlighting
echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
source ~/.zshrc

sed -i 's/plugins=.*$/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc

echo "alias ..='cd ..'" >> ~/.zshrc
echo "alias ...='cd ../..'" >> ~/.zshrc
echo "alias cat='bat'" >> ~/.zshrc
echo "alias ls='eza -a --icons=always --group-directories-first'" >> ~/.zshrc
echo "alias ll='ls -ll'" >> ~/.zshrc

# powerlevel10k https://github.com/romkatv/powerlevel10k
brew install powerlevel10k
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
sed -i 's/ZSH_THEME="[^"]*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
source ~/.zshrc

brew install nvm # you may have to manually add a couple of lines in ~/.zshrc after install
nvm install 22

brew install --cask alt-tab brave-browser visual-studio-code vlc
# brew install --cask libreoffice
# brew install --cask discord whatsapp
# brew install --cask spotify

# filezilla https://filezilla-project.org/download.php
