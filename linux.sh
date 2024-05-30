sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git htop wget gpg
sudo apt autoclean && sudo apt autoremove
sudo reboot

# zsh https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH
sudo apt install zsh -y
chsh -s $(which zsh)
#######################################################################
# To start using the Z Shell, log out of the terminal and log back in #
#######################################################################

# ohmyzsh https://github.com/ohmyzsh/ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
sed -i 's/plugins=.*$/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc

echo "alias ..='cd ..'" >> ~/.zshrc
echo "alias ...='cd ../..'" >> ~/.zshrc

# bat https://github.com/sharkdp/bat
sudo apt install bat
echo "alias cat='batcat' # if doesnt work try alias cat='bat'" >> ~/.zshrc

# eza https://github.com/eza-community/eza/blob/main/INSTALL.md
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
echo "alias ll='eza -ll -a --icons=always --group-directories-first'" >> ~/.zshrc
echo "alias ls='eza -a --icons=always --group-directories-first'" >> ~/.zshrc

# powerlevel10k prerequisites
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
sudo cp MesloLGS*.ttf /usr/share/fonts/
sudo fcache-cache /usr/share/fonts/
#######################################################################
# Manually set terminal font to MesloLGS NF                           #
#######################################################################

# powerlevel10k https://github.com/romkatv/powerlevel10k
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
sed -i 's/ZSH_THEME="[^"]*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
# p10k configure # if setup doesnt start automatically

# nvm with node
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 
source ~/.zshrc
nvm install 22

#######################################################################
# Software installation (optional)                                    #
#######################################################################

# brave-browser https://brave.com/linux/
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

# vscode https://code.visualstudio.com/Download
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https -y
sudo apt install code
