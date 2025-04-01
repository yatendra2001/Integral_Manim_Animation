#!/bin/bash

echo "LaTeX Path Fix Script for Manim"
echo "This script will add LaTeX to your PATH if it's installed but not available."

# Add MacTeX to PATH
if [ -d "/Library/TeX/texbin" ]; then
    echo "Found LaTeX installation at /Library/TeX/texbin"
    
    # Add to current session
    export PATH="/Library/TeX/texbin:$PATH"
    echo "Added to current session PATH"
    
    # Check if already in shell config files
    ZSHRC_UPDATED=false
    BASH_PROFILE_UPDATED=false
    
    # Check zshrc if it exists
    if [ -f ~/.zshrc ]; then
        if grep -q "/Library/TeX/texbin" ~/.zshrc; then
            echo "Already in ~/.zshrc"
            ZSHRC_UPDATED=true
        else
            echo 'export PATH="/Library/TeX/texbin:$PATH"' >> ~/.zshrc
            echo "Added to ~/.zshrc"
            ZSHRC_UPDATED=true
        fi
    fi
    
    # Check bash_profile if it exists
    if [ -f ~/.bash_profile ]; then
        if grep -q "/Library/TeX/texbin" ~/.bash_profile; then
            echo "Already in ~/.bash_profile"
            BASH_PROFILE_UPDATED=true
        else
            echo 'export PATH="/Library/TeX/texbin:$PATH"' >> ~/.bash_profile
            echo "Added to ~/.bash_profile"
            BASH_PROFILE_UPDATED=true
        fi
    fi
    
    # Create files if they don't exist
    if [ "$ZSHRC_UPDATED" = false ]; then
        echo 'export PATH="/Library/TeX/texbin:$PATH"' >> ~/.zshrc
        echo "Created and updated ~/.zshrc"
    fi
    
    if [ "$BASH_PROFILE_UPDATED" = false ]; then
        echo 'export PATH="/Library/TeX/texbin:$PATH"' >> ~/.bash_profile
        echo "Created and updated ~/.bash_profile"
    fi
    
    # Test if LaTeX is now available
    if command -v latex &> /dev/null; then
        echo "SUCCESS: LaTeX is now available at: $(which latex)"
        echo "You can now run the animation with: ./direct_run.sh"
    else
        echo "WARNING: LaTeX still not in PATH for current session."
        echo "Please restart your terminal or run: export PATH=\"/Library/TeX/texbin:\$PATH\""
    fi
else
    echo "ERROR: LaTeX installation not found at the expected location (/Library/TeX/texbin)."
    echo "You may need to install LaTeX first with:"
    echo "brew install --cask mactex-no-gui"
    echo "Or see INSTALL.md for alternative installation methods."
fi 