#!/usr/bin/env bash

# ANSI color codes
GREEN="\033[0;32m"
RED="\033[0;31m"
BLUE="\033[0;34m"
BOLD="\033[1m"
RESET="\033[0m"

# Unicode symbols
CHECKMARK="✓"
CROSS="✘"

REPO="shustinm/dotfiles"
CONFIG_LOCATION="config/zsh"
BARE_FILES="zshrc zprofile zshenv"
IGNORED_FILES="install.sh README.md"

check_and_install() {
    local software_name=$1
    local install_command=$2

    if command -v "$software_name" &> /dev/null; then
        echo -e "${GREEN}${CHECKMARK}${RESET} $software_name is already installed."
    else
        echo -e "${RED}${CROSS}${RESET} $software_name is ${RED}not${RESET} installed."
        echo "Installing $software_name..."
        eval "$install_command"
        if command -v "$software_name" &> /dev/null; then
            echo -e "${GREEN}${CHECKMARK} $software_name installed successfully.${RESET}"
        else
            echo -e "${RED}${CROSS} Installation of $software_name failed. Please check and try again.${RESET}"
        fi
    fi
}

backup_zsh_files() {
    local timestamp
    timestamp=$(date +"%Y%m%d_%H%M%S")

    for file in $BARE_FILES; do
        local file_path="$HOME/.$file"
        if [[ -f "$file_path" ]]; then
            local backup_file="${file_path}.backup_$timestamp"
            cp "$file_path" "$backup_file"
            echo -e "${GREEN}${CHECKMARK}${RESET} Backed up $(basename "$file_path") to $(basename "$backup_file")"
        fi
    done

    for file in "$HOME/.$CONFIG_LOCATION"/*.zsh; do
        if [[ -f "$file" ]]; then
            local backup_file="${file}.backup_$timestamp"
            cp "$file" "$backup_file"
            echo -e "${GREEN}${CHECKMARK}${RESET} Backed up $(basename "$file") to $(basename "$backup_file")"
        fi
    done
}

download_zsh_files() {
    mkdir -p "$HOME/.$CONFIG_LOCATION" || { echo "Failed to create directory $HOME/.$CONFIG_LOCATION"; exit 1; }

    for file in $BARE_FILES; do
        [[ " $IGNORED_FILES " =~ " $file " ]] && continue
        url="https://raw.githubusercontent.com/$REPO/main/$file"
        dest="$HOME/.$file"
        curl -fsSL "$url" -o "$dest" && \
            echo -e "${GREEN}${CHECKMARK}${RESET} Downloaded $file"
    done

    config_url="https://api.github.com/repos/$REPO/contents/$CONFIG_LOCATION"

    files=$(curl -fsSL "$config_url" | grep -o '"name": "[^"]*"' | awk -F'"' '{print $4}')

    for file in $files; do
        [[ " $IGNORED_FILES " =~ " $file " ]] && continue
        url="https://raw.githubusercontent.com/$REPO/main/$CONFIG_LOCATION/$file"
        dest="$HOME/.$CONFIG_LOCATION/$file"
        curl -fsSL "$url" -o "$dest" && \
            echo -e "${GREEN}${CHECKMARK}${RESET} Downloaded $CONFIG_LOCATION/$file"
    done
}

echo -e "${BOLD}${BLUE}Installing prerequisites...${RESET}"
check_and_install "brew" '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
check_and_install "starship" "brew install starship"
check_and_install "font-jetbrains-mono-nerd-font" "brew install font-jetbrains-mono-nerd-font"
check_and_install "bat" "brew install bat"
check_and_install "fzf" "brew install fzf"
check_and_install "eza" "brew install eza"

echo -e "\n${BOLD}${BLUE}Backing up Zsh configuration files...${RESET}"
backup_zsh_files

echo -e "\n${BOLD}${BLUE}Downloading Zsh configuration from ${REPO}${RESET}"
download_zsh_files
