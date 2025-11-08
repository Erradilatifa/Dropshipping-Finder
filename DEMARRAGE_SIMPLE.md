# 🚀 Démarrage Simple du Projet

## ✅ Solution Rapide aux 2 Problèmes

### Problème 1: Affiche toujours "OMAR"
**Cause**: Cache du navigateur  
**Solution**: Vider le cache ou utiliser navigation privée

### Problème 2: "No module named 'django'"
**Cause**: Environnement virtuel non activé  
**Solution**: Activer le venv avant d'exécuter les commandes

---

## 🎯 Méthode 1: Script Automatique (RECOMMANDÉ)

### Double-cliquez sur:
```
START_PROJECT.ps1
```

Ce script va:
1. ✅ Activer l'environnement virtuel
2. ✅ Démarrer le backend Django
3. ✅ Démarrer le frontend Flutter
4. ✅ Ouvrir les terminaux nécessaires

---

## 🎯 Méthode 2: Manuel (Étape par Étape)

### Terminal 1: Backend Django
```powershell
cd backend
.\venv\Scripts\Activate.ps1
python manage.py runserver
```

### Terminal 2: Frontend Flutter
```powershell
cd frontend
flutter run -d chrome --web-port=3000
```

---

## 📦 Pour Importer des Produits

### Option A: Script Automatique
Double-cliquez sur:
```
IMPORT_PRODUCTS.ps1
```

### Option B: Manuel
```powershell
cd backend
.\venv\Scripts\Activate.ps1
python manage.py import_products "smart watch" --pages=1 --no-tor
```

---

## 🔧 Résoudre le Problème "OMAR"

### Méthode 1: Vider le Cache (Recommandé)
1. Appuyez sur **Ctrl + Shift + Delete**
2. Cochez "Cookies" et "Cache"
3. Cliquez sur "Effacer les données"
4. Rechargez la page (**F5**)

### Méthode 2: Navigation Privée (Plus Simple)
1. Appuyez sur **Ctrl + Shift + N**
2. Allez sur `http://localhost:3000`
3. Connectez-vous
4. Le nom correct s'affichera! ✅

### Méthode 3: Rechargement Forcé
1. Appuyez sur **Ctrl + F5**
2. Ou **Ctrl + Shift + R**

---

## 📍 URLs d'Accès

| Service | URL | Description |
|---------|-----|-------------|
| **Frontend** | http://localhost:3000 | Application Flutter |
| **Backend** | http://localhost:8000 | API Django |
| **Admin** | http://localhost:8000/admin | Interface admin |
| **API Docs** | http://localhost:8000/api/ | Documentation API |

---

## 👤 Comptes de Test

| Email | Rôle | Description |
|-------|------|-------------|
| image@gmail.com | User | Compte test |
| test@test.com | User | Compte test |
| admin | Admin | Accès admin |

---

## 🐛 Résolution des Erreurs Courantes

### Erreur: "No module named 'django'"
**Solution**:
```powershell
cd backend
.\venv\Scripts\Activate.ps1
```

### Erreur: "Port 8000 already in use"
**Solution**:
```powershell
# Trouver le processus
netstat -ano | findstr :8000

# Tuer le processus (remplacer PID)
taskkill /F /PID <PID>
```

### Erreur: "Port 3000 already in use"
**Solution**:
```powershell
# Arrêter tous les processus Flutter
Get-Process | Where-Object {$_.ProcessName -like "*dart*"} | Stop-Process -Force
```

### Erreur: Affiche toujours "OMAR"
**Solution**: Vider le cache du navigateur (voir ci-dessus)

---

## ✅ Checklist de Vérification

Avant de démarrer, vérifiez:
- [ ] Redis est démarré (pour Celery)
- [ ] Environnement virtuel activé
- [ ] Ports 3000 et 8000 libres
- [ ] Dépendances installées

---

## 🎉 Résumé

### Pour Démarrer le Projet:
1. Double-cliquez sur `START_PROJECT.ps1`
2. Attendez que tout démarre
3. Ouvrez `http://localhost:3000` en navigation privée
4. Connectez-vous
5. Le nom correct s'affichera! ✅

### Pour Importer des Produits:
1. Double-cliquez sur `IMPORT_PRODUCTS.ps1`
2. Choisissez l'option d'import
3. Attendez la fin de l'import
4. Vérifiez dans l'admin: `http://localhost:8000/admin/core/product/`

---

**Date**: 8 Novembre 2025  
**Statut**: ✅ Prêt à utiliser
