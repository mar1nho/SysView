#!/bin/bash

# ========== CORES ==========
RED='\e[31m'
BOLD_RED='\e[1;31m'
NC='\e[0m'

# Prefixo de log: hora + título em negrito vermelho
log_prefix="${BOLD_RED}[ $(date +"%H:%M:%S") ] SysView:${NC} ${RED}"

# ========== FUNÇÕES ==========

decrypt_item() {
    echo -e "${log_prefix}🔓 Descriptografar todos os arquivos .gpg em uma pasta${NC}"
    echo -e "${log_prefix}Informe o caminho completo da pasta:${NC}"
    read -p "$(echo -e "${log_prefix}Caminho da pasta: ${NC}")" folder

    if [ ! -d "$folder" ]; then
        echo -e "${log_prefix}❌ Esta não é uma pasta válida.${NC}"
        return
    fi

    shopt -s nullglob
    files=("$folder"/*.gpg)

    if [ ${#files[@]} -eq 0 ]; then
        echo -e "${log_prefix}⚠️ Nenhum arquivo .gpg encontrado nesta pasta.${NC}"
        return
    fi

    for encfile in "${files[@]}"; do
        original="${encfile%.gpg}"
        echo -e "${log_prefix}🔓 Descriptografando $(basename "$encfile")..."
        gpg -o "$original" -d "$encfile"
        if [ $? -eq 0 ]; then
            rm -f "$encfile"
            echo -e "${log_prefix}✅ Descriptografado e removido: $(basename "$encfile")${NC}"
        else
            echo -e "${log_prefix}❌ Falha ao descriptografar: $(basename "$encfile")${NC}"
        fi
    done
}

encrypt_item() {
    echo -e "${log_prefix}🔐 Criptografar todos os arquivos em uma pasta (sem zipar)${NC}"
    echo -e "${log_prefix}Informe o caminho completo da pasta:${NC}"
    read -p "$(echo -e "${log_prefix}Caminho da pasta: ${NC}")" folder

    if [ ! -d "$folder" ]; then
        echo -e "${log_prefix}❌ Esta não é uma pasta válida.${NC}"
        return
    fi

    echo -e "${log_prefix}🔍 Escaneando arquivos em: $folder${NC}"
    sleep 1

    shopt -s nullglob
    files=("$folder"/*)

    if [ ${#files[@]} -eq 0 ]; then
        echo -e "${log_prefix}⚠️ Nenhum arquivo encontrado nesta pasta.${NC}"
        return
    fi

    for file in "${files[@]}"; do
        if [ -f "$file" ]; then
            echo -e "${log_prefix}🔒 Criptografando $(basename "$file")..."
            gpg -c --batch --yes "$file"
            if [ $? -eq 0 ]; then
                rm -f "$file" 
                echo -e "${log_prefix}✅ $(basename "$file") criptografado e original removido.${NC}"
            else
                echo -e "${log_prefix}❌ Falha ao criptografar $(basename "$file").${NC}"
            fi
        fi
    done
}

checkram() {
    echo -e "${RED}            🔹 USO DE MEMÓRIA 🔹${NC}"

    total=$(free -m | grep Mem | awk '{print $2}')
    usada=$(free -m | grep Mem | awk '{print $3}')
    livre=$(free -m | grep Mem | awk '{print $4}')
    disponivel=$(free -m | grep Mem | awk '{print $7}')

    echo -e "${log_prefix}RAM Total->        ${total} MB${NC}"
    echo -e "${log_prefix}RAM em uso->       ${usada} MB${NC}"
    echo -e "${log_prefix}RAM livre->        ${livre} MB${NC}"
    echo -e "${log_prefix}RAM disponível->   ${disponivel} MB${NC}"
}

cleancache() {
    echo -e "${log_prefix}Limpando cache do sistema...${NC}"
    sudo sync
    echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
    sleep 5
    echo -e "${log_prefix}Cache limpo com sucesso!${NC}"
}

drivestorage() {
    echo -e "${log_prefix}TOP 10 MAIORES DIRETÓRIOS (nível 1)${NC}"
    echo -e "${log_prefix}Analisando... isso pode levar alguns segundos.${NC}"
    echo ""
    sleep 1

    sudo du -h --max-depth=1 / 2>/dev/null | sort -rh | head -n 10 | while read -r size path; do
        echo -e "${log_prefix}Tamanho -> $size | Caminho: $path${NC}"
    done

    echo ""
    echo -e "${log_prefix}RESUMO DE USO DE DISCO:${NC}"

    total=$(df -h / | awk 'NR==2 {print $2}')
    usado=$(df -h / | awk 'NR==2 {print $3}')
    livre=$(df -h / | awk 'NR==2 {print $4}')

    echo -e "${log_prefix}💾 Espaço total->   $total${NC}"
    echo -e "${log_prefix}📦 Espaço usado->   $usado${NC}"
    echo -e "${log_prefix}📁 Espaço livre->   $livre${NC}"
}

checkcon() {
    echo -e "${log_prefix}🌐 Verificando conexão com a internet...${NC}"
    sleep 2

    if ping -c 1 -W 2 8.8.8.8 > /dev/null; then
        latencia=$(ping -c 1 8.8.8.8 | grep 'time=' | awk -F'time=' '{ print $2 }')
        echo -e "${log_prefix}✅ Conexão ativa.${NC}"
        sleep 1
        echo -e "${log_prefix}📶 Latência com DNS do Google -> ${latencia}${NC}"
    else
        echo -e "${log_prefix}❌ Sem conexão com a internet.${NC}"
    fi
}

install_requirements() {
    echo -e "${log_prefix}⚠️ SpeedTest-CLI é necessário para o teste de velocidade.${NC}"
    echo -e "${log_prefix}Você precisará digitar sua senha para instalar.${NC}"
    echo ""

    echo -e "${log_prefix}❓ Deseja instalar o SpeedTest-CLI agora?${NC}"
    echo -e "${log_prefix}1. Não (cancelar instalação)${NC}"
    echo -e "${log_prefix}2. Sim (instalar)${NC}"
    read -p "$(echo -e "${log_prefix}Escolha uma opção [1 ou 2]: ${NC}")" escolha

    case $escolha in
        1)
            echo -e "${log_prefix}❌ Instalação cancelada pelo usuário.${NC}"
            return 1
            ;;
        2)
            echo -e "${log_prefix}🔄 Instalando SpeedTest-CLI...${NC}"
            sleep 1
            sudo apt install -y speedtest-cli
            sleep 2
            echo -e "${log_prefix}✅ Instalação concluída.${NC}"
            return 0
            ;;
        *)
            echo -e "${log_prefix}❌ Opção inválida. Abortando.${NC}"
            return 1
            ;;
    esac
}

checkspeed() {
    if ! command -v speedtest-cli &> /dev/null; then
        install_requirements || return
    fi

    echo -e "${log_prefix}⚡ Executando teste de velocidade... aguarde alguns segundos.${NC}"
    sleep 1

    resultado=$(speedtest-cli --simple 2>/dev/null)

    if [ $? -eq 0 ]; then
        echo -e "${log_prefix}✅ Teste concluído:${NC}"
        echo "$resultado" | while read -r linha; do
            echo -e "${log_prefix}${linha}${NC}"
        done
    else
        echo -e "${log_prefix}❌ Falha ao executar o teste. Verifique sua conexão.${NC}"
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
    echo -e "${BOLD_RED}                  SysView Monitor v0.1${NC}"
    echo -e "${RED}============================================================${NC}"
    echo -e "${RED}   +--------------+ 📊  Utilitário de Monitoramento do Sistema${NC}"
    echo -e "${RED}   |.------------.|-------------------------------------------${NC}"
    echo -e "${RED}   ||            || 1. Mostrar uso de RAM${NC}"
    echo -e "${RED}   ||            || 2. Limpar cache do sistema${NC}"
    echo -e "${RED}   ||            || 3. Mostrar os 10 diretórios que mais usam espaço${NC}"
    echo -e "${RED}   ||            || 4. Verificar conexão com a internet${NC}"
    echo -e "${RED}   |+------------+| 5. Testar velocidade da internet${NC}"
    echo -e "${RED}   +-..--------..-+ 6. Criptografar arquivos/pasta${NC}"
    echo -e "${RED}   .--------------. 7. Descriptografar arquivos GPG${NC}"
    echo -e "${RED}  / /============\ \\   Digite 0 para sair"
    echo -e "${RED} / /==============\ \\"
    echo -e "${RED}/____________________\\"
    echo -e "${RED}\____________________/"
    echo " "
    read -p "$(echo -e "${log_prefix}Escolha uma opção: ${NC}")" option
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
                echo -e "${log_prefix}👋 Saindo do SysView. Até mais!${NC}"
                exit 0
                ;;
            *)
                echo -e "${log_prefix}❌ Opção inválida. Tente novamente.${NC}"
                sleep 2
                ;;
        esac

        echo ""
        read -p "$(echo -e "${log_prefix}Pressione Enter para voltar ao menu...${NC}")"
    done
}

# ========= PONTO DE ENTRADA =========
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    sysview
fi
