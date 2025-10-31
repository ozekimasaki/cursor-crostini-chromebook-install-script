# Cursor AI Editor Installation Script for Crostini

This script automates the installation of [Cursor AI Editor](https://www.cursor.com/) on Crostini (Chrome OS Linux containers). Cursor is an AI-powered code editor built on VS Code that provides intelligent code completion, AI-assisted programming, and natural language code editing.

## 🚀 Quick Install

```bash
# Download the script
wget https://raw.githubusercontent.com/ozekimasaki/cursor-crostini-chromebook-install-script/main/install-cursor-crostini.sh

# Make it executable
chmod +x install-cursor-crostini.sh

# Run the installer
./install-cursor-crostini.sh
```

### One-liner Installation
```bash
curl -fsSL https://raw.githubusercontent.com/ozekimasaki/cursor-crostini-chromebook-install-script/main/install-cursor-crostini.sh | bash
```

## 📋 Prerequisites

- **Chrome OS** with Linux (Crostini) enabled
- **x86_64 or arm64 (aarch64) architecture** (most Chromebooks)
- **Internet connection** for downloading Cursor
- **Sudo access** in your Linux container

## ✨ What This Script Does

1. **System Check**: Verifies compatibility with Debian-based systems and detects architecture (x86_64 or arm64)
2. **Dependencies**: Installs required packages (FUSE, libfuse2, wget, curl)
3. **Download**: Fetches the latest Cursor AppImage from official sources
4. **Installation**: Places Cursor in `~/.local/bin/cursor.AppImage` with auto-update capability
5. **Icon Setup**: Extracts and installs the official Cursor icon
6. **Desktop Integration**: Creates a desktop entry for easy launching
7. **Verification**: Confirms successful installation

## 🎯 After Installation

Once installed, you can:

- **Launch from Applications Menu**: Find Cursor in the "Development" category
- **Run from Terminal**: Execute `~/.local/bin/cursor.AppImage` (or add `~/.local/bin` to your PATH)
- **Open Files**: Right-click text files and "Open with Cursor" (if configured)

## 📁 Installation Locations

- **Executable**: `~/.local/bin/cursor.AppImage`
- **Desktop Entry**: `~/.local/share/applications/cursor.desktop`
- **Icon**: `~/.local/share/icons/cursor.png`

## 🔧 Manual Installation Steps

If you prefer to install manually, here are the steps the script automates:

<details>
<summary>Click to expand manual steps</summary>

### 1. Install Dependencies
```bash
sudo apt update
sudo apt install -y fuse libfuse2 wget curl
```

### 2. Get Latest Version Info
```bash
# For x86_64
curl -s "https://www.cursor.com/api/download?platform=linux-x64&releaseTrack=stable"

# For arm64
curl -s "https://www.cursor.com/api/download?platform=linux-arm64&releaseTrack=stable"
```

### 3. Download Cursor
```bash
# Use the downloadUrl from the API response
wget "DOWNLOAD_URL_FROM_API" -O cursor.AppImage
```

### 4. Install to User Directory
```bash
mkdir -p ~/.local/bin
mv cursor.AppImage ~/.local/bin/cursor.AppImage
chmod +x ~/.local/bin/cursor.AppImage
```

### 5. Extract Icon
```bash
~/.local/bin/cursor.AppImage --appimage-extract usr/share/icons/hicolor/128x128/apps/cursor.png
mkdir -p ~/.local/share/icons
cp squashfs-root/usr/share/icons/hicolor/128x128/apps/cursor.png ~/.local/share/icons/cursor.png
rm -rf squashfs-root
```

### 6. Create Desktop Entry
```bash
mkdir -p ~/.local/share/applications
cat > ~/.local/share/applications/cursor.desktop << 'EOF'
[Desktop Entry]
Name=Cursor
Comment=AI-first code editor
Exec=/home/$(whoami)/.local/bin/cursor.AppImage
Icon=/home/$(whoami)/.local/share/icons/cursor.png
Type=Application
Categories=Development;TextEditor;
StartupNotify=true
MimeType=text/plain;text/x-chdr;text/x-csrc;text/x-c++hdr;text/x-c++src;text/x-java;text/x-dsrc;text/x-pascal;text/x-perl;text/x-python;application/x-php;application/x-httpd-php3;application/x-httpd-php4;application/x-httpd-php5;application/javascript;application/json;text/css;text/html;text/xml;text/x-sql;text/x-ruby;
EOF
update-desktop-database ~/.local/share/applications
```

</details>

## 🛠️ Troubleshooting

### Common Issues

**Script fails with "FUSE not available"**
- The script should automatically install FUSE, but if it fails:
```bash
sudo apt update
sudo apt install -y fuse libfuse2
```

**Cursor doesn't appear in applications menu**
- Try refreshing your applications: `update-desktop-database ~/.local/share/applications`
- Log out and back in to refresh the desktop environment
- Check if the desktop file exists: `ls ~/.local/share/applications/cursor.desktop`

**Permission denied when running AppImage**
- Make sure the file is executable: `chmod +x ~/.local/bin/cursor.AppImage`

**Download fails**
- Check your internet connection
- Try running the script again (it will fetch the latest version)

**GPU/Graphics errors when launching**
- These are usually harmless warnings in Crostini environments
- Cursor should still function normally

### Getting Help

If you encounter issues:

1. **Check the output**: The script provides colored status messages
2. **Verify installation**: Run `~/.local/bin/cursor.AppImage --version` to test
3. **Manual cleanup**: If needed, remove files and try again:
   ```bash
   rm -f ~/.local/bin/cursor.AppImage
   rm -f ~/.local/share/applications/cursor.desktop
   rm -f ~/.local/share/icons/cursor.png
   ```

## 🔄 Updating Cursor

**Cursor automatically updates itself!** 

Since Cursor is installed in your user directory (`~/.local/bin/`), it can update itself without requiring scripts or sudo access.

**To check for updates:**
1. Open Cursor
2. Go to **Help** → **Check for Updates**
3. Or use **Ctrl+Shift+P** and search for "Update"

**Manual update (if needed):**
If auto-update doesn't work, simply reinstall:

```bash
./install-cursor-crostini.sh
```

The installer always downloads the latest version available.

## 🗑️ Uninstalling

### Quick Uninstall
```bash
# Download the uninstall script
wget https://raw.githubusercontent.com/ozekimasaki/cursor-crostini-chromebook-install-script/main/uninstall-cursor-crostini.sh

# Make it executable
chmod +x uninstall-cursor-crostini.sh

# Run the uninstaller
./uninstall-cursor-crostini.sh
```

### One-liner Uninstallation
```bash
curl -fsSL https://raw.githubusercontent.com/ozekimasaki/cursor-crostini-chromebook-install-script/main/uninstall-cursor-crostini.sh | bash
```

The uninstall script will:
- Remove the Cursor AppImage from `~/.local/bin/cursor.AppImage`
- Remove the desktop entry and icon
- Optionally remove user settings and data (with confirmation)
- Verify complete removal

### Manual Uninstallation
If you prefer to uninstall manually:

```bash
# Remove the application
rm -f ~/.local/bin/cursor.AppImage

# Remove desktop integration
rm -f ~/.local/share/applications/cursor.desktop
rm -f ~/.local/share/icons/cursor.png

# Update desktop database
update-desktop-database ~/.local/share/applications

# Optionally remove user data
rm -rf ~/.config/cursor
rm -rf ~/.cache/cursor
```

## 📝 Script Features

- ✅ **Automatic architecture detection** (x86_64 and arm64)
- ✅ **Automatic latest version detection**
- ✅ **System compatibility checking**
- ✅ **Dependency management**
- ✅ **Official icon extraction**
- ✅ **Auto-update capability (user installation)**
- ✅ **Error handling and cleanup**
- ✅ **Colored output for clarity**
- ✅ **Installation verification**

## 🤝 Contributing

Feel free to submit issues or improvements to this installation script. The script is designed to be robust and handle various edge cases that might occur during installation.

## 📄 License

This installation script is provided under the GPL v3 or later license. Cursor AI Editor itself is proprietary software by Anysphere Inc.

## ⚠️ Disclaimer

This is an unofficial installation script. Cursor AI Editor is developed by Anysphere Inc. This script simply automates the installation process for Crostini users.

---

**Made with ❤️ for the Chrome OS + Linux development community**