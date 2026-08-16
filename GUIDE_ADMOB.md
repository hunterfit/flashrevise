# Guide — Passer d'AdSense à AdMob (FlashRevise)

## Pourquoi ce changement
Le règlement Google interdit d'intégrer **AdSense dans une application** (WebView compris) — *sauf AdMob*. C'est la raison du refus « vous devez résoudre certains problèmes ». On a donc :
- **retiré** le script AdSense de l'app (`www/index.html` + `pwa/index.html`) ;
- **intégré AdMob** (plugin `@capacitor-community/admob`) avec des **interstitiels** (pub plein écran) affichés à la fin d'une session sur deux — pas de bannière qui gêne la barre d'onglets.

Actuellement, l'app tourne avec les **identifiants de TEST** de Google : les pubs s'affichent (marquées « Test Ad ») sans risque pour ton compte. Il reste à mettre tes vrais identifiants.

---

## Étape 1 — Créer ton compte AdMob
1. Va sur https://apps.admob.com et connecte-toi (AdMob est lié à ton compte Google).
2. **Add app** → plateforme **Android** (et une 2ᵉ fois **iOS** si tu publies sur l'App Store).
3. Renseigne le nom de package : `com.flashrevise.app`.
4. Tu obtiens un **App ID** de la forme `ca-app-pub-XXXXXXXX~YYYYYYYY`.

## Étape 2 — Créer un bloc d'annonces interstitiel
1. Dans ton app AdMob → **Ad units** → **Add ad unit** → **Interstitial**.
2. Note l'**ID du bloc** : `ca-app-pub-XXXXXXXX/ZZZZZZZZ` (un pour Android, un pour iOS).

## Étape 3 — Remplacer les IDs de test dans le code

**a) `www/index.html` et `pwa/index.html`** — objet `ADMOB_CONFIG` (identique dans les deux fichiers) :
```js
const ADMOB_CONFIG={
  interstitialAndroid:'ca-app-pub-XXXX/ZZZZ',  // ← ton bloc Android
  interstitialIos:'ca-app-pub-XXXX/WWWW',      // ← ton bloc iOS
  useTest:false,        // ← passe à false avec tes vrais IDs
  everyNsessions:2      // fréquence (1 pub toutes les N sessions)
};
```
> ⚠️ Garde `useTest:true` tant que tu développes. Ne clique **jamais** sur tes propres vraies pubs → bannissement AdMob.

**b) `android/app/src/main/AndroidManifest.xml`** — remplace l'App ID de test :
```xml
<meta-data
  android:name="com.google.android.gms.ads.APPLICATION_ID"
  android:value="ca-app-pub-XXXXXXXX~YYYYYYYY" />
```

**c) iOS (si tu publies sur l'App Store)** — après `npx cap add ios`, dans `ios/App/App/Info.plist` :
```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-XXXXXXXX~YYYYYYYY</string>
```
(Apple exige aussi une entrée `NSUserTrackingUsageDescription` si tu actives la pub personnalisée + le consentement.)

## Étape 4 — Build
Le build Codemagic installe le plugin automatiquement (`npm install` + `npx cap sync`). Rien à changer dans `codemagic.yaml`. Lance le workflow **Android Release** comme d'habitude.

---

## RGPD / consentement (Europe)
Pour diffuser en France, AdMob impose un **message de consentement (CMP)**. Dans AdMob → **Privacy & messaging** → configure un message **GDPR/UE**. Le SDK l'affiche au premier lancement. C'est indispensable pour être payé et rester conforme.

## Récap
| Élément | État |
|---|---|
| AdSense retiré de l'app | ✅ fait |
| Plugin AdMob ajouté | ✅ fait (`package.json`) |
| App ID Android (manifest) | ✅ test — à remplacer |
| Interstitiel fin de session | ✅ fait (IDs test) |
| Tes vrais IDs AdMob | ⏳ à faire (étapes 1-3) |
| Message de consentement RGPD | ⏳ à configurer dans AdMob |
| iOS Info.plist | ⏳ après `cap add ios` |
