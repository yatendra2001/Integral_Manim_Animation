# Difficult Integral Animation

This project uses Manim to create an animation explaining the integral:
\[\int\_{0}^{\infty} \frac{x^3}{e^x - 1} \, dx = \frac{\pi^4}{15}\]

The animation visually demonstrates the steps of evaluating this challenging integral and explains the mathematical techniques used to arrive at the elegant result.

## Prerequisites

Before running this animation, you need to install:

1. Python 3.7+
2. **LaTeX** (CRITICAL - most common source of errors!)
3. Cairo and Pango graphics libraries
4. pkg-config
5. FFmpeg (for video creation)

**⚠️ IMPORTANT: LaTeX must be properly installed AND in your PATH! ⚠️**  
Most installation problems are related to LaTeX not being found.

**See the [Installation Guide](INSTALL.md) for detailed setup instructions for your operating system.**

## Quick Start

### Step 1: Fix LaTeX Path (macOS)

If you've installed LaTeX but it's not found when running the animation:

```bash
# Navigate to the project directory
cd difficult_integral_animation

# Make the script executable
chmod +x fix_latex_path.sh

# Fix LaTeX path
./fix_latex_path.sh
```

### Step 2: Install & Run

#### Method 1: Direct Installation (Recommended)

```bash
# Navigate to the project directory
cd difficult_integral_animation

# Make the scripts executable
chmod +x direct_install.sh
chmod +x direct_run.sh

# Install dependencies directly
./direct_install.sh

# Run the animation
./direct_run.sh
```

#### Method 2: Virtual Environment (Alternative)

```bash
# Navigate to the project directory
cd difficult_integral_animation

# Make the script executable
chmod +x run_animation.sh

# Run the animation
./run_animation.sh
```

#### Windows:

```bash
# Navigate to the project directory
cd difficult_integral_animation

# Run the animation using the batch file
run_animation.bat
```

## Manual Setup

If you prefer to set things up manually:

1. Create a virtual environment:

   ```bash
   python3 -m venv venv
   ```

2. Activate the virtual environment:

   ```bash
   # macOS/Linux
   source venv/bin/activate

   # Windows
   venv\Scripts\activate
   ```

3. Install the dependencies:

   ```bash
   pip install -r requirements.txt
   ```

4. Run the animation:
   ```bash
   manim -pqh integral_animation.py DifficultIntegral
   ```

## Animation Options

When running manually, you can use these flags with manim:

- `-p`: Play the animation once rendered
- `-q<h,m,l>`: Quality (h=high, m=medium, l=low)
- `-f`: Render specific frame number

## Troubleshooting

If you're having issues with installation or running the animation:

1. **LaTeX not found error** (Most common issue):

   - This is the #1 problem! LaTeX must be installed AND in your PATH
   - For macOS: Run `./fix_latex_path.sh` to fix PATH issues
   - Verify with: `which latex` and `latex --version`

2. **System dependencies**: Make sure Cairo, Pango, and pkg-config are installed.

3. **Direct installation**: If the virtual environment approach fails, try the direct installation method described above.

4. **Check your Python version**: Manim 0.17.3 works best with Python 3.7-3.9. You might encounter issues with Python 3.10+.

For detailed troubleshooting, refer to the [Installation Guide](INSTALL.md).
