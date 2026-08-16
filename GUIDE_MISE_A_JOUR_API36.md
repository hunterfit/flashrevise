# Guide — Mettre FlashRevise en conformité API 36 (Google Play)

## Le problème
Google Play affiche : *« Mettez à jour votre niveau d'API cible d'ici le 31 août 2026 »*.
À partir de cette date, **toute mise à jour d'app soumise doit cibler l'API 36 (Android 16)**.
Tant que l'app cible une API trop ancienne, tu ne peux plus déployer de mises à jour.

## Ce qui a déjà été corrigé dans le projet
| Fichier | Avant | Après |
|---|---|---|
| `android/variables.gradle` | `compileSdkVersion = 35` / `targetSdkVersion = 35` | **36** / **36** |
| `android/app/build.gradle` | `versionCode 2` / `versionName "1.0"` | **versionCode 3** / **versionName "1.1"** |

> `minSdkVersion` reste à 22 : les vieux téléphones restent supportés. Seule la cible change.
> Tes outils de build (AGP 8.13.2, Gradle 8.13) supportent déjà l'API 36 — rien d'autre à mettre à jour.

⚠️ **Important : `versionCode` doit toujours augmenter** à chaque envoi sur Play. Il est passé à 3. Pour le prochain envoi, mets 4, puis 5, etc.

---

## Étapes pour publier (via Codemagic — pas de PC Android nécessaire)

### 1. Pousser le code sur GitHub
Depuis le dossier `flashrevise-app` :
```bash
git add android/variables.gradle android/app/build.gradle www/index.html
git commit -m "API 36 + amelioration lisibilite UI (v1.1, versionCode 3)"
git push
```

### 2. Lancer le build sur Codemagic
1. Va sur https://codemagic.io → ton app FlashRevise.
2. Lance le workflow **« Android Release (Play Store) »** (déjà défini dans `codemagic.yaml`).
3. Le build fait automatiquement : `npm install` → `npx cap sync android` → `./gradlew bundleRelease`.
4. À la fin, l'artefact **`app-release.aab`** est produit et (selon ta config) envoyé sur la piste **internal** de Play en brouillon.

### 3. Vérifier / soumettre sur Google Play Console
1. Play Console → **FlashRevise** → **Tests → Test interne** (ou **Production**).
2. Vérifie que le nouveau build affiche **« Cible : Android 16 (API 36) »** et **« Code de version : 3 »**.
3. Si tout est bon : **Créer une release → Vérifier → Déployer**.
4. Le bandeau d'avertissement API disparaît une fois la release avec API 36 en cours de déploiement.

### Alternative sans Codemagic (si tu as Android Studio)
```bash
cd flashrevise-app
npm install
npx cap sync android
cd android
./gradlew bundleRelease   # produit android/app/build/outputs/bundle/release/app-release.aab
```
Puis upload manuel de l'`.aab` dans Play Console.

---

## Besoin de plus de temps ?
Si le build n'est pas prêt le 31 août, Play permet de **demander une extension jusqu'au 1er novembre 2026** (bouton « Demander une prolongation » dans le bandeau d'avertissement).

## Rappel iOS
Le même changement n'affecte pas iOS. Pour l'App Store, le workflow `ios-release` de `codemagic.yaml` reste inchangé.
