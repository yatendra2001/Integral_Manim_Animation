# Installation Guide

This guide will help you set up the necessary tools to run the Difficult Integral Animation.

## Prerequisites

### 1. Install Python 3

#### macOS

```bash
# Option 1: Using Homebrew
brew install python

# Option 2: Download from Python.org
# Visit https://www.python.org/downloads/ and download the macOS installer
```

### 2. Install system dependencies

#### macOS

```bash
# Using Homebrew
brew install cairo pkg-config pango ffmpeg
brew install --cask mactex-no-gui  # LaTeX for math rendering

# Alternative: If MacTeX is too large, you can use BasicTeX (smaller)
# brew install --cask basictex
```

**IMPORTANT: After installing LaTeX, you MUST add LaTeX to your PATH!**

```bash
# Add LaTeX to PATH for current terminal session
export PATH="/Library/TeX/texbin:$PATH"

# Verify LaTeX is available
latex --version
```

To permanently add LaTeX to your PATH, run our helper script:

```bash
./fix_latex_path.sh
```

Or manually add this line to your ~/.zshrc or ~/.bash_profile:

```bash
export PATH="/Library/TeX/texbin:$PATH"
```

#### Windows

- Download and install MiKTeX from https://miktex.org/download
- Install Cairo and Pango:
  1. Download MSYS2 from https://www.msys2.org/
  2. Run MSYS2 and type:
     ```bash
     pacman -S mingw-w64-x86_64-cairo mingw-w64-x86_64-pango
     ```
  3. Add the MSYS2 bin directory to your PATH (typically C:\msys64\mingw64\bin)
  4. Make sure MiKTeX binaries are in your PATH as well

#### Linux

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install libcairo2-dev pkg-config python3-dev libpango1.0-dev ffmpeg
sudo apt install texlive texlive-latex-extra texlive-fonts-extra texlive-latex-recommended texlive-science texlive-fonts-extra tipa

# Fedora
sudo dnf install cairo-devel pango-devel pkg-config python3-devel ffmpeg
sudo dnf install texlive-scheme-medium

# Arch
sudo pacman -S cairo pkgconf pango python-cairo ffmpeg
sudo pacman -S texlive-most
```

### 3. Install FFmpeg (for video rendering)

FFmpeg is already included in the system dependencies above.

## Running the Animation

After installing the prerequisites:

1. Navigate to the `difficult_integral_animation` directory in your terminal or command prompt
2. Make the scripts executable (Unix/macOS only):

   ```bash
   chmod +x run_animation.sh
   chmod +x direct_install.sh
   chmod +x direct_run.sh
   chmod +x fix_latex_path.sh
   chmod +x fix_latex_engine.py
   ```

3. Run the LaTeX path fix script first (macOS only):

   ```bash
   ./fix_latex_path.sh
   ```

4. Run the animation script:

   ```bash
   # macOS/Linux
   ./direct_run.sh

   # Windows (using Command Prompt)
   run_animation.bat
   ```

## Troubleshooting

### Common Issues:

1. **LaTeX not found errors**

   The most common issue is LaTeX not being in your PATH, even when installed.

   - MacOS: MacTeX installs to `/Library/TeX/texbin/`, but this path needs to be added to your PATH
   - Run the helper script: `./fix_latex_path.sh`
   - Or manually add the path: `export PATH="/Library/TeX/texbin:$PATH"`
   - Verify with: `which latex` or `latex --version`

2. **LaTeX formula compilation errors**

   If you see errors like "Missing $ inserted" or other LaTeX compilation issues:

   - Make sure you're using `MathTex()` instead of `Tex()` for mathematical formulas in the code
   - Try the LaTeX engine fix: `python3 ./fix_latex_engine.py`
   - If you modified the code, check your LaTeX syntax
   - Try a different LaTeX distribution like BasicTeX: `brew install --cask basictex`

3. **Cairo/Pango installation errors**

   - MacOS: Make sure you have installed the dependencies with `brew install cairo pkg-config pango`
   - Windows: Make sure you've added the MSYS2 bin directory to your PATH
   - Try installing pycairo separately: `pip install pycairo`

4. **"command not found: python3"**

   - Make sure Python 3 is installed and in your PATH
   - Try using `python` instead of `python3`

5. **Virtual environment creation fails**

   - Make sure you have the venv module: `python3 -m pip install --user virtualenv`

6. **LaTeX specific errors**

   - Ensure you have a full LaTeX distribution installed
   - For specific formula errors, check the LaTeX syntax in the animation file
   - Run: `kpsewhich article.cls` to verify LaTeX can find its packages
   - Check if you have all necessary LaTeX packages installed
