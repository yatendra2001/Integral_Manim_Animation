#!/bin/bash

echo "Running the Difficult Integral Animation directly (no virtual environment)"
echo "Make sure you have installed the dependencies using direct_install.sh"

# Add LaTeX to PATH if it exists in the standard location but isn't in PATH
if [ -d "/Library/TeX/texbin" ] && ! command -v latex &> /dev/null; then
    echo "Adding LaTeX to PATH..."
    export PATH="/Library/TeX/texbin:$PATH"
fi

# Check for LaTeX now
if ! command -v latex &> /dev/null; then
    echo "ERROR: LaTeX is not installed or not in your PATH."
    echo "Please install LaTeX first. On macOS, run:"
    echo "brew install --cask mactex-no-gui"
    echo "Then restart your terminal or run: export PATH=\"/Library/TeX/texbin:\$PATH\""
    exit 1
fi

echo "Using LaTeX from: $(which latex)"

# Check if we can import manim
if ! python3 -c "import manim" &> /dev/null; then
    echo "ERROR: manim is not installed or not importable in Python."
    echo "Please run ./direct_install.sh first to install dependencies."
    exit 1
fi

# Try running with python module syntax first
echo "Running animation with Python module syntax..."
python3 -m manim -pqh integral_animation.py DifficultIntegral

# If that fails, try using a different approach
if [ $? -ne 0 ]; then
    echo "First attempt failed. Trying with LaTeX template fix..."
    
    # Try to fix LaTeX template issues
    if [ -f "./fix_latex_engine.py" ]; then
        echo "Applying LaTeX engine fix..."
        python3 ./fix_latex_engine.py
        
        echo "Running again with fixed template..."
        python3 -m manim -pqh integral_animation.py DifficultIntegral
    else
        echo "Could not find fix_latex_engine.py. Proceeding with alternative method."
    fi
    
    # If still failing, try the alternative method
    if [ $? -ne 0 ]; then
        echo "Template fix didn't work. Trying alternative method..."
        echo "Checking manim installation path..."
        
        # Find where manim is installed
        MANIM_PATH=$(python3 -c "import manim; print(manim.__path__[0])")
        echo "Manim is installed at: $MANIM_PATH"
        
        # Try running with the full module path
        echo "Running with explicit module path..."
        python3 -m manim.cli.render integral_animation.py DifficultIntegral -pqh
    fi
fi

# If still unsuccessful, check for common errors
if [ $? -ne 0 ]; then
    echo ""
    echo "Animation failed to run. Here are some things to check:"
    echo "1. Make sure you have installed all dependencies with ./direct_install.sh"
    echo "2. Check if you can import manim in Python:"
    echo "   python3 -c 'import manim'"
    echo "3. Check if LaTeX is properly installed:"
    echo "   latex --version"
    echo "4. Check LaTeX formula syntax in the code (may need to use MathTex instead of Tex)"
    echo "5. Try installing a different LaTeX distribution:"
    echo "   brew install --cask basictex"
    echo "6. Check the error messages above for specific issues"
    echo "7. See INSTALL.md for detailed troubleshooting"
fi 