# 🧪 GUIDE TEST - FAVORIS PERSISTANTS

**Date**: 8 Novembre 2025 - 20:12  
**Objectif**: Vérifier que les favoris restent après déconnexion/reconnexion

---

## 📋 TEST COMPLET (5 MINUTES)

### Étape 1: Ajouter des Favoris
1. **Ouvrez**: http://localhost:3000
2. **Connectez-vous**: test@test.com / test123456
3. **Page Accueil** → Voyez les produits
4. **Cliquez sur ❤️** de 3 produits différents
5. **Vérifiez**: Les cœurs deviennent ROUGES ✅

### Étape 2: Vérifier la Page "Mes Favoris"
1. **Cliquez sur l'icône ❤️** en bas (navigation)
2. **Page "Mes Favoris" s'ouvre**
3. **Vérifiez**: Les 3 produits s'affichent ✅

### Étape 3: Vérifier les Logs (IMPORTANT!)
1. **Ouvrez la console** (F12)
2. **Onglet Console**
3. **Cherchez ces messages**:
   ```
   💾 Saved 3 favorites to storage
   ```
4. **Si vous voyez ce message** → Les favoris sont sauvegardés! ✅

### Étape 4: Déconnexion
1. **Page Profil** (icône utilisateur en bas)
2. **Bouton "Se déconnecter"** (rouge)
3. **Confirmez** la déconnexion
4. **Retour à la page de connexion** ✅

### Étape 5: Reconnexion
1. **Connectez-vous** à nouveau
2. **Email**: test@test.com
3. **Mot de passe**: test123456

### Étape 6: Vérifier les Favoris Après Reconnexion ⭐
1. **Ouvrez la console** (F12) AVANT de naviguer
2. **Cherchez ce message**:
   ```
   📦 Loading favorites from storage...
   ✅ Loaded 3 favorites from storage
   ```
3. **Page "Mes Favoris"**
4. **Vérifiez**: Les 3 produits sont toujours là! ⭐

### Étape 7: Vérifier les Stats Profil
1. **Page Profil**
2. **Stats en haut**: "3 Favoris" ✅

---

## 🔍 MESSAGES DE DEBUG À CHERCHER

### Quand Vous Ajoutez un Favori
```
💾 Saved X favorites to storage
```
**Si vous voyez ça** → Sauvegarde fonctionne! ✅

### Quand Vous Ouvrez l'App
```
📦 Loading favorites from storage...
✅ Loaded X favorites from storage
```
**Si vous voyez ça** → Chargement fonctionne! ✅

### Si Aucun Favori
```
📭 No favorites found in storage
```
**Normal** si vous n'avez pas encore ajouté de favoris

### Si Erreur
```
❌ Error loading favorites from storage: ...
❌ Error saving favorites to storage: ...
```
**Problème!** → Dites-moi l'erreur complète

---

## 🐛 PROBLÈMES POSSIBLES

### Problème 1: "📭 No favorites found in storage"
**Cause**: Vous n'avez pas encore ajouté de favoris

**Solution**:
1. Ajoutez des favoris (cliquez sur ❤️)
2. Vérifiez que vous voyez "💾 Saved X favorites"

### Problème 2: Pas de Message "💾 Saved"
**Cause**: La sauvegarde ne fonctionne pas

**Solution**:
1. Vérifiez la console pour des erreurs
2. Essayez de vider le cache (Ctrl+Shift+Delete)
3. Redémarrez l'application

### Problème 3: "✅ Loaded X favorites" mais Page Vide
**Cause**: Les favoris sont chargés mais pas affichés

**Solution**:
1. Allez sur une autre page
2. Revenez sur "Mes Favoris"
3. Si toujours vide, faites une capture d'écran

---

## 📊 CHECKLIST RAPIDE

### Avant Déconnexion
- [ ] 3 favoris ajoutés (cœurs rouges)
- [ ] Page "Mes Favoris" affiche 3 produits
- [ ] Stats profil: "3 Favoris"
- [ ] Console: "💾 Saved 3 favorites to storage"

### Après Reconnexion
- [ ] Console: "✅ Loaded 3 favorites from storage"
- [ ] Page "Mes Favoris" affiche 3 produits
- [ ] Stats profil: "3 Favoris"
- [ ] Cœurs toujours rouges sur la page d'accueil

---

## 🎯 CE QUI DOIT FONCTIONNER

### Flux Complet
```
1. Ajouter favoris
   ↓
2. Sauvegarde locale (SharedPreferences)
   ↓
3. Déconnexion
   ↓
4. Reconnexion
   ↓
5. Chargement depuis local storage
   ↓
6. Favoris affichés ✅
```

### Persistance
- ✅ Favoris sauvegardés localement
- ✅ Indépendant de la connexion
- ✅ Reste après fermeture du navigateur
- ✅ Reste après déconnexion/reconnexion

---

## 🚨 SI ÇA NE MARCHE PAS

### Étape 1: Vérifier les Logs
```
F12 → Console
Chercher:
- 💾 Saved
- 📦 Loading
- ✅ Loaded
- ❌ Error
```

### Étape 2: Vérifier Local Storage
```
F12 → Application → Local Storage → http://localhost:3000
Chercher: flutter.favorites
Doit contenir: [{"id":"...","name":"...",...}]
```

### Étape 3: Copier les Logs
1. **Ouvrez la console** (F12)
2. **Clic droit** dans la console
3. **"Save as..."** ou copiez tout
4. **Envoyez-moi** les logs

---

## 📝 INSTRUCTIONS POUR VOUS

### Test 1: Ajouter et Vérifier
1. Ajoutez 3 favoris
2. Ouvrez F12 → Console
3. Cherchez "💾 Saved 3 favorites"
4. **Faites une capture d'écran** de la console

### Test 2: Déconnecter et Reconnecter
1. Déconnectez-vous
2. Reconnectez-vous
3. Ouvrez F12 → Console IMMÉDIATEMENT
4. Cherchez "✅ Loaded 3 favorites"
5. **Faites une capture d'écran** de la console

### Test 3: Vérifier la Page
1. Allez sur "Mes Favoris"
2. **Faites une capture d'écran** de la page
3. Dites-moi ce que vous voyez

---

## ✅ RÉSULTAT ATTENDU

### Console Logs
```
📦 Loading favorites from storage...
✅ Loaded 3 favorites from storage
```

### Page "Mes Favoris"
- **3 produits** affichés
- **Images** visibles
- **Noms** et **prix** affichés
- **Bouton 🗑️** pour supprimer

### Stats Profil
- **"3 Favoris"** (nombre correct)
- **Mise à jour** en temps réel

---

**FAITES LE TEST ET ENVOYEZ-MOI LES CAPTURES D'ÉCRAN!** 📸

**SURTOUT LA CONSOLE AVEC LES LOGS!** 🔍
