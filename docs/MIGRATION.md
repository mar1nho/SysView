# 🔄 Migration Guide / Guia de Migração

## Migrating to v0.2 / Migrando para v0.2

Version 0.2 introduces a new directory structure to better organize the project.

A versão 0.2 introduz uma nova estrutura de diretórios para melhor organizar o projeto.

## What Changed / O que Mudou

### Directory Structure / Estrutura de Diretórios

**Before (v0.1) / Antes (v0.1):**
```
SysView/
├── SysView-pt.sh
├── SysView-en.sh
├── install.sh
└── README.md
```

**After (v0.2) / Depois (v0.2):**
```
SysView/
├── src/
│   ├── sysview-pt.sh
│   ├── sysview-en.sh
│   ├── distro-detect.sh
│   └── install.sh
├── docs/
│   └── TESTING.md
├── install.sh (updated / atualizado)
├── README.md
├── CONTRIBUTING.md
└── CHANGELOG.md
```

## For Users / Para Usuários

If you have already installed SysView v0.1, you can upgrade to v0.2 by:

Se você já instalou o SysView v0.1, pode atualizar para v0.2:

```bash
cd SysView
git pull
bash install.sh
```

The installer will work with both the old and new structure, so your existing installation will continue to work.

O instalador funciona com as estruturas antiga e nova, então sua instalação existente continuará funcionando.

## For Contributors / Para Contribuidores

### Where to Edit Files / Onde Editar Arquivos

- ✅ Edit scripts in `src/` directory / Edite scripts no diretório `src/`
- ✅ Add documentation to `docs/` / Adicione documentação em `docs/`
- ❌ Do not edit root directory scripts (they are kept for backward compatibility) / Não edite scripts no diretório raiz (mantidos para compatibilidade)

### Deprecated Files / Arquivos Obsoletos

The following files in the root directory are kept for backward compatibility but should not be edited:

Os seguintes arquivos no diretório raiz são mantidos para compatibilidade mas não devem ser editados:

- `SysView-pt.sh` (use `src/sysview-pt.sh` instead / use `src/sysview-pt.sh` no lugar)
- `SysView-en.sh` (use `src/sysview-en.sh` instead / use `src/sysview-en.sh` no lugar)

**Note:** These files may be removed in a future version (v0.3 or later).

**Nota:** Estes arquivos podem ser removidos em uma versão futura (v0.3 ou posterior).

## Breaking Changes / Mudanças Incompatíveis

**None!** / **Nenhuma!**

Version 0.2 is fully backward compatible with v0.1. The install.sh script checks both the new (`src/`) and old (root) locations for scripts.

A versão 0.2 é totalmente compatível com v0.1. O script install.sh verifica tanto os locais novos (`src/`) quanto antigos (raiz) para os scripts.

## New Features / Novos Recursos

### Multi-Distribution Support / Suporte Multi-Distribuição

The biggest change in v0.2 is support for multiple Linux distributions:

A maior mudança na v0.2 é o suporte a múltiplas distribuições Linux:

- Debian/Ubuntu (apt)
- Arch Linux (pacman) ⭐ NEW / NOVO
- Fedora (dnf) ⭐ NEW / NOVO
- CentOS/RHEL (yum) ⭐ NEW / NOVO
- openSUSE (zypper) ⭐ NEW / NOVO

### Automatic Package Manager Detection / Detecção Automática do Gerenciador de Pacotes

The scripts now automatically detect which package manager to use when installing dependencies like `speedtest-cli`.

Os scripts agora detectam automaticamente qual gerenciador de pacotes usar ao instalar dependências como `speedtest-cli`.

## Questions? / Dúvidas?

If you have questions about the migration, please open an issue on GitHub.

Se você tiver dúvidas sobre a migração, por favor abra uma issue no GitHub.
