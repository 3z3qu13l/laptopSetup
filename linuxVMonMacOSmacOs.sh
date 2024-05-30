# @see https://tart.run/quick-start/
brew install cirruslabs/cli/tart

# create VM env
tart create --linux linux:latest
tart set --cpu 6 linux:latest
tart set --memory 8192 linux:latest # 8GB ram
tart set --disk-size 30 linux:latest # 30GB

# Here we choose debian but can be Ubuntu as well
# as long as it is arm64 for Apple Silicon CPUs
# @see https://cdimage.debian.org/debian-cd/current/arm64/iso-dvd/
# @see https://ubuntu.mirrors.ovh.net/ubuntu-releases/24.04/
wget https://cdimage.debian.org/debian-cd/current/arm64/iso-dvd/debian-12.5.0-arm64-DVD-1.iso
tart run --disk debian-12.5.0-arm64-DVD-1.iso --dir="~/:rw" --capture-system-keys linux:latest

# (inside VM from here)
sudo apt update && sudo apt upgrade -y
apt install curl git htop wget
sudo apt autoclean && sudo apt autoremove
sudo reboot
# run linux.sh 

# to start the VM later, run the following:
tart run --dir="Projects" --capture-system-keys linux:latest
