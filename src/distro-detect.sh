#!/bin/bash

# ========== DISTRIBUTION DETECTION ==========
# This script detects the Linux distribution and package manager

detect_package_manager() {
    if command -v apt &> /dev/null; then
        echo "apt"
    elif command -v pacman &> /dev/null; then
        echo "pacman"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v yum &> /dev/null; then
        echo "yum"
    elif command -v zypper &> /dev/null; then
        echo "zypper"
    else
        echo "unknown"
    fi
}

install_package() {
    local package_name="$1"
    local pkg_manager=$(detect_package_manager)
    
    case "$pkg_manager" in
        apt)
            sudo apt update && sudo apt install -y "$package_name"
            ;;
        pacman)
            sudo pacman -Sy --noconfirm "$package_name"
            ;;
        dnf)
            sudo dnf install -y "$package_name"
            ;;
        yum)
            sudo yum install -y "$package_name"
            ;;
        zypper)
            sudo zypper install -y "$package_name"
            ;;
        *)
            echo "Unknown package manager. Please install $package_name manually."
            return 1
            ;;
    esac
}

get_distro_name() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$NAME"
    else
        echo "Unknown"
    fi
}
