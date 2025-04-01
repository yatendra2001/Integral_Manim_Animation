#!/bin/bash

# Function to check system dependencies
check_dependencies() {
    echo "Checking system dependencies..."
    
    # Check for pkg-config
    if ! command -v pkg-config &> /dev/null; then
        echo "Error: pkg-config is not installed."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo "On macOS, install it with: brew install pkg-config"
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            echo "On Ubuntu/Debian, install it with: sudo apt install pkg-config"
            echo "On Fedora, install it with: sudo dnf install pkgconfig"
            echo "On Arch, install it with: sudo pacman -S pkgconf"
        fi
        return 1
    fi
    
    # Check for Cairo
    if ! pkg-config --exists cairo; then
        echo "Error: Cairo is not installed or not found by pkg-config."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo "On macOS, install it with: brew install cairo"
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            echo "On Ubuntu/Debian, install it with: sudo apt install libcairo2-dev"
            echo "On Fedora, install it with: sudo dnf install cairo-devel"
            echo "On Arch, install it with: sudo pacman -S cairo"
        fi
        return 1
    fi
    
    # Check for Pango
    if ! pkg-config --exists pango; then
        echo "Error: Pango is not installed or not found by pkg-config."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo "On macOS, install it with: brew install pango"
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            echo "On Ubuntu/Debian, install it with: sudo apt install libpango1.0-dev"
            echo "On Fedora, install it with: sudo dnf install pango-devel"
            echo "On Arch, install it with: sudo pacman -S pango"
        fi
        return 1
    fi
    
    # Check for FFmpeg
    if ! command -v ffmpeg &> /dev/null; then
        echo "Error: FFmpeg is not installed."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo "On macOS, install it with: brew install ffmpeg"
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            echo "On Ubuntu/Debian, install it with: sudo apt install ffmpeg"
            echo "On Fedora, install it with: sudo dnf install ffmpeg"
            echo "On Arch, install it with: sudo pacman -S ffmpeg"
        fi
        return 1
    fi
    
    echo "All system dependencies found."
    return 0
}

# Check for Python 3
if ! command -v python3 &> /dev/null; then
    echo "Python 3 is not installed or not in your PATH. Please install Python 3 and try again."
    exit 1
fi

# Check system dependencies
if ! check_dependencies; then
    echo "Please install the missing dependencies and try again."
    echo "See the INSTALL.md file for detailed installation instructions."
    exit 1
fi

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Check if venv was created successfully
if [ ! -d "venv" ]; then
    echo "Failed to create virtual environment. Please check your Python installation."
    exit 1
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Check if activation was successful
if [ -z "$VIRTUAL_ENV" ]; then
    echo "Failed to activate virtual environment."
    exit 1
fi

# Install requirements
echo "Installing requirements..."
pip install --upgrade pip
pip install wheel  # Ensure wheel is installed for binary packages

# Try to install pycairo separately first (often a problematic dependency)
echo "Installing pycairo..."
pip install pycairo

# Now install the rest of the requirements
echo "Installing other dependencies..."
pip install -r requirements.txt

# Check if manim was installed successfully
if ! python -c "import manim" &> /dev/null; then
    echo "Manim installation failed. Trying direct installation..."
    pip install manim==0.17.3
    
    # Check again
    if ! python -c "import manim" &> /dev/null; then
        echo "Error: Manim installation failed."
        echo "Please see INSTALL.md for troubleshooting information."
        exit 1
    fi
fi

# Run the animation
echo "Running animation..."
python -m manim -pqh integral_animation.py DifficultIntegral

# If the above command fails, try with direct manim command
if [ $? -ne 0 ]; then
    echo "Trying alternative manim command..."
    manim -pqh integral_animation.py DifficultIntegral
fi

# Deactivate virtual environment
deactivate

echo "Animation complete. The video file should be in the media/videos/integral_animation/1080p60/ directory."
echo "If the animation wasn't generated, please check the error messages above and refer to INSTALL.md for help." 