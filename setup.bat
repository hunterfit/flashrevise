@echo off
echo ============================================
echo   FlashRevise — Installation Capacitor
echo ============================================
echo.

REM Verifier Node.js
node --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERREUR] Node.js n'est pas installe.
    echo Telecharge-le sur https://nodejs.org (version LTS recommandee)
    pause
    exit /b 1
)

echo [OK] Node.js detecte
node --version

REM Installer les dependances
echo.
echo [1/4] Installation des dependances npm...
npm install

REM Ajouter Android
echo.
echo [2/4] Ajout de la plateforme Android...
npx cap add android

REM Sync
echo.
echo [3/4] Synchronisation des fichiers web...
npx cap sync android

REM Generer les icones et splash avec un outil si disponible
echo.
echo [4/4] Preparation terminee !
echo.
echo ============================================
echo   Prochaines etapes :
echo ============================================
echo.
echo  ANDROID (Play Store) :
echo  1. Ouvre Android Studio
echo  2. File > Open > selectionne le dossier 'android'
echo  3. Attends le build Gradle
echo  4. Build > Generate Signed Bundle/APK
echo  5. Uploade le .aab sur Google Play Console
echo.
echo  iOS (App Store) - via Codemagic cloud :
echo  Consulte le fichier GUIDE_PUBLICATION.md
echo.
pause
