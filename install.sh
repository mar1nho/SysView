#!/bin/bash

# ========== CORES ==========
RED='\e[31m'
BOLD_RED='\e[1;31m'
NC='\e[0m'

log_prefix="${BOLD_RED}[ $(date +"%H:%M:%S") ] SysView:${NC} ${RED}"

# ========== SELEÇÃO DE IDIOMA ==========
clear
echo -e "${BOLD_RED}    ███████ ██    ██ ███████ ██    ██ ██ ███████ ██     ██ ${NC}"
echo -e "${BOLD_RED}    ██       ██  ██  ██      ██    ██ ██ ██      ██     ██ ${NC}"
echo -e "${BOLD_RED}    ███████   ████   ███████ ██    ██ ██ █████   ██  █  ██ ${NC}"
echo -e "${BOLD_RED}         ██    ██         ██  ██  ██  ██ ██      ██ ███ ██ ${NC}"
echo -e "${BOLD_RED}    ███████    ██    ███████   ████   ██ ███████  ███ ███  ${NC}"
echo -e "${BOLD_RED}                  SysView Monitor v0.1${NC}"
echo -e "${RED}============================================================${NC}"
echo -e "${RED}   +--------------+ ${BOLD_RED}🌍 Escolha o idioma / Choose the language:${NC}"
echo -e "${RED}   |.------------.|-------------------------------------------${NC}"
echo -e "${RED}   ||            || 1. 🇬🇧 English (comando: sysviewen)"
echo -e "${RED}   ||            || 2. 🇧🇷 Português (comando: sysviewpt)"
echo -e "${RED}   ||            ||" 
echo -e "${RED}   ||            ||"
echo -e "${RED}   |+------------+|"
echo -e "${RED}   +-..--------..-+"
echo -e "${RED}   .--------------."
echo -e "${RED}  / /============\ \\ "
echo -e "${RED} / /==============\ \\"
echo -e "${RED}/____________________\\"
echo -e "${RED}\____________________/"
echo " "
read -p "-> " lang_choice

# ========== CONFIGURAÇÃO ==========
case "$lang_choice" in
    2)
        SCRIPT_NAME="SysView-pt.sh"
        DEST_CMD="sysviewpt"
        INSTALLING="🔧 Instalando SysView em português..."
        NOT_FOUND="❌ Arquivo $SCRIPT_NAME não encontrado!"
        COPYING="📂 Copiando para /usr/local/bin/$DEST_CMD (requer sudo)..."
        SUCCESS="✅ SysView em português instalado com sucesso!"
        USAGE="💡 Agora você pode usar o comando: $DEST_CMD"
        FAIL="❌ Falha ao copiar o arquivo. Verifique permissões."
        ;;
    1|*)
        SCRIPT_NAME="SysView-en.sh"
        DEST_CMD="sysviewen"
        INSTALLING="🔧 Installing SysView in English..."
        NOT_FOUND="❌ File $SCRIPT_NAME not found!"
        COPYING="📂 Copying to /usr/local/bin/$DEST_CMD (requires sudo)..."
        SUCCESS="✅ SysView in English installed successfully!"
        USAGE="💡 You can now use the command: $DEST_CMD"
        FAIL="❌ Failed to copy the file. Check your permissions."
        ;;
esac

DEST_PATH="/usr/local/bin/$DEST_CMD"

# ========== INSTALAÇÃO ==========
echo -e "${log_prefix}${INSTALLING}"
sleep 1

if [ ! -f "$SCRIPT_NAME" ]; then
    echo -e "${log_prefix}${NOT_FOUND}"
    exit 1
fi

chmod +x "$SCRIPT_NAME"

echo -e "${log_prefix}${COPYING}"
sudo cp "$SCRIPT_NAME" "$DEST_PATH"

if [ $? -eq 0 ]; then
    echo -e "${log_prefix}${SUCCESS}"
    sleep 1
    echo -e "${log_prefix}${USAGE}"
else
    echo -e "${log_prefix}${FAIL}"
fi
