# Changelog / Histórico de Mudanças

All notable changes to this project will be documented in this file.

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

## [0.2.0] - 2025-12-15

### Added / Adicionado
- ✨ Multi-distribution Linux support / Suporte a múltiplas distribuições Linux
  - Arch Linux (pacman)
  - Fedora (dnf)
  - CentOS/RHEL (yum)
  - openSUSE (zypper)
  - Debian/Ubuntu (apt) - already supported / já suportado
- 📁 Improved project structure with `src/` directory / Estrutura de projeto melhorada com diretório `src/`
- 📚 Added CONTRIBUTING.md with project structure documentation / Adicionado CONTRIBUTING.md com documentação da estrutura
- 📝 Added docs/TESTING.md for testing guidelines / Adicionado docs/TESTING.md com diretrizes de teste
- 🙈 Added .gitignore for cleaner repository / Adicionado .gitignore para repositório mais limpo
- 🔍 Automatic package manager detection / Detecção automática do gerenciador de pacotes

### Changed / Modificado
- 🔧 Updated `install.sh` to support new directory structure / Atualizado `install.sh` para suportar nova estrutura
- 🔧 Updated `install_requirements()` function to detect and use appropriate package manager / Atualizada função `install_requirements()` para detectar e usar o gerenciador apropriado
- 📖 Enhanced README.md with multi-distro support information / Melhorado README.md com informações de suporte multi-distro
- 🏷️ Version bumped to 0.2 / Versão atualizada para 0.2

### Technical / Técnico
- Scripts moved to `src/` directory while maintaining backward compatibility / Scripts movidos para diretório `src/` mantendo compatibilidade
- Added `detect_package_manager()` function in both language versions / Adicionada função `detect_package_manager()` em ambas versões
- Improved installation logic to search in both old and new locations / Melhorada lógica de instalação para buscar em locais antigos e novos

## [0.1.0] - 2025 (Initial Release / Lançamento Inicial)

### Features / Recursos
- 🖥️ System monitoring utility for Linux / Utilitário de monitoramento de sistema para Linux
- 🇧🇷 Portuguese language support / Suporte ao idioma português
- 🇬🇧 English language support / Suporte ao idioma inglês
- 💾 RAM usage monitoring / Monitoramento de uso de RAM
- 🧹 System cache clearing / Limpeza de cache do sistema
- 📊 Disk usage analysis / Análise de uso de disco
- 🌐 Internet connectivity check / Verificação de conectividade de internet
- ⚡ Internet speed test / Teste de velocidade de internet
- 🔐 File encryption with GPG / Criptografia de arquivos com GPG
- 🔓 File decryption with GPG / Descriptografia de arquivos com GPG
