@echo off
setlocal enabledelayedexpansion
echo === Python EXE Builder Tool ===
echo.
echo This tool will create a Python virtual environment and build an executable file from your Python script.
echo.
echo  [NOTES]
echo. 
echo  * The executable will be created with a hidden console window (--no console option)
echo  * You can choose between folder format or single-file (onefile) format
echo.
echo  [PREPARATION]
echo.
echo  1. Have the full path to your Python file ready (copy it to clipboard)
echo.
echo  2. This tool cannot automatically detect required libraries
echo     Please identify any additional packages your script needs beforehand
echo     We recommend using the Dependency Extractor tool:dependancy-extractor.py
echo     https://github.com/calico-blanket/dependency-extractor
echo.
echo  3. Optional: To customize the executable icon (ico format only):
echo     - Rename your icon file to "icon.ico"
echo     - Place it in the same directory as this batch file
echo.
echo When you're ready with the above, let's begin.

REM Get input information
echo.
echo === Starting Executable File Creation ===
echo.
echo.
set /p PROJECT_NAME=Enter project name (will be the executable name): 
echo.
set /p PYTHON_FILE=Enter the full path of the Python file to convert: 

REM Extract filename
for %%F in ("%PYTHON_FILE%") do set FILE_NAME=%%~nF

echo.
echo === 1. Creating Project Directory ===
mkdir %PROJECT_NAME%
cd %PROJECT_NAME%
echo Project directory created: %PROJECT_NAME%

REM Save current path for later display
set PROJECT_FULL_PATH=%CD%

echo.
echo === 2. Creating Virtual Environment ===
python -m venv .venv
echo Virtual environment created: .venv

echo.
echo === 3. Activating Virtual Environment ===
call .venv\Scripts\activate
echo Virtual environment activated

echo.
echo === 4. Installing PyInstaller ===
pip install pyinstaller
echo PyInstaller installed

echo.
echo === 5. Copying Python File ===
copy "%PYTHON_FILE%" "%FILE_NAME%.py"
echo Python file copied: %FILE_NAME%.py

echo.
echo === 6. Installing Additional Packages ===
REM Set dummy value
set ADDITIONAL_PACKAGES=NONE
echo If no additional libraries are required, just press Enter.
set /p ADDITIONAL_PACKAGES=Enter required packages (space-separated): 

REM Skip installation if "NONE"
if "%ADDITIONAL_PACKAGES%"=="NONE" (
    echo No additional packages will be installed
) else (
    pip install %ADDITIONAL_PACKAGES%
    echo Additional packages installed
)

REM Icon selection
echo.
echo === 7. Icon Configuration ===
set USE_ICON=n
set /p USE_ICON=Do you want to use a custom icon? (y or n, default:n): 

REM Set icon option
set ICON_OPTION=
if /i "%USE_ICON%"=="y" (
    if exist "%~dp0icon.ico" (
        echo Icon file found: icon.ico
        copy "%~dp0icon.ico" "icon.ico"
        if exist "icon.ico" (
            set ICON_OPTION=--icon=icon.ico
            echo Custom icon will be used
        ) else (
            echo Copy failed. Using default icon.
        )
    ) else (
        echo Icon file "icon.ico" not found.
        echo Using default icon.
    )
) else (
    echo Using default icon.
)

REM Output format selection
echo.
echo === 8. Executable Format Selection ===
set ONEFILE_OPT=0
echo Select the output format:
echo  1 - Single file format (easier to distribute, slower startup)
echo  2 - Folder format (faster startup, entire folder needed for distribution)
set /p ONEFILE_OPT=Select (1 or 2, default:2): 

REM Set format option based on selection
if "%ONEFILE_OPT%"=="1" (
    echo Creating in single file format.
    set FORMAT_OPTION=--onefile
    set IS_ONEFILE=yes
) else (
    echo Creating in folder format.
    set FORMAT_OPTION=
    set IS_ONEFILE=no
)

echo.
echo === 9. Building Executable ===
echo Command: pyinstaller --noconsole %ICON_OPTION% %FORMAT_OPTION% --name=%PROJECT_NAME% %FILE_NAME%.py
pyinstaller --noconsole %ICON_OPTION% %FORMAT_OPTION% --name=%PROJECT_NAME% %FILE_NAME%.py

REM Adjust output message based on format
if "%IS_ONEFILE%"=="yes" (
    echo Executable created: dist\%PROJECT_NAME%.exe
) else (
    echo Executable created: dist\%PROJECT_NAME%\%PROJECT_NAME%.exe
)

echo.
echo === Setup Complete ===
echo Project folder: %PROJECT_FULL_PATH%
echo.
echo Created files:
echo - Virtual environment: .venv
echo - Main file: %FILE_NAME%.py
echo.
if "%IS_ONEFILE%"=="yes" (
    echo Executable location: %PROJECT_FULL_PATH%\dist\%PROJECT_NAME%.exe
    echo.
    echo Note: Single file format - only the .exe file needs to be distributed
) else (
    echo Executable location: %PROJECT_FULL_PATH%\dist\%PROJECT_NAME%\%PROJECT_NAME%.exe
    echo.
    echo Note: Folder format - the entire dist\%PROJECT_NAME% folder must be distributed
)
echo.

pause
endlocal