# 🧪 TEST FAVORIS - GUIDE COMPLET

**Date**: 8 Novembre 2025 - 20:05  
**Problème**: Page "Mes Favoris" affiche "Aucun favori"

---

## 🔍 DIAGNOSTIC

### Étapes pour Tester

#### Test 1: Ajouter un Favori
1. **Ouvrez**: http://localhost:3000
2. **Connectez-vous**: test@test.com / test123456
3. **Page Accueil**
4. **Cliquez sur ❤️** d'un produit
5. **Vérifiez**: Le cœur devient rouge ✅

#### Test 2: Vérifier le Stockage Local
1. **Ouvrez la console** (F12)
2. **Onglet Application** → **Local Storage**
3. **Cherchez**: `flutter.favorites`
4. **Vérifiez**: Les données JSON sont là ✅

#### Test 3: Page "Mes Favoris"
1. **Cliquez sur l'icône ❤️** en bas
2. **Page "Mes Favoris" s'ouvre**
3. **Vérifiez**: Les produits s'affichent ✅

#### Test 4: Stats Profil
1. **Page Profil**
2. **Vérifiez**: "X Favoris" (X = nombre réel)

---

## 🐛 PROBLÈMES POSSIBLES

### Problème 1: SharedPreferences Non Initialisé
**Symptôme**: Favoris ne se sauvegardent pas

**Solution**:
```dart
// Dans ProductProvider constructor
ProductProvider() {
  _loadFavoritesFromStorage();
}
```

### Problème 2: loadFavorites() Ne Charge Pas Local
**Symptôme**: Page "Mes Favoris" vide

**Solution**:
```dart
Future<void> loadFavorites() async {
  // Charge depuis local storage FIRST
  await _loadFavoritesFromStorage();
  
  // Puis sync avec API (optionnel)
  try {
    final response = await _apiService.getFavorites();
    // ...
  } catch (e) {
    // Continue avec favoris locaux
  }
}
```

### Problème 3: Stats Profil à 0
**Symptôme**: "0 Favoris" même avec favoris ajoutés

**Solution**:
```dart
// Utiliser ProductProvider au lieu de User
'${productProvider.favorites.length}'
```

---

## ✅ FLUX COMPLET DES FAVORIS

### 1. Initialisation App
```
main.dart
↓
ProductProvider créé
↓
Constructor: _loadFavoritesFromStorage()
↓
Charge depuis SharedPreferences
↓
_favorites = [...] (liste chargée)
```

### 2. Ajouter un Favori
```
Page Accueil → Clic ❤️
↓
toggleFavorite(productId)
↓
_favorites.add(product)
↓
_saveFavoritesToStorage()
↓
SharedPreferences.setString('favorites', json)
↓
notifyListeners() → UI se met à jour
```

### 3. Voir les Favoris
```
Page "Mes Favoris" → initState()
↓
loadFavorites()
↓
_loadFavoritesFromStorage()
↓
_favorites chargés depuis SharedPreferences
↓
notifyListeners()
↓
UI affiche la liste
```

### 4. Stats Profil
```
Page Profil → build()
↓
Consumer3<..., ProductProvider>
↓
productProvider.favorites.length
↓
Affiche le nombre réel
```

---

## 🔧 COMMANDES DE DEBUG

### Vérifier SharedPreferences (Console Browser)
```javascript
// Ouvrir console (F12)
localStorage.getItem('flutter.favorites')
```

### Logs Flutter
```dart
// Dans ProductProvider
debugPrint('✅ Loaded ${_favorites.length} favorites from storage');
debugPrint('❌ Error loading favorites: $e');
```

---

## 📊 CHECKLIST COMPLET

### Backend
- [ ] Django tourne sur port 8000
- [ ] API `/api/products/` fonctionne
- [ ] API `/api/favorites/` fonctionne (optionnel)

### Frontend
- [ ] Flutter compile sans erreur
- [ ] ProductProvider initialisé
- [ ] SharedPreferences fonctionne
- [ ] Favoris se sauvegardent localement

### UI
- [ ] Cœur devient rouge au clic
- [ ] Page "Mes Favoris" affiche les produits
- [ ] Stats profil affichent le bon nombre
- [ ] Favoris persistent après refresh

---

## 🎯 TESTS À FAIRE MAINTENANT

### Test Rapide (2 minutes)
1. **Ajoutez 3 favoris** sur la page d'accueil
2. **Allez sur "Mes Favoris"** (icône ❤️ en bas)
3. **Vérifiez**: Les 3 produits s'affichent
4. **Allez sur Profil**
5. **Vérifiez**: "3 Favoris" dans les stats

### Test Persistance (3 minutes)
1. **Ajoutez 5 favoris**
2. **Fermez le navigateur**
3. **Rouvrez**: http://localhost:3000
4. **Connectez-vous**
5. **Page "Mes Favoris"**
6. **Vérifiez**: Les 5 favoris sont toujours là ✅

---

## 🚨 SI ÇA NE MARCHE PAS

### Vérification 1: Console Logs
```
Ouvrir F12 → Console
Chercher:
- "✅ Loaded X favorites"
- "❌ Error loading favorites"
```

### Vérification 2: Network Tab
```
F12 → Network
Ajouter un favori
Chercher:
- POST /api/favorites/toggle/
```

### Vérification 3: Local Storage
```
F12 → Application → Local Storage
Chercher:
- flutter.favorites
Doit contenir: [{"id":"...","name":"...",...}]
```

---

## 📝 NOTES IMPORTANTES

1. **Les favoris sont sauvegardés LOCALEMENT** (SharedPreferences)
2. **L'API est OPTIONNELLE** (fonctionne sans connexion)
3. **Les favoris persistent** après déconnexion
4. **Les stats se mettent à jour** en temps réel

---

**TESTEZ MAINTENANT ET DITES-MOI CE QUI SE PASSE!** 🧪
