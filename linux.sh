#######################################################################
# Desktop environment (optional)                                      #
# /!\ It's better to use the proper iso from the beginning            #
# @see https://raspberrytips.com/best-desktop-environments-ubuntu/    #
#######################################################################

# budgie https://buddiesofbudgie.org/
# sudo apt install ubuntu-budgie-desktop

# kde https://kde.org/
# sudo apt install kde-plasma-desktop

# cinamon https://github.com/linuxmint/cinnamon
# sudo apt install cinnamon-desktop-environment

sudo apt update && sudo apt upgrade -y
# sudo killall snap-store && sudo snap refresh
sudo apt install -y apt-transport-https curl git htop wget gpg terminator unzip
pip3 install tldr # @see https://github.com/tldr-pages/tldr?tab=readme-ov-file#how-do-i-use-it
sudo apt remove --purge -y aisleriot gnome-2048 gnome-mahjongg gnome-mines gnome-sudoku
sudo apt remove --purge -y thunderbird transmission-gtk transmission-common
sudo apt autoclean && sudo apt autoremove
sudo reboot

# powerlevel10k prerequisites
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
sudo mv MesloLGS*.ttf /usr/share/fonts/

#######################################################################
# Manually set terminal font to MesloLGS NF                           #
# You can also change terminal opacity/transparency                   #
#######################################################################

# zsh https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH
sudo apt install zsh -y
chsh -s $(which zsh)
#######################################################################
# To start using the Z Shell, log out of the terminal and log back in #
# You can run echo $SHELL from a new terminal to confirm              #
#######################################################################

# ohmyzsh https://github.com/ohmyzsh/ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
sed -i 's/plugins=.*$/plugins=(git git-prompt gh zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc

echo "alias ..='cd ..'" >> ~/.zshrc
echo "alias ...='cd ../..'" >> ~/.zshrc

# bat https://github.com/sharkdp/bat
sudo apt install -y bat
echo "alias cat='batcat'" >> ~/.zshrc

# eza https://github.com/eza-community/eza/blob/main/INSTALL.md
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update && sudo apt install -y eza
echo "alias ls='eza -a --icons=always --group-directories-first'" >> ~/.zshrc
echo "alias ll='ls -ll'" >> ~/.zshrc
source ~/.zshrc

# powerlevel10k https://github.com/romkatv/powerlevel10k
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
sed -i 's/ZSH_THEME="[^"]*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
p10k configure

# Shorter Prompt Line
# vim ~/.p10k.zsh
# remove "os_icon" from POWERLEVEL9K_LEFT_PROMPT_ELEMENTS

# nvm with node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.zshrc
nvm install 22

#######################################################################
# Software installation (optional)                                    #
#######################################################################

# vscode https://code.visualstudio.com/Download
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt update && sudo apt install -y code

# brave-browser https://brave.com/linux/
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update && sudo apt install -y brave-browser

# vlc https://github.com/videolan/vlc
sudo apt install -y vlc

# filezilla https://filezilla-project.org/
sudo apt install -y filezilla

# slack
wget https://downloads.slack-edge.com/desktop-releases/linux/x64/4.38.125/slack-desktop-4.38.125-amd64.deb -o slack-desktop.deb
sudo apt install ./slack-desktop.deb
