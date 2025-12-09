#!/bin/bash

# === CONFIGURATION ===
BACKUP_DIR=~/Desktop/dev_backup_$(date +%Y%m%d)
mkdir -p "$BACKUP_DIR"

echo "🚀 Backing up developer environment to: $BACKUP_DIR"
echo "---------------------------------------------------------------"

# --- Colors ---
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# === 1. SSH ===
if [ -d ~/.ssh ]; then
  echo -e "${BLUE}📁 Backing up SSH keys...${NC}"
  cp -r ~/.ssh "$BACKUP_DIR/ssh"
else
  echo -e "${YELLOW}⚠️  No ~/.ssh directory found${NC}"
fi

# === 2. Git config ===
if [ -f ~/.gitconfig ]; then
  echo -e "${BLUE}📁 Backing up Git config...${NC}"
  cp ~/.gitconfig "$BACKUP_DIR/gitconfig"
fi

if [ -f ~/.gitignore_global ]; then
  cp ~/.gitignore_global "$BACKUP_DIR/gitignore_global"
fi

# === 3. AWS config ===
if [ -d ~/.aws ]; then
  echo -e "${BLUE}📁 Backing up AWS config...${NC}"
  cp -r ~/.aws "$BACKUP_DIR/aws"
else
  echo -e "${YELLOW}⚠️  No ~/.aws directory found${NC}"
fi

# === 4. Zsh config ===
if [ -f ~/.zshrc ]; then
  echo -e "${BLUE}📁 Backing up Zsh config...${NC}"
  cp ~/.zshrc "$BACKUP_DIR/zshrc"
fi

if [ -f ~/.zprofile ]; then
  cp ~/.zprofile "$BACKUP_DIR/zprofile"
fi

# === 5. npm config ===
if [ -f ~/.npmrc ]; then
  echo -e "${BLUE}📁 Backing up npm config...${NC}"
  cp ~/.npmrc "$BACKUP_DIR/npmrc"
else
  echo -e "${YELLOW}⚠️  No ~/.npmrc file found${NC}"
fi

# === 6. GPG keys ===
if gpg --list-keys &>/dev/null; then
  echo -e "${BLUE}🔑 Backing up GPG keys...${NC}"
  mkdir -p "$BACKUP_DIR/gpg"
  # Export public and private keys
  gpg --export > "$BACKUP_DIR/gpg/public_keys.gpg"
  gpg --export-secret-keys > "$BACKUP_DIR/gpg/private_keys.gpg"
  # Export identity details
  gpg --list-keys > "$BACKUP_DIR/gpg/keys_list.txt"
else
  echo -e "${YELLOW}⚠️  No GPG keys found or GPG not installed${NC}"
fi

# === 7. Homebrew backup ===
if command -v brew &> /dev/null; then
  echo -e "${BLUE}🍺 Backing up Homebrew packages (Brewfile)...${NC}"
  brew bundle dump --file="$BACKUP_DIR/Brewfile" --force
else
  echo -e "${YELLOW}⚠️  Homebrew is not installed${NC}"
fi

# === 8. VS Code backup ===
if command -v code &> /dev/null; then
  echo -e "${BLUE}📝 Backing up VS Code (extensions + settings)...${NC}"
  mkdir -p "$BACKUP_DIR/vscode"

  # Extensions
  code --list-extensions > "$BACKUP_DIR/vscode/extensions.txt"

  # Settings (macOS path)
  VSCODE_DIR="$HOME/Library/Application Support/Code/User"
  
  if [ -d "$VSCODE_DIR" ]; then
    cp "$VSCODE_DIR/settings.json" "$BACKUP_DIR/vscode/settings.json" 2>/dev/null
    cp "$VSCODE_DIR/keybindings.json" "$BACKUP_DIR/vscode/keybindings.json" 2>/dev/null
    cp -r "$VSCODE_DIR/snippets" "$BACKUP_DIR/vscode/snippets" 2>/dev/null
  fi
else
  echo -e "${YELLOW}⚠️ VS Code not installed or 'code' command unavailable${NC}"
fi

# === 9. Final archive creation ===
echo -e "${BLUE}📦 Creating archive...${NC}"
cd ~/Desktop || exit
tar -czf dev_backup_$(date +%Y%m%d).tar.gz dev_backup_$(date +%Y%m%d)
echo -e "${GREEN}✅ Backup complete: ~/Desktop/dev_backup_$(date +%Y%m%d).tar.gz${NC}"

# === 10. Summary ===
echo "---------------------------------------------------------------"
echo -e "${GREEN}Backup content:${NC}"
ls -1 "$BACKUP_DIR"
echo "---------------------------------------------------------------"
echo -e "💡 Remember to store this archive somewhere safe (USB drive, Cloud, etc.)"
