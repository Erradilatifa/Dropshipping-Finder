# 🔐 Accès Administration - Dropshipping Finder

## 📍 Chemins d'Accès

### 🎨 Frontend (Application Flutter)
**URL**: http://localhost:3000
- Page de connexion
- Interface utilisateur principale
- Tableau de bord

### ⚙️ Backend API (Django)
**URL**: http://localhost:8000/api/
- API REST pour l'application
- Endpoints d'authentification
- Gestion des produits

### 👨‍💼 Interface Admin Django
**URL**: http://localhost:8000/admin/
- Gestion complète de la base de données
- Gestion des utilisateurs
- Gestion des produits
- Configuration du système

### 📚 Documentation API (Swagger)
**URL**: http://localhost:8000/swagger/
- Documentation interactive de l'API
- Test des endpoints
- Schémas de données

---

## 🔑 Créer un Compte Admin

Pour accéder à l'interface admin Django, vous devez créer un superuser:

### Étape 1: Ouvrir le terminal dans le dossier backend
```bash
cd C:\Users\DELL\CascadeProjects\dropshipping-finder\backend
```

### Étape 2: Créer le superuser
```bash
venv\Scripts\python.exe manage.py createsuperuser
```

### Étape 3: Suivre les instructions
Le système vous demandera:
1. **Username** (nom d'utilisateur): Par exemple `admin`
2. **Email**: Votre email (par exemple `admin@example.com`)
3. **Password**: Votre mot de passe (minimum 8 caractères)
4. **Password (again)**: Confirmer le mot de passe

### Exemple:
```
Username: admin
Email address: admin@example.com
Password: ********
Password (again): ********
Superuser created successfully.
```

---

## 🚀 Démarrer le Projet

### Méthode 1: Démarrage Manuel

#### Terminal 1 - Backend:
```bash
cd C:\Users\DELL\CascadeProjects\dropshipping-finder\backend
venv\Scripts\python.exe manage.py runserver
```

#### Terminal 2 - Frontend:
```bash
cd C:\Users\DELL\CascadeProjects\dropshipping-finder\frontend
flutter run -d chrome --web-port=3000
```

### Méthode 2: Script PowerShell (Créer ce fichier)

Créez un fichier `start.ps1` à la racine du projet:
```powershell
# Démarrer le backend
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd backend; venv\Scripts\python.exe manage.py runserver"

# Attendre 3 secondes
Start-Sleep -Seconds 3

# Démarrer le frontend
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd frontend; flutter run -d chrome --web-port=3000"
```

Puis exécutez:
```bash
.\start.ps1
```

---

## 📊 Vérifier que tout fonctionne

### Backend (Django):
```bash
# Vérifier le port 8000
netstat -ano | findstr :8000
```

### Frontend (Flutter):
```bash
# Vérifier le port 3000
netstat -ano | findstr :3000
```

---

## 🎯 Accès Rapide

Une fois les serveurs démarrés, ouvrez ces URLs dans votre navigateur:

| Service | URL | Description |
|---------|-----|-------------|
| **Application** | http://localhost:3000 | Interface utilisateur |
| **Admin Django** | http://localhost:8000/admin/ | Panneau d'administration |
| **API Swagger** | http://localhost:8000/swagger/ | Documentation API |
| **API Root** | http://localhost:8000/api/ | Point d'entrée API |

---

## 👥 Comptes Disponibles

### Compte de Test (Application)
- **Email**: test@test.com
- **Mot de passe**: test123456

### Compte Admin (À créer)
Utilisez la commande `createsuperuser` ci-dessus pour créer votre compte admin.

---

## 🛠️ Commandes Utiles

### Voir les logs Django:
```bash
cd backend
Get-Content logs\django.log -Tail 50
```

### Créer un utilisateur de test:
```bash
cd backend
venv\Scripts\python.exe create_test_user.py
```

### Migrations de base de données:
```bash
cd backend
venv\Scripts\python.exe manage.py makemigrations
venv\Scripts\python.exe manage.py migrate
```

### Collecter les fichiers statiques:
```bash
cd backend
venv\Scripts\python.exe manage.py collectstatic
```

---

## 🔒 Sécurité

⚠️ **Important pour la production:**
1. Changez le `SECRET_KEY` dans `settings.py`
2. Mettez `DEBUG = False`
3. Configurez `ALLOWED_HOSTS` correctement
4. Utilisez PostgreSQL au lieu de SQLite
5. Configurez HTTPS
6. Utilisez des mots de passe forts

---

## 📱 Accès depuis un autre appareil

Pour accéder depuis un autre appareil sur le même réseau:

1. Trouvez votre adresse IP locale:
```bash
ipconfig
```

2. Utilisez cette IP au lieu de `localhost`:
- Frontend: `http://VOTRE_IP:3000`
- Backend: `http://VOTRE_IP:8000`

3. Ajoutez votre IP dans `backend/dropshipping_finder/settings.py`:
```python
ALLOWED_HOSTS = ['localhost', '127.0.0.1', 'VOTRE_IP']
```

---

## ✅ Checklist de Démarrage

- [ ] Backend Django démarré (port 8000)
- [ ] Frontend Flutter démarré (port 3000)
- [ ] Superuser créé pour l'admin
- [ ] Accès à http://localhost:3000 fonctionne
- [ ] Accès à http://localhost:8000/admin/ fonctionne
- [ ] Connexion avec le compte test réussie

---

## 🆘 En Cas de Problème

### Port déjà utilisé:
```bash
# Trouver le processus
netstat -ano | findstr :8000
# Tuer le processus (remplacer PID par le numéro)
taskkill /F /PID <PID>
```

### Erreur de migration:
```bash
cd backend
venv\Scripts\python.exe manage.py migrate
```

### Cache Flutter:
```bash
cd frontend
flutter clean
flutter pub get
```

---

## 📞 Support

Pour plus d'informations, consultez:
- `DATABASE_INFO.md` - Informations sur la base de données
- `SOLUTION_COMPLETE.md` - Solutions aux problèmes courants
- `INSTRUCTIONS_TEST.md` - Instructions de test

---

**Projet**: Dropshipping Finder
**Version**: 1.0.0
**Développé pour**: AGH - Data Agency Holding SA
