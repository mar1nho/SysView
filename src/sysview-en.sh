#!/bin/bash

# ========== CORES ==========
RED='\e[31m'
BOLD_RED='\e[1;31m'
NC='\e[0m'

# Prefixo de log: hora + título em bold, mensagens em vermelho comum
log_prefix="${BOLD_RED}[ $(date +"%H:%M:%S") ] SysView:${NC} ${RED}"

# ========== FUNÇÕES ==========

decrypt_item() {
    echo -e "${log_prefix}🔓 Decrypt all .gpg files inside a folder${NC}"
    echo -e "${log_prefix}Enter the full path of the folder:${NC}"
    read -p "$(echo -e "${log_prefix}Folder path: ${NC}")" folder

    if [ ! -d "$folder" ]; then
        echo -e "${log_prefix}❌ This is not a valid folder.${NC}"
        return
    fi

    shopt -s nullglob
    files=("$folder"/*.gpg)

    if [ ${#files[@]} -eq 0 ]; then
        echo -e "${log_prefix}⚠️ No .gpg files found in this folder.${NC}"
        return
    fi

    for encfile in "${files[@]}"; do
        original="${encfile%.gpg}"
        echo -e "${log_prefix}🔓 Decrypting $(basename "$encfile")..."
        gpg -o "$original" -d "$encfile"
        if [ $? -eq 0 ]; then
            rm -f "$encfile"
            echo -e "${log_prefix}✅ Decrypted and removed: $(basename "$encfile")${NC}"
        else
            echo -e "${log_prefix}❌ Failed to decrypt: $(basename "$encfile")${NC}"
        fi
    done
}



encrypt_item() {
    echo -e "${log_prefix}🔐 Encrypt all files inside a folder (no zip)${NC}"
    echo -e "${log_prefix}Enter the full path of the folder:${NC}"
    read -p "$(echo -e "${log_prefix}Folder path: ${NC}")" folder

    if [ ! -d "$folder" ]; then
        echo -e "${log_prefix}❌ This is not a valid folder.${NC}"
        return
    fi

    echo -e "${log_prefix}🔍 Scanning files inside: $folder${NC}"
    sleep 1

    shopt -s nullglob
    files=("$folder"/*)

    if [ ${#files[@]} -eq 0 ]; then
        echo -e "${log_prefix}⚠️ No files found in this folder.${NC}"
        return
    fi

    for file in "${files[@]}"; do
        if [ -f "$file" ]; then
            echo -e "${log_prefix}🔒 Encrypting $(basename "$file")..."
            gpg -c --batch --yes "$file"
            if [ $? -eq 0 ]; then
                rm -f "$file" 
                echo -e "${log_prefix}✅ $(basename "$file") encrypted and original deleted.${NC}"
            else
                echo -e "${log_prefix}❌ Failed to encrypt $(basename "$file").${NC}"
            fi
        fi
    done
}




checkram() {
    echo -e "${RED}            🔹 MEMORY USAGE 🔹${NC}"

    total=$(free -m | grep Mem | awk '{print $2}')
    used=$(free -m | grep Mem | awk '{print $3}')
    free=$(free -m | grep Mem | awk '{print $4}')
    available=$(free -m | grep Mem | awk '{print $7}')

    echo -e "${log_prefix}Total RAM->        ${total} MB${NC}"
    echo -e "${log_prefix}Used RAM->         ${used} MB${NC}"
    echo -e "${log_prefix}Free RAM->         ${free} MB${NC}"
    echo -e "${log_prefix}Available RAM->    ${available} MB${NC}"
}

cleancache() {
    echo -e "${log_prefix}Clearing system cache...${NC}"
    sudo sync
    echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
    sleep 5
    echo -e "${log_prefix}Cache successfully cleared!${NC}"
}

drivestorage() {
    echo -e "${log_prefix}TOP 10 LARGEST DIRECTORIES (depth 1)${NC}"
    echo -e "${log_prefix}Scanning, this may take a few seconds...${NC}"
    echo ""
    sleep 1

    sudo du -h --max-depth=1 / 2>/dev/null | sort -rh | head -n 10 | while read -r size path; do
        echo -e "${log_prefix}Size -> $size | Path: $path${NC}"
    done

    echo ""
    echo -e "${log_prefix}DISK USAGE SUMMARY:${NC}"

    total_space=$(df -h / | awk 'NR==2 {print $2}')
    used_space=$(df -h / | awk 'NR==2 {print $3}')
    free_space=$(df -h / | awk 'NR==2 {print $4}')

    echo -e "${log_prefix}💾 Total space->    $total_space${NC}"
    echo -e "${log_prefix}📦 Used space->     $used_space${NC}"
    echo -e "${log_prefix}📁 Free space->     $free_space${NC}"
}

checkcon() {
    echo -e "${log_prefix}🌐 Checking internet connection...${NC}"
    sleep 2

    if ping -c 1 -W 2 8.8.8.8 > /dev/null; then
        latency=$(ping -c 1 8.8.8.8 | grep 'time=' | awk -F'time=' '{ print $2 }')
        echo -e "${log_prefix}✅ Internet connection is active.${NC}"
        sleep 1
        echo -e "${log_prefix}📶 Latency to Google DNS-> ${latency}${NC}"
    else
        echo -e "${log_prefix}❌ No internet connection.${NC}"
    fi
}

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

install_requirements() {
    local pkg_manager=$(detect_package_manager)
    
    echo -e "${log_prefix}⚠️ SpeedTest-CLI is required for internet speed testing.${NC}"
    echo -e "${log_prefix}You will be asked for your sudo password to install it.${NC}"
    
    if [ "$pkg_manager" = "unknown" ]; then
        echo -e "${log_prefix}❌ Package manager not recognized.${NC}"
        echo -e "${log_prefix}Please install speedtest-cli manually.${NC}"
        return 1
    fi
    
    echo -e "${log_prefix}📦 Detected package manager: $pkg_manager${NC}"
    echo ""

    echo -e "${log_prefix}❓ Do you want to install SpeedTest-CLI now?${NC}"
    echo -e "${log_prefix}1. No (cancel installation)${NC}"
    echo -e "${log_prefix}2. Yes (install)${NC}"
    read -p "$(echo -e "${log_prefix}Choose an option [1 or 2]: ${NC}")" choice

    case $choice in
        1)
            echo -e "${log_prefix}❌ Installation canceled by user.${NC}"
            return 1
            ;;
        2)
            echo -e "${log_prefix}🔄 Installing SpeedTest-CLI...${NC}"
            sleep 1
            
            case "$pkg_manager" in
                apt)
                    sudo apt update && sudo apt install -y speedtest-cli
                    ;;
                pacman)
                    sudo pacman -Sy --noconfirm speedtest-cli
                    ;;
                dnf)
                    sudo dnf install -y speedtest-cli
                    ;;
                yum)
                    sudo yum install -y speedtest-cli
                    ;;
                zypper)
                    sudo zypper install -y speedtest-cli
                    ;;
            esac
            
            if [ $? -eq 0 ]; then
                sleep 2
                echo -e "${log_prefix}✅ Installation complete.${NC}"
                return 0
            else
                echo -e "${log_prefix}❌ Installation failed.${NC}"
                return 1
            fi
            ;;
        *)
            echo -e "${log_prefix}❌ Invalid option. Aborting.${NC}"
            return 1
            ;;
    esac
}

checkspeed() {
    if ! command -v speedtest-cli &> /dev/null; then
        install_requirements || return
    fi

    echo -e "${log_prefix}⚡ Running internet speed test, this may take a few seconds...${NC}"
    sleep 1

    resultado=$(speedtest-cli --simple 2>/dev/null)

    if [ $? -eq 0 ]; then
        echo -e "${log_prefix}✅ Test completed:${NC}"
        echo "$resultado" | while read -r linha; do
            echo -e "${log_prefix}${linha}${NC}"
        done
    else
        echo -e "${log_prefix}❌ Failed to run speed test. Check your internet connection.${NC}"
    fi
}

# ========== MENU ==========

main_menu() {
    clear
    echo -e "${BOLD_RED}    ███████ ██    ██ ███████ ██    ██ ██ ███████ ██     ██ ${NC}"
    echo -e "${BOLD_RED}    ██       ██  ██  ██      ██    ██ ██ ██      ██     ██ ${NC}"
    echo -e "${BOLD_RED}    ███████   ████   ███████ ██    ██ ██ █████   ██  █  ██ ${NC}"
    echo -e "${BOLD_RED}         ██    ██         ██  ██  ██  ██ ██      ██ ███ ██ ${NC}"
    echo -e "${BOLD_RED}    ███████    ██    ███████   ████   ██ ███████  ███ ███  ${NC}"
    echo -e "${BOLD_RED}                    SysView Monitor v0.2${NC}"
    echo -e "${RED}============================================================${NC}"
    echo -e "${RED}   +--------------+ 📊  System Resource Monitoring Utility${NC}"
    echo -e "${RED}   |.------------.|--------------------------------------${NC}"
    echo -e "${RED}   ||            || 1. Show RAM usage${NC}"
    echo -e "${RED}   ||            || 2. Clear system cache${NC}"
    echo -e "${RED}   ||            || 3. Show top 10 disk consumers${NC}"
    echo -e "${RED}   ||            || 4. Check internet connection${NC}"
    echo -e "${RED}   |+------------+| 5. Run internet speed test${NC}"
    echo -e "${RED}   +-..--------..-+ 6. Encrypt file/folder${NC}"
    echo -e "${RED}   .--------------. 7. Decrypt GPG file${NC}"
    echo -e "${RED}  / /============\ \\   Enter 0 to quit!"
    echo -e "${RED} / /==============\ \\"
    echo -e "${RED}/____________________\\"
    echo -e "${RED}\____________________/"
    echo " "
    read -p "$(echo -e "${log_prefix}Select an option: ${NC}")" option
}

sysview() {
    while true; do
        main_menu
        case $option in
            1) checkram ;;
            2) cleancache ;;
            3) drivestorage ;;
            4) checkcon ;;
            5) checkspeed ;;
            6) encrypt_item ;;
            7) decrypt_item ;;
            0)
                echo ""
                echo -e "${log_prefix}👋 Exiting SysView. Goodbye!${NC}"
                exit 0
                ;;
            *)
                echo -e "${log_prefix}❌ Invalid option. Try again.${NC}"
                sleep 2
                ;;
        esac

        echo ""
        read -p "$(echo -e "${log_prefix}Press Enter to return to menu...${NC}")"
    done
}


# ========= ENTRY POINT =========
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    sysview
fi