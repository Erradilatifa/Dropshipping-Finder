# 🚀 Démarrage Rapide - Dropshipping Finder

## ✅ Le Projet est Démarré!

### 📍 URLs d'Accès

| Service | URL | Statut |
|---------|-----|--------|
| **Application** | http://localhost:3000 | 🟢 En cours |
| **Admin Django** | http://localhost:8000/admin/ | 🟢 Disponible |
| **API Swagger** | http://localhost:8000/swagger/ | 🟢 Disponible |
| **API** | http://localhost:8000/api/ | 🟢 Disponible |

---

## 🔐 Identifiants de Connexion

### 👨‍💼 Admin Django (Interface d'administration)
**URL**: http://localhost:8000/admin/

```
Username: admin
Mot de passe: admin123456
```

### 👤 Compte Test (Application)
**URL**: http://localhost:3000

```
Email: test@test.com
Mot de passe: test123456
```

---

## 🎯 Que Faire Maintenant?

### 1. Tester l'Application (Frontend)
1. Ouvrez: **http://localhost:3000**
2. Connectez-vous avec: `test@test.com` / `test123456`
3. Ou créez un nouveau compte

### 2. Accéder à l'Admin Django (Backend)
1. Ouvrez: **http://localhost:8000/admin/**
2. Connectez-vous avec: `admin` / `admin123456`
3. Explorez:
   - **Users** - Gérer les utilisateurs
   - **Products** - Gérer les produits
   - **Favorites** - Voir les favoris
   - **User Profiles** - Profils utilisateurs

### 3. Voir la Documentation API
1. Ouvrez: **http://localhost:8000/swagger/**
2. Explorez tous les endpoints disponibles
3. Testez les requêtes directement depuis l'interface

---

## 📊 Fonctionnalités Disponibles

### Dans l'Application (Port 3000):
- ✅ Création de compte
- ✅ Connexion / Déconnexion
- ✅ Tableau de bord
- ✅ Recherche de produits
- ✅ Produits tendance
- ✅ Gestion des favoris
- ✅ Profil utilisateur
- ✅ Gestion d'abonnement

### Dans l'Admin Django (Port 8000):
- ✅ Gestion complète des utilisateurs
- ✅ Gestion des produits
- ✅ Gestion des catégories
- ✅ Statistiques
- ✅ Configuration système
- ✅ Logs et monitoring

---

## 🛠️ Commandes Utiles

### Arrêter les Serveurs:
Appuyez sur **Ctrl + C** dans chaque terminal

### Redémarrer le Backend:
```bash
cd C:\Users\DELL\CascadeProjects\dropshipping-finder\backend
venv\Scripts\python.exe manage.py runserver
```

### Redémarrer le Frontend:
```bash
cd C:\Users\DELL\CascadeProjects\dropshipping-finder\frontend
flutter run -d chrome --web-port=3000
```

### Réinitialiser le mot de passe admin:
```bash
cd C:\Users\DELL\CascadeProjects\dropshipping-finder\backend
venv\Scripts\python.exe reset_admin_password.py
```

### Créer un nouvel utilisateur de test:
```bash
cd C:\Users\DELL\CascadeProjects\dropshipping-finder\backend
venv\Scripts\python.exe create_test_user.py
```

---

## 📝 Prochaines Étapes

### 1. Ajouter des Produits
Via l'admin Django:
1. Allez sur http://localhost:8000/admin/
2. Cliquez sur **Products** → **Add Product**
3. Remplissez les informations du produit
4. Sauvegardez

### 2. Tester la Recherche
Dans l'application:
1. Connectez-vous
2. Utilisez la barre de recherche
3. Testez les filtres

### 3. Personnaliser
- Modifiez les couleurs dans `frontend/lib/utils/theme.dart`
- Ajoutez des catégories via l'admin
- Configurez les plans d'abonnement

---

## 🔧 Résolution de Problèmes

### Le Backend ne démarre pas:
```bash
cd backend
venv\Scripts\python.exe manage.py migrate
venv\Scripts\python.exe manage.py runserver
```

### Le Frontend ne démarre pas:
```bash
cd frontend
flutter clean
flutter pub get
flutter run -d chrome --web-port=3000
```

### Port déjà utilisé:
```bash
# Trouver le processus
netstat -ano | findstr :8000
# ou
netstat -ano | findstr :3000

# Tuer le processus
taskkill /F /PID <numéro_du_PID>
```

---

## 📚 Documentation Complète

Pour plus de détails, consultez:
- **ACCES_ADMIN.md** - Guide complet d'accès admin
- **DATABASE_INFO.md** - Informations sur la base de données
- **SOLUTION_COMPLETE.md** - Solutions aux problèmes
- **INSTRUCTIONS_TEST.md** - Guide de test complet

---

## ✨ Résumé

| Élément | Valeur |
|---------|--------|
| **Frontend** | http://localhost:3000 |
| **Backend Admin** | http://localhost:8000/admin/ |
| **Admin Username** | admin |
| **Admin Password** | admin123456 |
| **Test Email** | test@test.com |
| **Test Password** | test123456 |
| **Base de données** | SQLite (db.sqlite3) |

---

## 🎉 Tout est Prêt!

Votre application Dropshipping Finder est maintenant complètement opérationnelle!

**Bon développement!** 🚀
