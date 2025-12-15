# 🧪 Testing SysView

## Overview

This document describes how to test SysView across different Linux distributions.

## Automated Tests

### Syntax Check

Test all bash scripts for syntax errors:

```bash
bash -n install.sh
bash -n src/sysview-pt.sh
bash -n src/sysview-en.sh
bash -n src/distro-detect.sh
```

### Package Manager Detection

Test that the package manager is correctly detected:

```bash
# Source the script
source src/sysview-en.sh

# Test detection
pkg_mgr=$(detect_package_manager)
echo "Detected: $pkg_mgr"
```

Expected results by distribution:
- Debian/Ubuntu: `apt`
- Arch Linux: `pacman`
- Fedora: `dnf`
- CentOS 7/RHEL 7: `yum`
- openSUSE: `zypper`

## Manual Testing

### Installation Test

1. Clone the repository:
```bash
git clone https://github.com/mar1nho/SysView.git
cd SysView
```

2. Run the installer:
```bash
bash install.sh
```

3. Select your language (1 for English, 2 for Portuguese)

4. Verify installation:
```bash
which sysviewen  # or sysviewpt
```

### Feature Tests

#### RAM Usage Check
```bash
sysviewen  # or sysviewpt
# Select option 1
```

Expected: Display total, used, free, and available RAM

#### Internet Connection Check
```bash
sysviewen  # or sysviewpt
# Select option 4
```

Expected: Show connection status and latency to 8.8.8.8

#### SpeedTest Installation (Multi-distro)

Test on each supported distribution:

```bash
sysviewen  # or sysviewpt
# Select option 5
# If speedtest-cli is not installed, choose to install it
```

Expected behavior:
- Detect correct package manager
- Show package manager name
- Successfully install speedtest-cli using the correct command
- Run speed test

## Distribution-Specific Testing

### Arch Linux

```bash
# In Arch container/VM
pacman -Sy git base-devel
git clone https://github.com/mar1nho/SysView.git
cd SysView
bash install.sh
```

Verify:
- Installation succeeds
- `pacman` is detected as package manager
- speedtest-cli installs via pacman

### Fedora

```bash
# In Fedora container/VM
dnf install -y git
git clone https://github.com/mar1nho/SysView.git
cd SysView
bash install.sh
```

Verify:
- Installation succeeds
- `dnf` is detected as package manager
- speedtest-cli installs via dnf

### Ubuntu/Debian

```bash
# In Ubuntu/Debian container/VM
apt update && apt install -y git
git clone https://github.com/mar1nho/SysView.git
cd SysView
bash install.sh
```

Verify:
- Installation succeeds
- `apt` is detected as package manager
- speedtest-cli installs via apt

## Testing Checklist

- [ ] All scripts pass syntax check
- [ ] Installation works on the root directory
- [ ] Installation works from src/ subdirectory
- [ ] Package manager correctly detected on Arch Linux
- [ ] Package manager correctly detected on Fedora
- [ ] Package manager correctly detected on Ubuntu/Debian
- [ ] Portuguese version installs and runs
- [ ] English version installs and runs
- [ ] All menu options work correctly
- [ ] speedtest-cli installation works on all distributions
- [ ] File encryption/decryption works
- [ ] RAM usage display works
- [ ] Disk usage display works
- [ ] Internet connection check works
- [ ] Cache clearing works (requires sudo)

## Regression Testing

After any code changes, verify:

1. Backward compatibility with root directory scripts (SysView-pt.sh, SysView-en.sh)
2. New structure works (src/ directory)
3. Multi-distro detection still works
4. All core features still function

## CI/CD Recommendations

Suggested CI tests:
- Syntax validation for all .sh files
- Test package manager detection logic
- Test installation on Docker containers for each distro
- Verify executable permissions are set correctly
