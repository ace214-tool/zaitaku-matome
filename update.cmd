@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo ====================================
echo   zaitaku-matome Update ^& Push
echo ====================================
echo.

echo [1/3] git add .
git add .
if errorlevel 1 goto :error
echo OK.
echo.

echo [2/3] git commit
set /p COMMIT_MSG="Commit message (default: update): "
if "!COMMIT_MSG!"=="" set COMMIT_MSG=update
git commit -m "!COMMIT_MSG!"
if errorlevel 1 (
    echo No changes to commit, or commit failed.
    goto :push_anyway
)
echo OK.
echo.

:push_anyway
echo [3/3] git push
git push
if errorlevel 1 goto :error
echo.

echo ====================================
echo   SUCCESS! Deployed.
echo ====================================
echo Published at: https://ace214-tool.github.io/zaitaku-matome/
echo (Takes 1-3 minutes to reflect)
echo.
goto :end

:error
echo.
echo ====================================
echo   ERROR occurred.
echo ====================================
echo Check the message above.

:end
echo.
echo Press any key to close.
pause > nul
