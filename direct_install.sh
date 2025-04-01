#!/bin/bash

echo "Direct Installation Script for Manim Integral Animation"
echo "This script will install dependencies directly without using a virtual environment."
echo "You may need to run it with sudo if installing to system directories."

# Check for Python 3
if ! command -v python3 &> /dev/null; then
    echo "Python 3 is not installed or not in your PATH. Please install Python 3 and try again."
    exit 1
fi

# Check for LaTeX
if ! command -v latex &> /dev/null; then
    echo "LaTeX is not installed or not in your PATH."
    
    # Check if MacTeX is installed but not in PATH
    if [ -d "/Library/TeX/texbin" ]; then
        echo "Found LaTeX installation at /Library/TeX/texbin, adding to PATH..."
        export PATH="/Library/TeX/texbin:$PATH"
    else
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo "Installing MacTeX using Homebrew..."
            brew install --cask mactex-no-gui
            # Add LaTeX to PATH for current session
            export PATH="/Library/TeX/texbin:$PATH"
            # Also add it to shell config for future sessions
            echo 'export PATH="/Library/TeX/texbin:$PATH"' >> ~/.zshrc
            echo 'export PATH="/Library/TeX/texbin:$PATH"' >> ~/.bash_profile
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            echo "Please install LaTeX using your package manager:"
            echo "Ubuntu/Debian: sudo apt install texlive texlive-latex-extra"
            echo "Fedora: sudo dnf install texlive-scheme-medium"
            echo "Arch: sudo pacman -S texlive-most"
            exit 1
        fi
    fi
    
    # Check if LaTeX is now available
    if ! command -v latex &> /dev/null; then
        echo "LaTeX installation failed or not in PATH."
        echo "Please install LaTeX manually and ensure it's in your PATH."
        echo "See INSTALL.md for instructions."
        exit 1
    fi
fi

# Check for pip
if ! command -v pip3 &> /dev/null; then
    echo "pip3 is not installed. Installing pip..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        python3 -m ensurepip
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt install python3-pip || sudo dnf install python3-pip || sudo pacman -S python-pip
    fi
    
    if ! command -v pip3 &> /dev/null; then
        echo "Failed to install pip. Please install it manually and try again."
        exit 1
    fi
fi

# Install system dependencies on macOS with Homebrew if available
if [[ "$OSTYPE" == "darwin"* ]] && command -v brew &> /dev/null; then
    echo "Installing system dependencies with Homebrew..."
    brew install cairo pkg-config pango ffmpeg || true
fi

# Display help for system dependencies
echo "Make sure you have these system dependencies installed:"
echo " - Cairo"
echo " - Pango"
echo " - pkg-config"
echo " - FFmpeg"
echo " - LaTeX (now checking: $(which latex))"
echo "See INSTALL.md for detailed installation instructions."

# Upgrade pip and install wheel
echo "Upgrading pip and installing wheel..."
pip3 install --upgrade pip
pip3 install wheel

# Install pycairo first (common source of issues)
echo "Installing pycairo..."
pip3 install pycairo

# Install key dependencies individually
echo "Installing key dependencies..."
pip3 install numpy==1.23.5
pip3 install Pillow==9.5.0
pip3 install pygments==2.15.1
pip3 install click==8.1.3
pip3 install decorator==5.1.1
pip3 install networkx==2.8.8
pip3 install tqdm==4.65.0

# Finally install manim
echo "Installing manim..."
pip3 install manim==0.17.3

# Test if manim was installed correctly
if python3 -c "import manim" &> /dev/null; then
    echo "Manim installed successfully!"
else
    echo "Warning: Manim installation may have issues. See error messages above."
fi

echo ""
echo "To run the animation, use:"
echo "python3 -m manim -pqh integral_animation.py DifficultIntegral"
echo "" 