#!/bin/bash

RED='\e[31m'
BOLD_RED='\e[1;31m'
NC='\e[0m'
log_prefix="${BOLD_RED}[ $(date +"%H:%M:%S") ] SysView:${NC} ${RED}"

check_top_resources() {
    echo -e "${RED}           🔹 PROCESSOS QUE MAIS CONSOMEM 🔹${NC}"
    echo -e "${log_prefix}Top 5 CPU:${NC}"
    ps aux --sort=-%cpu | head -n 6 | tail -n 5 | awk '{printf "  PID: %-7s CPU: %-5s CMD: %s\n", $2, $3"%", $11}'
    echo -e "\n${log_prefix}Top 5 RAM:${NC}"
    ps aux --sort=-%mem | head -n 6 | tail -n 5 | awk '{printf "  PID: %-7s RAM: %-5s CMD: %s\n", $2, $4"%", $11}'
}

checkram() {
    echo -e "${RED}            🔹 USO DE MEMÓRIA 🔹${NC}"
    free -m | grep Mem | awk -v p="$log_prefix" -v nc="$NC" '{printf "%sRAM: %dMB / %dMB (%.2f%%)%s\n", p, $3, $2, ($3/$2*100), nc}'
}

cleancache() {
    echo -e "${log_prefix}Limpando cache...${NC}"; sudo sync; echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
    sleep 2; echo -e "${log_prefix}Concluído!${NC}"
}

drivestorage() {
    echo -e "${log_prefix}TOP 10 DIRETÓRIOS:${NC}"
    sudo du -h --max-depth=1 / 2>/dev/null | sort -rh | head -n 10
}

checkcon() {
    ping -c 1 8.8.8.8 > /dev/null && echo -e "${log_prefix}✅ Online${NC}" || echo -e "${log_prefix}❌ Offline${NC}"
}

uninstall_sysview() {
    echo -e "${log_prefix}⚠️ Remover comando 'sysviewpt' do sistema?${NC}"
    read -p "(s/n): " confirm
    [[ "$confirm" == "s" ]] && sudo rm -f /usr/local/bin/sysviewpt && echo "Removido!" && exit 0
}

# (As outras funções gpg e speedtest permanecem iguais ao seu original)

main_menu() {
    clear
    echo -e "${BOLD_RED}    ███████ ██    ██ ███████ ██    ██ ██ ███████ ██     ██ ${NC}"
    echo -e "${BOLD_RED}    ██       ██  ██  ██      ██    ██ ██ ██      ██     ██ ${NC}"
    echo -e "${BOLD_RED}    ███████   ████   ███████ ██    ██ ██ █████   ██  █  ██ ${NC}"
    echo -e "${BOLD_RED}         ██    ██         ██  ██  ██  ██ ██      ██ ███ ██ ${NC}"
    echo -e "${BOLD_RED}    ███████    ██    ███████   ████   ██ ███████  ███ ███  ${NC}"
    echo -e "${BOLD_RED}                     SysView Monitor v1.0${NC}"
    echo -e "${RED}============================================================${NC}"
    echo -e "${RED}   +-----+ Utilitário de Monitoramento do Sistema +-----+${NC}"
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
    echo -e "${RED} 1. Uso de RAM                   5. Testar Velocidade${NC}"
    echo -e "${RED} 2. Limpar Cache                 6. Criptografar (GPG)${NC}"
    echo -e "${RED} 3. Espaço em Disco              7. Descriptografar (GPG)${NC}"
    echo -e "${RED} 4. Verificar Conexão            8. TOP Processos (CPU/RAM)${NC}"
    echo -e "${RED} 9. DESINSTALAR DO SISTEMA       0. Sair${NC}"
    echo -e "${RED}------------------------------------------------------------${NC}"
    read -p "$(echo -e "${log_prefix}Opção: ${NC}")" option
}

while true; do
    main_menu
    case $option in
        1) checkram ;; 2) cleancache ;; 3) drivestorage ;; 4) checkcon ;;
        8) check_top_resources ;; 9) uninstall_sysview ;; 0) exit 0 ;;
    esac
    read -p "Pressione Enter..."
done
