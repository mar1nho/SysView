# 🤝 Contribuindo para o SysView / Contributing to SysView

## 📁 Estrutura do Projeto / Project Structure

```
SysView/
├── src/                    # Source code / Código fonte
│   ├── sysview-pt.sh      # Portuguese version / Versão em português
│   ├── sysview-en.sh      # English version / Versão em inglês
│   ├── distro-detect.sh   # Distribution detection utilities / Utilitários de detecção de distribuição
│   └── install.sh         # Installation script / Script de instalação
├── docs/                   # Documentation / Documentação
├── img_demo/              # Demo images / Imagens de demonstração
├── install.sh             # Main installer / Instalador principal
├── README.md              # Project readme / Leia-me do projeto
└── LICENSE                # MIT License / Licença MIT
```

## 🔧 Desenvolvimento / Development

### Estrutura de Diretórios / Directory Structure

- **`src/`**: Contém todos os scripts principais do projeto / Contains all main project scripts
- **`docs/`**: Documentação adicional / Additional documentation
- **`img_demo/`**: Imagens e capturas de tela / Images and screenshots

### Compatibilidade Multi-Distro / Multi-Distro Compatibility

O SysView agora suporta múltiplas distribuições Linux através de detecção automática do gerenciador de pacotes:

SysView now supports multiple Linux distributions through automatic package manager detection:

- **Debian/Ubuntu**: apt
- **Arch Linux**: pacman
- **Fedora**: dnf
- **CentOS/RHEL**: yum
- **openSUSE**: zypper

### Como Adicionar Suporte a Novas Distribuições / How to Add Support for New Distributions

Para adicionar suporte a uma nova distribuição, edite a função `detect_package_manager()` nos arquivos:
- `src/sysview-pt.sh`
- `src/sysview-en.sh`

To add support for a new distribution, edit the `detect_package_manager()` function in:
- `src/sysview-pt.sh`
- `src/sysview-en.sh`

## 🧪 Testando / Testing

Para testar localmente / To test locally:

```bash
# Clone o repositório / Clone the repository
git clone https://github.com/mar1nho/SysView.git
cd SysView

# Execute o instalador / Run the installer
bash install.sh

# Teste o comando / Test the command
sysviewpt  # ou/or sysviewen
```

## 📝 Diretrizes de Código / Code Guidelines

- Mantenha a compatibilidade com bash / Maintain bash compatibility
- Documente mudanças significativas / Document significant changes
- Teste em múltiplas distribuições quando possível / Test on multiple distributions when possible
- Mantenha mensagens em ambos os idiomas (PT/EN) / Keep messages in both languages (PT/EN)

## 🐛 Reportando Bugs / Reporting Bugs

Ao reportar bugs, inclua:
- Distribuição Linux e versão
- Saída do comando que falhou
- Logs de erro se disponíveis

When reporting bugs, include:
- Linux distribution and version
- Output of the failing command
- Error logs if available
