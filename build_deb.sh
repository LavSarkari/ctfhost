#!/bin/bash

# ╔════════════════════════════════════╗
# ║    🧠  CTFHOST — Build Script      ║
# ╚════════════════════════════════════╝

set -e

# Package configuration
PACKAGE_NAME="ctfhost"
PACKAGE_VERSION="1.0"
PACKAGE_ARCH="all"
MAINTAINER="Lav Sarkari"
DESCRIPTION="CTF DNS manager for TryHackMe/HTB entries"

# Build directories
BUILD_DIR="build"
DIST_DIR="dist"
CONTROL_DIR="$BUILD_DIR/DEBIAN"
INSTALL_DIR="$BUILD_DIR/usr/local/bin"

# Colors for output
BOLD="\e[1m"
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[36m"
RESET="\e[0m"

function banner() {
    echo -e "${BOLD}${BLUE}╔═══════════════════════════════════════════════════╗"
    echo -e "║           🚀 CTFHOST — DEB BUILDER               ║"
    echo -e "╚═══════════════════════════════════════════════════╝${RESET}"
}

function cleanup() {
    echo -e "${YELLOW}[!] Cleaning up build directory...${RESET}"
    rm -rf "$BUILD_DIR"
}

function create_directories() {
    echo -e "${BLUE}[+] Creating build directories...${RESET}"
    mkdir -p "$CONTROL_DIR"
    chmod 755 "$CONTROL_DIR"
    mkdir -p "$INSTALL_DIR"
    mkdir -p "$DIST_DIR"
}


function copy_files() {
    echo -e "${BLUE}[+] Copying ctfhost script...${RESET}"
    cp "ctfhost" "$INSTALL_DIR/"
    chmod +x "$INSTALL_DIR/ctfhost"
}

function create_control_file() {
    echo -e "${BLUE}[+] Creating control file...${RESET}"
    cat > "$CONTROL_DIR/control" << EOF
Package: $PACKAGE_NAME
Version: $PACKAGE_VERSION
Architecture: $PACKAGE_ARCH
Maintainer: $MAINTAINER
Priority: optional
Section: utils
Description: $DESCRIPTION
 CTFHOST is a command-line tool for managing DNS entries
 for TryHackMe and HackTheBox CTF challenges. It provides
 easy commands to add, remove, list, and flush host entries
 for .thm and .htb domains in /etc/hosts.
 .
 Features:
  - Add host entries: ctfhost add <ip> <domain>
  - Remove entries: ctfhost rm <domain>
  - List entries: ctfhost list
  - Flush all entries: ctfhost flush
  - Direct usage: ctfhost <ip> <domain>
EOF
    chmod 644 "$CONTROL_DIR/control"
}

function build_deb() {
    echo -e "${BLUE}[+] Building Debian package...${RESET}"
    dpkg-deb --build "$BUILD_DIR" "$DIST_DIR/${PACKAGE_NAME}_${PACKAGE_VERSION}_${PACKAGE_ARCH}.deb"
}

function verify_deb() {
    echo -e "${BLUE}[+] Verifying package contents...${RESET}"
    dpkg-deb --contents "$DIST_DIR/${PACKAGE_NAME}_${PACKAGE_VERSION}_${PACKAGE_ARCH}.deb"
}

# Main build process
banner

# Check if ctfhost script exists
if [[ ! -f "ctfhost" ]]; then
    echo -e "${RED}[!] Error: ctfhost script not found in current directory${RESET}"
    exit 1
fi

# Check if dpkg-deb is available
if ! command -v dpkg-deb &> /dev/null; then
    echo -e "${RED}[!] Error: dpkg-deb not found. Please install dpkg-dev package.${RESET}"
    echo -e "${YELLOW}   On Ubuntu/Debian: sudo apt install dpkg-dev${RESET}"
    exit 1
fi

# Set up trap for cleanup
trap cleanup EXIT

# Build process
create_directories
copy_files
create_control_file
build_deb
verify_deb

echo -e "${GREEN}[✓] Build completed successfully!${RESET}"
echo -e "${GREEN}[✓] Package: $DIST_DIR/${PACKAGE_NAME}_${PACKAGE_VERSION}_${PACKAGE_ARCH}.deb${RESET}"
echo -e "${BLUE}[i] To install: sudo dpkg -i $DIST_DIR/${PACKAGE_NAME}_${PACKAGE_VERSION}_${PACKAGE_ARCH}.deb${RESET}" 