# 🚀 Guide de publication FlashRevise
## Play Store (Android) + App Store (iOS) — PC Windows

---

## ⏱ Temps estimé
| Étape | Durée |
|-------|-------|
| Installation des outils | 30 min |
| Build Android | 15 min |
| Soumission Play Store | 1h |
| Build iOS (Codemagic cloud) | 45 min |
| Soumission App Store | 2h |
| Validation Play Store | 1–3 jours |
| Validation App Store | 1–7 jours |

---

## PARTIE 1 — PRÉREQUIS

### 1.1 Installer Node.js
1. Va sur https://nodejs.org
2. Télécharge la version **LTS** (ex: 20.x)
3. Installe avec les options par défaut
4. Vérifie dans un terminal : `node --version` → doit afficher `v20.x.x`

### 1.2 Installer Android Studio
1. Va sur https://developer.android.com/studio
2. Télécharge et installe Android Studio
3. Au premier lancement, installe le **Android SDK** (cochés par défaut)
4. Dans SDK Manager, assure-toi d'avoir **Android 14 (API 34)** installé
5. Installe aussi un **émulateur** (optionnel, pour tester)

### 1.3 Créer un compte Google Play Developer
1. Va sur https://play.google.com/console
2. Paye les **25$ une seule fois**
3. Remplis le profil développeur (nom, email, téléphone)

### 1.4 Créer un compte Apple Developer (déjà fait ✅)
- https://developer.apple.com/account
- Assure-toi que ton compte est actif (**99$/an**)

---

## PARTIE 2 — BUILD ANDROID (Play Store)

### 2.1 Préparer le projet

Ouvre un terminal dans le dossier `flashrevise-app/` :

```bash
# Installer les dépendances
npm install

# Ajouter la plateforme Android
npx cap add android

# Synchroniser les fichiers web
npx cap sync android
```

### 2.2 Personnaliser les configs Android

Copie les fichiers de `android-config/` vers les bons emplacements :

```
android-config/app/src/main/res/values/strings.xml
  → android/app/src/main/res/values/strings.xml

android-config/app/src/main/res/values/colors.xml
  → android/app/src/main/res/values/colors.xml

android-config/app/src/main/res/values/styles.xml
  → android/app/src/main/res/values/styles.xml
```

### 2.3 Copier les icônes Android (déjà générées ✅)

Les icônes sont **déjà générées** dans `android-config/app/src/main/res/` :
- `mipmap-mdpi` (48px), `mipmap-hdpi` (72px), `mipmap-xhdpi` (96px)
- `mipmap-xxhdpi` (144px), `mipmap-xxxhdpi` (192px)
- `mipmap-anydpi-v26` — icônes adaptatives (Android 8+)

Après avoir lancé `setup.bat`, copie-les automatiquement :
```bat
copy-icons.bat
```

Ce script copie `android-config/app/src/main/res/mipmap-*` → `android/app/src/main/res/mipmap-*`

### 2.4 Créer le keystore (signature de l'app)

⚠️ **IMPORTANT** : Sauvegarde ce fichier précieusement — tu en auras besoin pour chaque mise à jour !

```bash
# Dans le dossier flashrevise-app/
keytool -genkey -v -keystore flashrevise-release.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias flashrevise
```

Réponds aux questions :
- Mot de passe keystore : [choisis un mot de passe fort]
- Prénom/nom : [ton nom ou "FlashRevise"]
- Organisation : FlashRevise
- Ville, région, pays : [tes infos]

### 2.5 Configurer la signature dans Android Studio

1. Ouvre Android Studio
2. File → Open → sélectionne le dossier `android/`
3. Attends que Gradle se synchronise (peut prendre 5 min)
4. Build → Generate Signed Bundle / APK
5. Choisis **Android App Bundle (.aab)** (recommandé pour Play Store)
6. Keystore path : sélectionne `flashrevise-release.jks`
7. Remplis les mots de passe
8. Build Type : **release**
9. Clique **Finish**

Le fichier `.aab` sera dans :
`android/app/build/outputs/bundle/release/app-release.aab`

### 2.6 Publier sur Google Play Console

1. Va sur https://play.google.com/console
2. **Créer une application**
3. Remplis les informations de base (nom, langue, type)
4. Dans **Production** → **Créer une nouvelle version**
5. Upload le fichier `app-release.aab`
6. Remplis les notes de version
7. Va dans **Présentation de l'app** et remplis :
   - Description (copie depuis `store-assets/play-store-listing.md`)
   - Captures d'écran (au moins 2 par type d'écran)
   - Icône (512×512 px) → upload `www/icon-512.png`
   - Feature graphic (1024×500 px) → à créer sur Canva
8. Politique de confidentialité → crée une page GitHub Pages
9. Questionnaire sur le contenu de l'app (tout éducatif, sans violence)
10. Soumets pour révision → **1 à 3 jours**

---

## PARTIE 3 — BUILD iOS (App Store) via CODEMAGIC

Sans Mac, on utilise **Codemagic** qui fournit des machines macOS cloud.

### 3.1 Créer un repo GitHub

```bash
# Dans flashrevise-app/
git init
git add .
git commit -m "Initial commit — FlashRevise v1.0.0"
```

Sur GitHub.com :
1. Crée un nouveau repo (public ou privé)
2. Ajoute le remote et push :
```bash
git remote add origin https://github.com/TON_USERNAME/flashrevise-app.git
git push -u origin main
```

### 3.2 Créer un compte Codemagic

1. Va sur https://codemagic.io
2. Inscris-toi avec GitHub
3. Connecte ton repo `flashrevise-app`

### 3.3 Configurer les certificats iOS dans Codemagic

Dans Codemagic → Teams → Code signing → iOS :

**a) Créer un App ID sur Apple Developer**
1. Va sur https://developer.apple.com/account/resources/identifiers
2. Crée un nouvel identifiant : `com.flashrevise.app`
3. Active les capabilities nécessaires (aucune pour cette app)

**b) Créer un certificat de distribution**
1. Apple Developer → Certificates → "+"
2. Type : **Apple Distribution**
3. Génère et télécharge le certificat
4. Upload dans Codemagic

**c) Créer un provisioning profile**
1. Apple Developer → Profiles → "+"
2. Type : **App Store Connect**
3. App ID : `com.flashrevise.app`
4. Sélectionne le certificat
5. Télécharge et upload dans Codemagic

**d) Créer une clé API App Store Connect**
1. App Store Connect → Utilisateurs et accès → Intégrations → Clés API
2. Génère une clé avec le rôle **App Manager**
3. Télécharge le fichier `.p8`
4. Note : l'**Issuer ID** et le **Key ID**
5. Configure dans Codemagic → Intégrations → App Store Connect

### 3.4 Copier les icônes iOS (déjà générées ✅)

Les 13 icônes iOS sont dans `ios-icons/` avec leur `Contents.json` Xcode :
- `Icon-20.png` à `Icon-1024.png` (toutes les tailles requises)
- `Icon-1024.png` = version App Store Connect (fond #0f172a, sans transparence)

Après `npx cap add ios`, lance :
```bat
copy-icons.bat
```
Ou copie manuellement `ios-icons/*` → `ios/App/App/Assets.xcassets/AppIcon.appiconset/`

### 3.5 Lancer le build iOS

Dans Codemagic :
1. Sélectionne ton repo
2. Workflow : `ios-release` (depuis `codemagic.yaml`)
3. Clique **Start new build**
4. Durée : environ 20-30 minutes
5. Le `.ipa` est automatiquement envoyé sur TestFlight si tout est bon

### 3.5 Soumettre sur App Store Connect

1. Va sur https://appstoreconnect.apple.com
2. **Mes apps** → "+" → **Nouvelle app**
3. Plateforme : iOS
4. Nom : FlashRevise
5. Bundle ID : `com.flashrevise.app`
6. Remplis les métadonnées (copie depuis `store-assets/app-store-listing.md`)
7. Dans **Build** → sélectionne le build TestFlight
8. Captures d'écran obligatoires : iPhone 6,7" et 6,5"
9. Politique de confidentialité URL (obligatoire)
10. Soumets pour révision → **1 à 7 jours**

---

## PARTIE 4 — POLITIQUE DE CONFIDENTIALITÉ (obligatoire)

Crée un fichier `privacy.html` sur GitHub Pages :

```
https://TON_USERNAME.github.io/flashrevise/privacy
```

Contenu :
```
FlashRevise — Politique de confidentialité

FlashRevise ne collecte aucune donnée personnelle.
- Aucun compte utilisateur requis
- Aucune donnée transmise à des serveurs
- Toutes les données de progression sont stockées localement sur votre appareil
- Aucune publicité, aucun tracking

Contact : ton@email.com
```

---

## PARTIE 5 — CHECKLIST AVANT SOUMISSION

### Android ✅
- [ ] Bundle ID : `com.flashrevise.app`
- [ ] Version : 1.0.0 (versionCode: 1)
- [ ] Icône 512×512 px uploadée
- [ ] Feature graphic 1024×500 px créé
- [ ] Au moins 2 captures d'écran
- [ ] Description courte + longue remplies
- [ ] Politique de confidentialité URL
- [ ] Questionnaire contenu rempli
- [ ] .aab signé avec keystore

### iOS ✅
- [ ] Bundle ID : `com.flashrevise.app`
- [ ] Version : 1.0.0 (build: 1)
- [ ] Icône 1024×1024 px (pas de coins arrondis, pas de transparence)
- [ ] Captures d'écran iPhone 6,7" (1290×2796)
- [ ] Captures d'écran iPhone 6,5" (1242×2688)
- [ ] Captures d'écran iPad (optionnel)
- [ ] Politique de confidentialité URL
- [ ] Certificat de distribution + Provisioning Profile
- [ ] Build TestFlight validé

---

## PARTIE 6 — MISES À JOUR

Pour chaque mise à jour :
1. Modifie `index.html` (nouvelles cartes, corrections)
2. `npx cap sync android` → rebuild `.aab` → upload sur Play Console
3. Push sur GitHub → Codemagic rebuild → App Store Connect

Pour Android : versionCode doit augmenter à chaque update (1, 2, 3...)
Pour iOS : Build number doit augmenter (1, 2, 3...)

---

## 📞 Support et ressources

- Capacitor docs : https://capacitorjs.com/docs
- Google Play Console help : https://support.google.com/googleplay/android-developer
- App Store Connect help : https://developer.apple.com/help/app-store-connect
- Codemagic docs : https://docs.codemagic.io
- Icônes Android : https://romannurik.github.io/AndroidAssetStudio
- Feature graphic Canva : https://www.canva.com (template 1024×500)
