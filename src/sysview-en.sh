#!/bin/bash

RED='\e[31m'
BOLD_RED='\e[1;31m'
NC='\e[0m'
log_prefix="${BOLD_RED}[ $(date +"%H:%M:%S") ] SysView:${NC} ${RED}"

check_top_resources() {
    echo -e "${RED}           🔹 TOP RESOURCE CONSUMERS 🔹${NC}"
    echo -e "${log_prefix}Top 5 CPU:${NC}"
    ps aux --sort=-%cpu | head -n 6 | tail -n 5 | awk '{printf "  PID: %-7s CPU: %-5s CMD: %s\n", $2, $3"%", $11}'
    echo -e "\n${log_prefix}Top 5 RAM:${NC}"
    ps aux --sort=-%mem | head -n 6 | tail -n 5 | awk '{printf "  PID: %-7s RAM: %-5s CMD: %s\n", $2, $4"%", $11}'
}

checkram() {
    echo -e "${RED}            🔹 MEMORY USAGE 🔹${NC}"
    free -m | grep Mem | awk -v p="$log_prefix" -v nc="$NC" '{printf "%sRAM: %dMB / %dMB (%.2f%%)%s\n", p, $3, $2, ($3/$2*100), nc}'
}

uninstall_sysview() {
    echo -e "${log_prefix}⚠️ Remove 'sysviewen' command from system?${NC}"
    read -p "(y/n): " confirm
    [[ "$confirm" == "y" ]] && sudo rm -f /usr/local/bin/sysviewen && echo "Removed!" && exit 0
}

# (Demais funções traduzidas conforme sua versão anterior)

main_menu() {
    clear
    echo -e "${BOLD_RED}                     SysView Monitor v1.0${NC}"
    echo -e "${RED}============================================================${NC}"
    echo -e "${RED}   +-----+ System Utilies Analysis +-----+${NC}"
    echo -e "${RED}                       |.------------.| "
    echo -e "${RED}                       ||            || "
    echo -e "${RED}                       ||            || "
    echo -e "${RED}                       ||            || "
    echo -e "${RED}                       ||            || "
    echo -e "${RED}                       |+------------+| "
    echo -e "${RED}                       +-..--------..-+ "
    echo -e "${RED}                       .--------------. "
    echo -e "${RED}                      / /============\ \\"  
    echo -e "${RED}                     / /==============\ \\"
    echo -e "${RED}                    /____________________\\"
    echo -e "${RED}                    \____________________/"
    echo " " 
    echo -e "${RED}============================================================${NC}"
    echo -e "${RED} 1. RAM Usage                    5. Speed Test${NC}"
    echo -e "${RED} 2. Clear Cache                  6. Encrypt (GPG)${NC}"
    echo -e "${RED} 3. Disk Space                   7. Decrypt (GPG)${NC}"
    echo -e "${RED} 4. Check Connection             8. TOP Processes (CPU/RAM)${NC}"
    echo -e "${RED} 9. UNINSTALL FROM SYSTEM        0. Quit${NC}"
    echo -e "${RED}------------------------------------------------------------${NC}"
    read -p "$(echo -e "${log_prefix}Option: ${NC}")" option
}

while true; do
    main_menu
    case $option in
        1) checkram ;; 8) check_top_resources ;; 9) uninstall_sysview ;; 0) exit 0 ;;
        # ... outras opções
    esac
    read -p "Press Enter..."
done
