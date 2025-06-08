#!/bin/bash

# Cursor AI Editor Uninstallation Script for Crostini (Chrome OS Linux)
# This script removes Cursor text editor from Crostini
# Author: Generated with Claude Code
# License: MIT

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to remove Cursor AppImage
remove_cursor_appimage() {
    print_status "Removing Cursor AppImage..."
    
    if [[ -f /opt/cursor.AppImage ]]; then
        sudo rm -f /opt/cursor.AppImage
        print_success "Cursor AppImage removed from /opt/cursor.AppImage"
    else
        print_warning "Cursor AppImage not found at /opt/cursor.AppImage"
    fi
}

# Function to remove desktop entry
remove_desktop_entry() {
    print_status "Removing desktop entry..."
    
    if [[ -f ~/.local/share/applications/cursor.desktop ]]; then
        rm -f ~/.local/share/applications/cursor.desktop
        print_success "Desktop entry removed"
        
        # Update desktop database
        update-desktop-database ~/.local/share/applications 2>/dev/null || true
    else
        print_warning "Desktop entry not found"
    fi
}

# Function to remove icon
remove_icon() {
    print_status "Removing Cursor icon..."
    
    if [[ -f ~/.local/share/icons/cursor.png ]]; then
        rm -f ~/.local/share/icons/cursor.png
        print_success "Cursor icon removed"
    else
        print_warning "Cursor icon not found"
    fi
}

# Function to remove user data (optional, with confirmation)
remove_user_data() {
    local cursor_config_dir="$HOME/.config/cursor"
    local cursor_cache_dir="$HOME/.cache/cursor"
    
    if [[ -d "$cursor_config_dir" ]] || [[ -d "$cursor_cache_dir" ]]; then
        echo
        print_warning "Cursor user data directories found:"
        [[ -d "$cursor_config_dir" ]] && echo "  • $cursor_config_dir"
        [[ -d "$cursor_cache_dir" ]] && echo "  • $cursor_cache_dir"
        echo
        read -p "Do you want to remove user data and settings? (y/N): " -n 1 -r
        echo
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_status "Removing user data..."
            
            [[ -d "$cursor_config_dir" ]] && rm -rf "$cursor_config_dir" && print_success "Config directory removed"
            [[ -d "$cursor_cache_dir" ]] && rm -rf "$cursor_cache_dir" && print_success "Cache directory removed"
        else
            print_status "User data preserved"
        fi
    else
        print_status "No user data directories found"
    fi
}

# Function to verify uninstallation
verify_uninstallation() {
    print_status "Verifying uninstallation..."
    
    local issues=0
    
    if [[ -f /opt/cursor.AppImage ]]; then
        print_error "Cursor AppImage still exists at /opt/cursor.AppImage"
        ((issues++))
    fi
    
    if [[ -f ~/.local/share/applications/cursor.desktop ]]; then
        print_error "Desktop entry still exists"
        ((issues++))
    fi
    
    if [[ -f ~/.local/share/icons/cursor.png ]]; then
        print_error "Icon still exists"
        ((issues++))
    fi
    
    if [[ $issues -eq 0 ]]; then
        print_success "Uninstallation verification passed"
        return 0
    else
        print_error "Uninstallation verification failed ($issues issues found)"
        return 1
    fi
}

# Function to show completion message
show_completion() {
    echo
    print_success "🗑️  Cursor uninstallation completed!"
    echo
    echo -e "${GREEN}Removed:${NC}"
    echo "  • Cursor AppImage (/opt/cursor.AppImage)"
    echo "  • Desktop entry (~/.local/share/applications/cursor.desktop)"
    echo "  • Application icon (~/.local/share/icons/cursor.png)"
    echo
    print_warning "Note: You may need to refresh your applications menu"
    print_warning "User settings and data may have been preserved if you chose to keep them"
}

# Main uninstallation function
main() {
    echo
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                Cursor AI Editor Uninstaller                 ║${NC}"
    echo -e "${BLUE}║                     for Crostini (Chrome OS)                ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo
    
    # Check if Cursor is installed
    if [[ ! -f /opt/cursor.AppImage ]] && [[ ! -f ~/.local/share/applications/cursor.desktop ]]; then
        print_warning "Cursor does not appear to be installed"
        echo
        read -p "Continue with cleanup anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_status "Uninstallation cancelled"
            exit 0
        fi
    fi
    
    # Check for sudo access if AppImage exists
    if [[ -f /opt/cursor.AppImage ]]; then
        if ! sudo -n true 2>/dev/null; then
            print_status "This script requires sudo access to remove the system-installed AppImage"
            print_status "You may be prompted for your password"
            sudo true
        fi
    fi
    
    # Run uninstallation steps
    remove_cursor_appimage
    remove_desktop_entry
    remove_icon
    remove_user_data
    
    if verify_uninstallation; then
        show_completion
    else
        print_error "Uninstallation completed with issues. Some files may need manual removal."
        exit 1
    fi
}

# Run the main function
main "$@"