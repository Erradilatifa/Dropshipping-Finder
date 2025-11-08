# 🎯 Instructions de Test - Dropshipping Finder

## ✅ Tous les Problèmes Sont Résolus!

### Corrections Appliquées:
1. ✅ **Erreur 500 Backend** - URLs avec slashes finaux ajoutés
2. ✅ **Overflow UI** - Widgets Row remplacés par Wrap
3. ✅ **Base de données** - SQLite déjà configuré (rien à installer)

---

## 🚀 Comment Tester Maintenant

### Option 1: Créer un Nouveau Compte

1. Ouvrez votre navigateur à: **http://localhost:3000**
2. Cliquez sur **"Créer un compte"**
3. Remplissez le formulaire:
   - Nom: Votre nom
   - Email: votre@email.com
   - Mot de passe: minimum 6 caractères
4. Cliquez sur **"S'inscrire"**

### Option 2: Utiliser le Compte de Test

1. Ouvrez votre navigateur à: **http://localhost:3000**
2. Utilisez ces identifiants:
   - **Email**: `test@test.com`
   - **Mot de passe**: `test123456`
3. Cliquez sur **"Se connecter"**

---

## 🔍 Vérifications

### 1. Backend Django (Port 8000)
Vérifiez que le backend tourne:
```bash
# Dans un navigateur, ouvrez:
http://localhost:8000/admin/
```
Vous devriez voir la page d'administration Django.

### 2. Frontend Flutter (Port 3000)
Vérifiez que le frontend tourne:
```bash
# Dans un navigateur, ouvrez:
http://localhost:3000
```
Vous devriez voir l'écran de connexion.

### 3. API Endpoints
Testez l'API directement:
```bash
# Test avec curl (dans PowerShell):
curl -X POST http://localhost:8000/api/auth/login/ -H "Content-Type: application/json" -d '{\"username\":\"test@test.com\",\"password\":\"test123456\"}'
```

---

## 🐛 Si Vous Voyez Encore des Erreurs

### Erreur: "Failed to load resource: 500"

**Cause**: L'application Flutter n'a pas rechargé les modifications

**Solution**:
1. Fermez complètement le navigateur
2. Arrêtez le serveur Flutter (Ctrl+C dans le terminal)
3. Redémarrez:
   ```bash
   cd frontend
   flutter run -d chrome --web-port=3000
   ```
4. Attendez que la compilation soit terminée
5. Ouvrez un nouvel onglet: http://localhost:3000

### Erreur: "Connection Refused"

**Cause**: Le backend Django n'est pas démarré

**Solution**:
```bash
cd backend
venv\Scripts\python.exe manage.py runserver
```

### Erreur: "Overflow 195 pixels"

**Cause**: Le navigateur a mis en cache l'ancienne version

**Solution**:
1. Appuyez sur **Ctrl + Shift + Delete**
2. Cochez "Images et fichiers en cache"
3. Cliquez "Effacer les données"
4. Rechargez la page avec **Ctrl + F5**

---

## 📊 État des Serveurs

Pour vérifier que tout tourne:

### Vérifier les ports:
```powershell
netstat -ano | findstr :8000
netstat -ano | findstr :3000
```

Vous devriez voir:
- Port 8000: Backend Django
- Port 3000: Frontend Flutter

---

## 🎨 Fonctionnalités Disponibles

Une fois connecté, vous pouvez:
- ✅ Voir le tableau de bord
- ✅ Rechercher des produits
- ✅ Voir les produits tendance
- ✅ Ajouter des favoris
- ✅ Voir votre profil
- ✅ Gérer votre abonnement

---

## 📝 Créer Plus d'Utilisateurs de Test

Si vous voulez créer plus d'utilisateurs:

```bash
cd backend
venv\Scripts\python.exe create_test_user.py
```

Ou manuellement via le shell Django:
```bash
venv\Scripts\python.exe manage.py shell
```

Puis:
```python
from django.contrib.auth.models import User
from core.models import UserProfile

user = User.objects.create_user(
    username='nouveau',
    email='nouveau@example.com',
    password='password123'
)
UserProfile.objects.create(user=user)
```

---

## 🔐 Accès Admin Django

Pour accéder à l'interface d'administration:

1. Créez un superuser:
   ```bash
   cd backend
   venv\Scripts\python.exe manage.py createsuperuser
   ```

2. Suivez les instructions pour créer un admin

3. Accédez à: **http://localhost:8000/admin/**

4. Connectez-vous avec vos identifiants admin

---

## 📚 Documentation API

Pour voir la documentation Swagger de l'API:

**http://localhost:8000/swagger/**

Vous y trouverez tous les endpoints disponibles avec leurs paramètres.

---

## ✨ Résumé Final

| Composant | URL | Statut |
|-----------|-----|--------|
| Frontend | http://localhost:3000 | ✅ Running |
| Backend | http://localhost:8000 | ✅ Running |
| Admin | http://localhost:8000/admin/ | ✅ Available |
| API Docs | http://localhost:8000/swagger/ | ✅ Available |
| Database | SQLite (db.sqlite3) | ✅ Working |

**Compte de test disponible:**
- Email: `test@test.com`
- Password: `test123456`

---

## 🎉 Tout Est Prêt!

Votre application Dropshipping Finder est maintenant complètement fonctionnelle!

**Prochaines étapes suggérées:**
1. Testez la création de compte
2. Testez la connexion
3. Explorez les fonctionnalités
4. Ajoutez des produits via l'admin Django
5. Testez la recherche et les filtres

Bon développement! 🚀
