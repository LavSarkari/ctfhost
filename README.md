# 🧠 CTFHOST - CTF DNS Manager

> **A command-line tool for managing DNS entries for TryHackMe and HackTheBox CTF challenges**

[![Version](https://img.shields.io/badge/version-1.0-blue.svg)](https://github.com/lavsarkari/ctfhost)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Linux-lightgrey.svg)](https://www.linux.org/)

## 📋 Overview

CTFHOST is a lightweight Bash script designed to streamline DNS management for cybersecurity professionals and CTF enthusiasts. It provides an intuitive interface for managing host entries for `.thm` and `.htb` domains in your `/etc/hosts` file.

### ✨ Features

- **Quick DNS Management**: Add, remove, list, and flush host entries with simple commands
- **VPN Integration**: Automatically detects and displays your VPN IP address
- **Logging**: Maintains a log of all DNS operations for audit trails
- **Cross-Platform**: Works on any Linux distribution with standard tools
- **Zero Dependencies**: Pure Bash implementation with no external dependencies

## 🚀 Installation

### Option 1: [Debian Package](https://github.com/LavSarkari/ctfhost/releases/tag/v1.0) (Recommended)

```bash
# Download and install the .deb package
sudo dpkg -i ctfhost_1.0_all.deb

# If dependencies are missing, run:
sudo apt-get install -f
```

### Option 2: Manual Installation

```bash
# Clone or download the script
git clone https://github.com/lavsarkari/ctfhost.git
cd ctfhost

# Make executable and install
chmod +x ctfhost
sudo cp ctfhost /usr/local/bin/
```

### Option 3: Build from Source

```bash
# Build the Debian package
./build_deb.sh

# Install the generated package
sudo dpkg -i dist/ctfhost_1.0_all.deb
```

## 📖 Usage

### Basic Commands

```bash
# Add a host entry
ctfhost add <ip> <domain>

# Remove a host entry
ctfhost rm <domain>

# List all .thm/.htb entries
ctfhost list

# Flush all .thm/.htb entries
ctfhost flush
```

### Examples

```bash
# Add a TryHackMe machine
ctfhost add 10.10.148.147 login.thm

# Add a HackTheBox machine
ctfhost add 10.10.10.123 target.htb

# Remove a specific entry
ctfhost rm login.thm

# List current entries
ctfhost list

# Clear all CTF entries
ctfhost flush
```

### Direct Usage

You can also use the script directly without subcommands:

```bash
# Quick add (equivalent to: ctfhost add 10.10.148.147 login.thm)
ctfhost 10.10.148.147 login.thm
```

## 🔧 Configuration

### Log File

CTFHOST maintains a log file at `~/.addhost.log` containing timestamps and operations:

```bash
# View the log
cat ~/.addhost.log

# Example log entries:
# [2024-01-15 14:30:22] Added: 10.10.148.147 login.thm
# [2024-01-15 15:45:11] Removed: login.thm
```

### VPN Interface Detection

The script automatically detects your VPN IP from the following interfaces (in order):
1. `tun0` (OpenVPN)
2. `eth0` (Ethernet)
3. `wlan0` (Wireless)

## 🛠️ Development

### Building the Package

```bash
# Ensure you have dpkg-dev installed
sudo apt install dpkg-dev

# Build the Debian package
./build_deb.sh
```

### Project Structure

```
ctfhost/
├── ctfhost              # Main script
├── build_deb.sh         # Build script
├── README.md           # This file
└── dist/               # Generated packages
    └── ctfhost_1.0_all.deb
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Setup

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **TryHackMe** and **HackTheBox** for providing amazing CTF platforms
- The cybersecurity community for inspiration and feedback
- AI tools for helping with documentation (though the core functionality is all human-crafted! 😄)

## 📞 Support

If you encounter any issues or have questions:

- Open an issue on GitHub
- Check the log file at `~/.addhost.log`
- Ensure you have proper permissions for `/etc/hosts`

---

**Made with ❤️ by Lav Sarkari**

*For CTF enthusiasts, by CTF enthusiasts* 
