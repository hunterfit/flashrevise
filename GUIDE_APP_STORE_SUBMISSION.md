# 🍎 Guide pas-à-pas — Soumission FlashRevise sur App Store

**État actuel** : IPA produit sur Codemagic ✅ · Privacy URL en ligne ✅ · 6 captures iPhone 6,7" prêtes ✅

Il reste 2 étapes : **créer la fiche App Store Connect** + **soumettre pour révision**.

---

## ÉTAPE 1 — Vérifier que le build est dispo sur App Store Connect

1. Va sur https://appstoreconnect.apple.com → **Mes apps**
2. Si l'app **FlashRevise** n'existe pas encore : passe à l'**étape 2**
3. Si elle existe déjà : ouvre-la → onglet **TestFlight**
4. Vérifie que ton build (1.0.0, build 1) apparaît avec le statut **« Prêt à tester »** ou **« Prêt à soumettre »**
5. Si Apple demande de répondre au questionnaire **Export Compliance** (chiffrement) : réponds **Non** (l'app n'utilise pas de chiffrement custom)

---

## ÉTAPE 2 — Créer la fiche app (si pas encore fait)

1. App Store Connect → **Mes apps** → bouton **« + »** → **Nouvelle app**
2. Remplis :
   - **Plateformes** : ✅ iOS
   - **Nom** : `FlashRevise`
   - **Langue principale** : Français (France)
   - **Bundle ID** : `com.flashrevise.app` (sélectionne dans la liste)
   - **SKU** : `FLASHREVISE-001` (identifiant interne libre)
   - **Accès utilisateur** : Accès complet
3. Clique **Créer**

---

## ÉTAPE 3 — Remplir les infos de l'app

Onglet **Distribution → Disponibilité de l'app** :
- Choisis les pays/régions (au minimum la France ; tu peux cocher « Toutes les régions »)

Onglet **Distribution → Tarification** :
- **Gratuit** (Prix : 0,00 €)

Onglet **Distribution → 1.0 Préparer la soumission** :

### A. Aperçus et captures d'écran

Section **iPhone 6,7 pouces (obligatoire)** :
- Glisse-dépose les 6 PNG depuis `store-assets/screenshots-ios/` :
  - `01_home.png`
  - `02_flashcard_question.png`
  - `03_flashcard_answer.png`
  - `04_qcm.png`
  - `05_stats_heatmap.png`
  - `06_catalogue.png`

Section **iPhone 6,5 pouces** : ✨ Apple génère automatiquement à partir des 6,7"

### B. Informations promotionnelles (optionnel)
Texte promotionnel (170 car. max) :
```
Plus de 1 700 flashcards de révision · Collège → Agrégation · Maths, Physique, Anglais, Espagnol, Allemand, Arabe · 100% hors ligne.
```

### C. Description (4 000 car. max)
Colle depuis `store-assets/app-store-listing.md` :

```
FlashRevise — La méthode de révision qui fonctionne vraiment.

Plus de 1 700 flashcards soigneusement conçues, du collège à l'agrégation. Maths, Physique-Chimie, et 4 langues étrangères. Disponible 100 % hors ligne.

📚 CONTENU COMPLET
• 13 niveaux : Collège (4e, 5e) · Lycée (Seconde, Première, Terminale) · CPGE (MPSI, MP) · Licence L1 · Agrégation
• Maths : définitions, théorèmes, formules et méthodes
• Physique-Chimie : lois fondamentales, formules, applications
• 🇬🇧 Anglais · 🇪🇸 Espagnol · 🇩🇪 Allemand · 🕌 Arabe

⚡ 4 MODES DE RÉVISION
• Répétition espacée (SRS) — l'algorithme adapte les révisions à ta mémoire
• QCM — 4 propositions avec feedback immédiat
• Vrai / Faux — révision ultra-rapide
• Chrono — QCM en 60 secondes pour booster ta concentration

📊 SUIVI DE PROGRESSION
• Heatmap de 15 semaines (style GitHub)
• Taux de maîtrise par niveau et par matière
• Série de jours consécutifs (streak)
• 12 badges à débloquer

🔍 ORGANISATION INTELLIGENTE
• Filtrage par niveau, matière et type de fiche
• Modes déclinaisons, définitions, formules, théorèmes
• Recherche rapide dans toutes les cartes

🌙 DESIGN SOIGNÉ
• Interface sombre et moderne
• Animation 3D au retournement des cartes
• Navigation fluide 5 onglets

📶 100 % HORS LIGNE
Aucune connexion Internet requise. Toutes les données sont stockées localement sur ton appareil. Aucun compte. Aucune publicité.

Idéal pour réviser dans le train, le bus, ou partout sans réseau.
```

### D. Mots-clés (100 car. max)
```
flashcards,révision,maths,physique,bac,terminale,MPSI,prépa,agrégation,anglais,espagnol,allemand,arabe,lycée
```

### E. URLs
- **URL d'assistance** : ton URL GitHub Pages (ex: `https://hunterfit.github.io/flashrevise/`)
- **URL marketing** (optionnel) : même URL

### F. Informations générales
- **Sous-titre** (30 car. max) : `1725 fiches · Maths · Langues`
- **Catégorie principale** : Éducation
- **Catégorie secondaire** : Utilitaires

### G. Tranche d'âge
- Clique **Modifier** → réponds **Aucun** à toutes les questions (pas de violence, pas d'alcool, etc.)
- Résultat : **4+**

### H. Copyright
```
© 2026 FlashRevise
```

---

## ÉTAPE 4 — Confidentialité

Onglet **Confidentialité de l'app** (menu de gauche) :

1. **URL de politique de confidentialité** : ton URL en ligne (celle déjà publiée)
2. **Pratiques en matière de données** : clique **Commencer**
   - Question 1 : « Collectez-vous des données ? » → **Non, nous ne collectons pas de données**
   - Publier

---

## ÉTAPE 5 — Associer le build TestFlight

Retour sur **Distribution → 1.0 Préparer la soumission** :

1. Section **Build** → clique **« + »** ou **« Sélectionner un build »**
2. Choisis ton build 1.0.0 (build 1)
3. Question Export Compliance : **Non** (pas de chiffrement custom)

---

## ÉTAPE 6 — Coordonnées de la révision

Section **Informations sur la révision de l'app** :
- **Prénom / Nom** : tes nom/prénom
- **Téléphone** : ton numéro (Apple peut appeler en cas de souci)
- **Email** : `chahine.cherouat13@gmail.com`
- **Notes pour le service de révision** (optionnel mais utile) :
```
Application éducative de flashcards.
Aucun compte, aucune connexion Internet requise.
Toutes les données sont stockées localement.
Pas de publicité, pas de tracking.
```

---

## ÉTAPE 7 — Notes de version

```
Version 1.0.0 — Lancement initial

• 1 725 flashcards de révision
• 13 niveaux scolaires (Collège → Agrégation)
• 4 langues : Anglais, Espagnol, Allemand, Arabe
• 4 modes : SRS, QCM, Vrai/Faux, Chrono
• Statistiques et badges
• 100 % hors ligne
```

---

## ÉTAPE 8 — Soumission

En haut à droite de la page **1.0 Préparer la soumission** :

1. Vérifie que **tous les indicateurs sont verts** (pas de champ obligatoire rouge)
2. Clique **« Ajouter à la révision »** (ou **« Soumettre pour révision »**)
3. Confirme la déclaration de conformité
4. ✅ Statut → **« En attente de révision »**

**Délai habituel** : 24-48h pour la 1ère review (parfois jusqu'à 7 jours).

---

## SI APPLE REJETTE — checklist des motifs courants

| Motif | Solution |
|-------|----------|
| Captures non conformes | Vérifie le ratio 1290×2796, sans transparence |
| Privacy URL inaccessible | Ouvre l'URL en navigation privée |
| Métadonnées trompeuses | Évite « meilleur », « n°1 », mots-clés non pertinents |
| Sign-In with Apple manquant | Non applicable (pas de login) |
| Crash au lancement | Re-teste l'IPA via TestFlight d'abord |
| App vide / contenu insuffisant | Décris bien les 1 725 cartes dans les notes |

---

## 📞 Si problème pendant la soumission

- App Store Connect Help : https://help.apple.com/app-store-connect/
- Contact Apple Developer Support : https://developer.apple.com/contact/

Une fois validé, l'app sera **automatiquement disponible** sur l'App Store (ou tu peux choisir « Publication manuelle » à l'étape 8 pour publier toi-même quand tu veux).

Bonne soumission ! 🚀
