@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

set LOGFILE=setup.log
echo ==================================== > %LOGFILE%
echo zaitaku-matome setup log >> %LOGFILE%
echo Date: %date% %time% >> %LOGFILE%
echo ==================================== >> %LOGFILE%
echo. >> %LOGFILE%

echo ====================================
echo   zaitaku-matome setup
echo ====================================
echo Log file: %cd%\%LOGFILE%
echo.

echo [Step 0] Checking environment...
echo [Step 0] Checking environment... >> %LOGFILE%
where git > nul 2>&1
if errorlevel 1 (
    echo ERROR: Git is not installed or not in PATH.
    echo ERROR: Git is not installed or not in PATH. >> %LOGFILE%
    goto :end
)
git --version
git --version >> %LOGFILE%
echo.

echo [Step 1] Cleaning up old .git folder if broken...
echo [Step 1] Cleaning up old .git folder if broken... >> %LOGFILE%
if exist .git (
    attrib -h -s .git /s /d > nul 2>&1
    rmdir /s /q .git
    if exist .git (
        echo WARNING: Could not fully remove .git folder. Trying to proceed anyway.
        echo WARNING: Could not fully remove .git folder. >> %LOGFILE%
    ) else (
        echo Old .git folder removed.
    )
) else (
    echo No old .git folder found. OK.
)
echo.

echo [Step 2] git init...
echo [Step 2] git init... >> %LOGFILE%
git init >> %LOGFILE% 2>&1
if errorlevel 1 ( echo ERROR on git init. See %LOGFILE% & goto :end )
echo OK.
echo.

echo [Step 3] git config...
echo [Step 3] git config... >> %LOGFILE%
git config user.email "acemisa86@gmail.com" >> %LOGFILE% 2>&1
git config user.name "ace214-tool" >> %LOGFILE% 2>&1
echo OK.
echo.

echo [Step 4] git add .
echo [Step 4] git add . >> %LOGFILE%
git add . >> %LOGFILE% 2>&1
if errorlevel 1 ( echo ERROR on git add. See %LOGFILE% & goto :end )
echo OK.
echo.

echo [Step 5] git commit...
echo [Step 5] git commit... >> %LOGFILE%
git commit -m "initial commit: zaitaku-matome v1.0" >> %LOGFILE% 2>&1
if errorlevel 1 ( echo ERROR on git commit. See %LOGFILE% & goto :end )
echo OK.
echo.

echo [Step 6] git branch -M main...
echo [Step 6] git branch -M main... >> %LOGFILE%
git branch -M main >> %LOGFILE% 2>&1
echo OK.
echo.

echo [Step 7] git remote add origin...
echo [Step 7] git remote add origin... >> %LOGFILE%
git remote remove origin >> %LOGFILE% 2>&1
git remote add origin https://github.com/ace214-tool/zaitaku-matome.git >> %LOGFILE% 2>&1
echo OK.
echo.

echo [Step 8] git push to GitHub...
echo This step may prompt for GitHub credentials.
echo [Step 8] git push... >> %LOGFILE%
git push -u origin main
set PUSH_RESULT=%errorlevel%
echo Push exit code: %PUSH_RESULT% >> %LOGFILE%
if %PUSH_RESULT% neq 0 (
    echo.
    echo ERROR: Push failed. Exit code: %PUSH_RESULT%
    echo Possible causes:
    echo  - GitHub repository not created yet
    echo  - Authentication failed
    echo  - Network issue
    goto :end
)

echo.
echo ====================================
echo   SUCCESS! Everything done.
echo ====================================
echo.
echo Next step: Enable GitHub Pages
echo Open this URL:
echo   https://github.com/ace214-tool/zaitaku-matome/settings/pages
echo.
echo Set "Source" to "main" branch and Save.
echo.
echo After a few minutes, your site will be live at:
echo   https://ace214-tool.github.io/zaitaku-matome/
echo.

:end
echo.
echo ====================================
echo This window will stay open. Press any key to close.
echo Log saved to: %cd%\%LOGFILE%
echo ====================================
pause > nul
