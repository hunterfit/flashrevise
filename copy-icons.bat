@echo off
REM ============================================================
REM copy-icons.bat — Copie les icônes générées vers Android/iOS
REM À lancer APRÈS setup.bat (après cap add android/ios)
REM ============================================================

echo === Copie des icônes Android ===

set SRC=android-config\app\src\main\res
set DST=android\app\src\main\res

for %%D in (mipmap-mdpi mipmap-hdpi mipmap-xhdpi mipmap-xxhdpi mipmap-xxxhdpi mipmap-anydpi-v26) do (
    if exist "%SRC%\%%D" (
        xcopy /E /I /Y "%SRC%\%%D" "%DST%\%%D" >nul
        echo   [OK] %%D copié
    )
)

echo === Icônes Android copiées ===
echo.

REM Copie des icônes iOS (si la plateforme iOS a été ajoutée)
if exist "ios\App\App\Assets.xcassets\AppIcon.appiconset" (
    echo === Copie des icônes iOS ===
    xcopy /E /I /Y "ios-icons\*" "ios\App\App\Assets.xcassets\AppIcon.appiconset\" >nul
    echo   [OK] Icônes iOS copiées
    echo === Icônes iOS copiées ===
) else (
    echo [INFO] Plateforme iOS non trouvée - ignore la copie iOS
    echo        Lance d'abord : npx cap add ios
)

echo.
echo === Terminé ! ===
pause
