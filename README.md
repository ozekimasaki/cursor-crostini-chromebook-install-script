# Cursor AI Editor Installation Script for Crostini

This script automates the installation of [Cursor AI Editor](https://www.cursor.com/) on Crostini (Chrome OS Linux containers). Cursor is an AI-powered code editor built on VS Code that provides intelligent code completion, AI-assisted programming, and natural language code editing.

## 🚀 Quick Install

```bash
# Download the script
wget https://raw.githubusercontent.com/your-username/cursor-crostini-installer/main/install-cursor-crostini.sh

# Make it executable
chmod +x install-cursor-crostini.sh

# Run the installer
./install-cursor-crostini.sh
```

### One-liner Installation
```bash
curl -fsSL https://raw.githubusercontent.com/your-username/cursor-crostini-installer/main/install-cursor-crostini.sh | bash
```

## 📋 Prerequisites

- **Chrome OS** with Linux (Crostini) enabled
- **x86_64 architecture** (most Chromebooks)
- **Internet connection** for downloading Cursor
- **Sudo access** in your Linux container

## ✨ What This Script Does

1. **System Check**: Verifies compatibility with Debian-based systems and x86_64 architecture
2. **Dependencies**: Installs required packages (FUSE, libfuse2, wget, curl)
3. **Download**: Fetches the latest Cursor AppImage from official sources
4. **Installation**: Places Cursor in `/opt/cursor.AppImage` with proper permissions
5. **Icon Setup**: Extracts and installs the official Cursor icon
6. **Desktop Integration**: Creates a desktop entry for easy launching
7. **Verification**: Confirms successful installation

## 🎯 After Installation

Once installed, you can:

- **Launch from Applications Menu**: Find Cursor in the "Development" category
- **Run from Terminal**: Execute `/opt/cursor.AppImage`
- **Open Files**: Right-click text files and "Open with Cursor" (if configured)

## 📁 Installation Locations

- **Executable**: `/opt/cursor.AppImage`
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
curl -s "https://download.todesktop.com/230313mzl4w4u92/latest-linux.yml"
```

### 3. Download Cursor
```bash
wget "https://download.todesktop.com/230313mzl4w4u92/cursor-VERSION-x86_64.AppImage" -O cursor.AppImage
```

### 4. Install System-wide
```bash
sudo mv cursor.AppImage /opt/cursor.AppImage
sudo chmod +x /opt/cursor.AppImage
```

### 5. Extract Icon
```bash
/opt/cursor.AppImage --appimage-extract usr/share/icons/hicolor/128x128/apps/cursor.png
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
Exec=/opt/cursor.AppImage
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
- Make sure the file is executable: `sudo chmod +x /opt/cursor.AppImage`

**Download fails**
- Check your internet connection
- Try running the script again (it will fetch the latest version)

**GPU/Graphics errors when launching**
- These are usually harmless warnings in Crostini environments
- Cursor should still function normally

### Getting Help

If you encounter issues:

1. **Check the output**: The script provides colored status messages
2. **Verify installation**: Run `/opt/cursor.AppImage --version` to test
3. **Manual cleanup**: If needed, remove files and try again:
   ```bash
   sudo rm -f /opt/cursor.AppImage
   rm -f ~/.local/share/applications/cursor.desktop
   rm -f ~/.local/share/icons/cursor.png
   ```

## 🔄 Updating Cursor

To update to the latest version:

1. **Remove current installation**:
   ```bash
   sudo rm /opt/cursor.AppImage
   rm ~/.local/share/applications/cursor.desktop
   rm ~/.local/share/icons/cursor.png
   ```

2. **Run the installer again**:
   ```bash
   ./install-cursor-crostini.sh
   ```

The script always downloads the latest version available.

## 🗑️ Uninstalling

To completely remove Cursor:

```bash
# Remove the application
sudo rm -f /opt/cursor.AppImage

# Remove desktop integration
rm -f ~/.local/share/applications/cursor.desktop
rm -f ~/.local/share/icons/cursor.png

# Update desktop database
update-desktop-database ~/.local/share/applications
```

## 📝 Script Features

- ✅ **Automatic latest version detection**
- ✅ **System compatibility checking**
- ✅ **Dependency management**
- ✅ **Official icon extraction**
- ✅ **Error handling and cleanup**
- ✅ **Colored output for clarity**
- ✅ **Installation verification**

## 🤝 Contributing

Feel free to submit issues or improvements to this installation script. The script is designed to be robust and handle various edge cases that might occur during installation.

## 📄 License

This installation script is provided under the MIT License. Cursor AI Editor itself is proprietary software by Anysphere Inc.

## ⚠️ Disclaimer

This is an unofficial installation script. Cursor AI Editor is developed by Anysphere Inc. This script simply automates the installation process for Crostini users.

---

**Made with ❤️ for the Chrome OS + Linux development community**