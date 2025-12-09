#!/bin/bash

# === CONFIGURATION ===
ARCHIVE_PATH=${1:-~/Downloads/dev_backup.tar.gz}
RESTORE_DIR=~/Desktop/dev_restore_temp

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🔁 Restoring developer environment${NC}"
echo "Archive: $ARCHIVE_PATH"
echo "---------------------------------------------------------------"

# === Checks ===
if [ ! -f "$ARCHIVE_PATH" ]; then
  echo -e "${RED}❌ Error: Archive not found at the specified path.${NC}"
  echo "Usage: ./dev_restore.sh /path/to/dev_backup_YYYYMMDD.tar.gz"
  exit 1
fi

# === Extract temporary files ===
echo -e "${BLUE}📦 Extracting archive...${NC}"
mkdir -p "$RESTORE_DIR"
tar -xzf "$ARCHIVE_PATH" -C "$RESTORE_DIR"

# Find internal extracted folder (example: dev_backup_20251105)
BACKUP_DIR=$(find "$RESTORE_DIR" -maxdepth 1 -type d -name "dev_backup_*" | head -n 1)

if [ ! -d "$BACKUP_DIR" ]; then
  echo -e "${RED}❌ Backup directory not found inside archive.${NC}"
  exit 1
fi

echo -e "📂 Extracted backup directory: ${YELLOW}$BACKUP_DIR${NC}"

# === 1. SSH ===
if [ -d "$BACKUP_DIR/ssh" ]; then
  echo -e "${BLUE}🔑 Restoring SSH keys...${NC}"
  mkdir -p ~/.ssh
  cp -r "$BACKUP_DIR/ssh/"* ~/.ssh/
  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/id_* 2>/dev/null || true
fi

# === 2. Git config ===
if [ -f "$BACKUP_DIR/gitconfig" ]; then
  echo -e "${BLUE}📁 Restoring Git configuration...${NC}"
  cp "$BACKUP_DIR/gitconfig" ~/.gitconfig
fi
[ -f "$BACKUP_DIR/gitignore_global" ] && cp "$BACKUP_DIR/gitignore_global" ~/.gitignore_global

# === 3. AWS config ===
if [ -d "$BACKUP_DIR/aws" ]; then
  echo -e "${BLUE}☁️  Restoring AWS configuration...${NC}"
  mkdir -p ~/.aws
  cp -r "$BACKUP_DIR/aws/"* ~/.aws/
  chmod 600 ~/.aws/* 2>/dev/null || true
fi

# === 4. npm config ===
if [ -f "$BACKUP_DIR/npmrc" ]; then
  echo -e "${BLUE}📦 Restoring npm configuration...${NC}"
  cp "$BACKUP_DIR/npmrc" ~/.npmrc
fi

# === 5. Zsh config ===
if [ -f "$BACKUP_DIR/zshrc" ]; then
  echo -e "${BLUE}💻 Restoring Zsh configuration...${NC}"
  cp "$BACKUP_DIR/zshrc" ~/.zshrc
fi
[ -f "$BACKUP_DIR/zprofile" ] && cp "$BACKUP_DIR/zprofile" ~/.zprofile

# === 6. GPG keys ===
if [ -d "$BACKUP_DIR/gpg" ]; then
  echo -e "${BLUE}🔐 Restoring GPG keys...${NC}"
  gpg --import "$BACKUP_DIR/gpg/public_keys.gpg" 2>/dev/null
  gpg --import "$BACKUP_DIR/gpg/private_keys.gpg" 2>/dev/null
fi

# === 7. Homebrew restore ===
if [ -f "$BACKUP_DIR/Brewfile" ]; then
  echo -e "${BLUE}🍺 Restoring Homebrew packages...${NC}"

  if ! command -v brew &>/dev/null; then
    echo -e "${YELLOW}⚠️ Homebrew is not installed.${NC}"
    read -p "➡️ Install Homebrew now? (y/n): " REPLY
    if [[ "$REPLY" == "y" ]]; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      echo -e "${YELLOW}🚫 Homebrew installation skipped.${NC}"
    fi
  fi

  if command -v brew &>/dev/null; then
    export HOMEBREW_CASK_OPTS="--appdir=~/Applications"
    brew bundle install --file="$BACKUP_DIR/Brewfile"
  fi
fi

# === 8. VS Code restore ===
if [ -d "$BACKUP_DIR/vscode" ]; then
  echo -e "${BLUE}📝 Restoring VS Code settings & extensions...${NC}"

  VSCODE_USER="$HOME/Library/Application Support/Code/User"
  mkdir -p "$VSCODE_USER"

  cp "$BACKUP_DIR/vscode/settings.json" "$VSCODE_USER/" 2>/dev/null
  cp "$BACKUP_DIR/vscode/keybindings.json" "$VSCODE_USER/" 2>/dev/null
  cp -r "$BACKUP_DIR/vscode/snippets" "$VSCODE_USER/" 2>/dev/null

  if command -v code &>/dev/null && [ -f "$BACKUP_DIR/vscode/extensions.txt" ]; then
    echo -e "${BLUE}📦 Installing VS Code extensions...${NC}"
    xargs -n 1 code --install-extension < "$BACKUP_DIR/vscode/extensions.txt"
  else
    echo -e "${YELLOW}⚠️ 'code' command not available — extensions skipped.${NC}"
  fi
fi

# === Cleanup temporary files ===
rm -rf "$RESTORE_DIR"

# === Summary ===
echo "---------------------------------------------------------------"
echo -e "${GREEN}✅ Restore completed successfully.${NC}"
echo "Restored items:"
[ -d ~/.ssh ] && echo "   - SSH keys"
[ -f ~/.gitconfig ] && echo "   - Git configuration"
[ -d ~/.aws ] && echo "   - AWS configuration"
[ -f ~/.zshrc ] && echo "   - Zsh configuration"
[ -f ~/.npmrc ] && echo "   - npm configuration"
[ -d "$HOME/Library/Application Support/Code/User" ] && echo "   - VS Code"
command -v brew &>/dev/null && [ -f "$BACKUP_DIR/Brewfile" ] && echo "   - Homebrew packages"
echo "---------------------------------------------------------------"
echo -e "💡 Open a new terminal session to apply shell configuration changes."
