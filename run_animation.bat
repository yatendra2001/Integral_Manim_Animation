@echo off
echo Difficult Integral Animation Setup and Run Script

REM Check if Python is installed
where python >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Python is not installed or not in your PATH.
    echo Please install Python from https://www.python.org/downloads/
    echo Be sure to check "Add Python to PATH" during installation.
    pause
    exit /b 1
)

REM Create virtual environment if it doesn't exist
if not exist venv (
    echo Creating virtual environment...
    python -m venv venv
)

REM Check if venv was created successfully
if not exist venv (
    echo Failed to create virtual environment.
    echo Please check your Python installation.
    pause
    exit /b 1
)

REM Activate virtual environment
echo Activating virtual environment...
call venv\Scripts\activate.bat

REM Install requirements
echo Installing requirements...
pip install -r requirements.txt

REM Run the animation
echo Running animation...
manim -pqh integral_animation.py DifficultIntegral

REM Deactivate virtual environment
deactivate

echo Animation complete. The video file is in the media\videos\integral_animation\1080p60\ directory.
pause 