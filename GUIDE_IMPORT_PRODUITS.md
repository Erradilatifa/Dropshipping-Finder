# 📦 Guide d'Import Automatique de Produits

**Date**: 8 Novembre 2025  
**Projet**: Dropshipping Finder  
**Chef de Projet**: Celestin K. M. GNONOUGLO

---

## 🎯 Vue d'Ensemble

Le système d'import automatique permet de collecter des produits depuis plusieurs sources externes:
- ✅ **AliExpress** (Implémenté)
- 🔜 **Amazon** (À venir)
- 🔜 **Shopify** (À venir)
- 🔜 **Google Trends** (À venir)

---

## 🚀 Méthodes d'Import

### 1. **Import Manuel via Commande Django**

#### Import par Recherche
```bash
cd backend
python manage.py import_products "wireless earbuds" --pages=3
```

#### Import de Produits Tendance
```bash
python manage.py import_products --trending
```

#### Options Disponibles
- `--pages=N` : Nombre de pages à scraper (défaut: 3)
- `--no-tor` : Désactiver le proxy Tor
- `--trending` : Importer les catégories populaires

### 2. **Import Automatique via Celery**

#### Démarrer Celery Worker
```bash
cd backend
celery -A dropshipping_finder worker -l info
```

#### Démarrer Celery Beat (Tâches Planifiées)
```bash
celery -A dropshipping_finder beat -l info
```

#### Lancer une Tâche Manuellement
```python
from integrations.tasks import sync_aliexpress_products

# Import immédiat
sync_aliexpress_products.delay("smart watch", max_pages=5)

# Import planifié
sync_aliexpress_products.apply_async(
    args=["phone accessories", 3],
    countdown=60  # Dans 60 secondes
)
```

### 3. **Import via Interface Admin**

Accédez à: `http://localhost:8000/admin/`

1. Allez dans **Core → Products**
2. Cliquez sur **Import Products** (action personnalisée)
3. Entrez la requête de recherche
4. Sélectionnez la source (AliExpress, Amazon, etc.)
5. Cliquez sur **Import**

---

## 📊 Processus d'Import Détaillé

### Étape 1: Collecte des Données
```
Source externe → Scraping/API → Données brutes
```

### Étape 2: Normalisation
```python
{
    'title': 'Wireless Earbuds Bluetooth 5.0',
    'price': 15.99,
    'sales_volume': 5234,
    'rating': 4.5,
    'source_platform': 'aliexpress',
    'source_url': 'https://...',
    ...
}
```

### Étape 3: Calcul du Score AI
```python
product.calculate_ai_score()
# Score basé sur 20+ critères:
# - Prix
# - Volume de ventes
# - Note moyenne
# - Nombre d'avis
# - Taux de croissance
# - Viralité
# - Marge potentielle
```

### Étape 4: Stockage en Base
```
Base de données → Indexation → Affichage dans l'app
```

---

## 🔧 Configuration

### 1. Installer les Dépendances
```bash
pip install beautifulsoup4 requests celery redis
```

### 2. Configurer Celery (settings.py)
```python
# Celery Configuration
CELERY_BROKER_URL = 'redis://localhost:6379/0'
CELERY_RESULT_BACKEND = 'redis://localhost:6379/0'
CELERY_ACCEPT_CONTENT = ['json']
CELERY_TASK_SERIALIZER = 'json'
CELERY_RESULT_SERIALIZER = 'json'
CELERY_TIMEZONE = 'UTC'

# Scheduled Tasks
from celery.schedules import crontab

CELERY_BEAT_SCHEDULE = {
    'sync-trending-products-daily': {
        'task': 'integrations.sync_trending_products',
        'schedule': crontab(hour=2, minute=0),  # Tous les jours à 2h
    },
    'update-product-scores-hourly': {
        'task': 'integrations.update_product_scores',
        'schedule': crontab(minute=0),  # Toutes les heures
    },
    'cleanup-old-products-weekly': {
        'task': 'integrations.cleanup_old_products',
        'schedule': crontab(day_of_week=0, hour=3, minute=0),  # Dimanche 3h
    },
}
```

### 3. Configurer Tor (Optionnel)
```bash
# Windows
choco install tor

# Linux
sudo apt-get install tor

# Démarrer Tor
tor
```

---

## 📈 Planification Automatique

### Tâches Planifiées Recommandées

| Tâche | Fréquence | Heure | Description |
|-------|-----------|-------|-------------|
| **Sync Trending** | Quotidien | 02:00 | Import produits tendance |
| **Update Scores** | Horaire | XX:00 | Recalcul scores AI |
| **Cleanup Old** | Hebdomadaire | Dim 03:00 | Suppression produits obsolètes |
| **Sync Popular** | 2x/jour | 08:00, 20:00 | Import catégories populaires |

---

## 🎯 Catégories Populaires

Les catégories suivantes sont automatiquement importées:

1. **Phone Accessories** (Accessoires téléphone)
2. **Smart Watch** (Montres connectées)
3. **Wireless Earbuds** (Écouteurs sans fil)
4. **LED Lights** (Éclairage LED)
5. **Home Decor** (Décoration maison)
6. **Fitness Equipment** (Équipement fitness)
7. **Beauty Products** (Produits beauté)
8. **Pet Supplies** (Fournitures animaux)

---

## 📊 Statistiques d'Import

### Exemple de Résultat
```
============================================================
✅ Import completed!
============================================================
Total products found: 120
✅ Products created: 85
🔄 Products updated: 35
❌ Errors: 0
============================================================
```

---

## 🔍 Vérification des Produits Importés

### Via Django Shell
```python
python manage.py shell

from core.models import Product

# Compter les produits
Product.objects.count()

# Produits par plateforme
Product.objects.filter(source_platform='aliexpress').count()

# Produits avec score élevé
Product.objects.filter(ai_score__gte=80).count()

# Derniers produits importés
Product.objects.order_by('-created_at')[:10]
```

### Via Admin
1. Allez sur `http://localhost:8000/admin/core/product/`
2. Filtrez par:
   - Source Platform
   - AI Score
   - Date Created
   - Sales Volume

---

## 🚨 Gestion des Erreurs

### Erreurs Courantes

#### 1. Rate Limiting
**Problème**: Trop de requêtes en peu de temps  
**Solution**: 
- Activer Tor (`use_tor=True`)
- Augmenter les délais entre requêtes
- Réduire le nombre de pages

#### 2. Changement de Structure HTML
**Problème**: Le site a changé sa structure  
**Solution**: 
- Mettre à jour les sélecteurs CSS dans `aliexpress_connector.py`
- Vérifier les logs pour identifier les éléments manquants

#### 3. Connexion Refusée
**Problème**: Blocage IP ou firewall  
**Solution**:
- Utiliser Tor
- Changer de proxy
- Attendre quelques heures

---

## 📝 Logs et Monitoring

### Consulter les Logs
```bash
# Logs Django
tail -f backend/logs/django.log

# Logs Celery
tail -f backend/logs/celery.log
```

### Monitoring Celery
```bash
# Flower (interface web)
pip install flower
celery -A dropshipping_finder flower

# Accès: http://localhost:5555
```

---

## 🎯 Prochaines Étapes

### Sprint 1 (En cours)
- [x] Connecteur AliExpress
- [x] Tâches Celery
- [x] Commande Django
- [ ] Tests unitaires
- [ ] Documentation API

### Sprint 2 (À venir)
- [ ] Connecteur Amazon
- [ ] Connecteur Shopify
- [ ] Connecteur Google Trends
- [ ] Interface admin améliorée
- [ ] Notifications d'import

---

## 💡 Exemples d'Utilisation

### Exemple 1: Import Rapide
```bash
# Importer 40 produits "wireless earbuds"
python manage.py import_products "wireless earbuds" --pages=2
```

### Exemple 2: Import Massif
```bash
# Importer toutes les catégories tendance
python manage.py import_products --trending
```

### Exemple 3: Import Programmé
```python
# Dans Django shell
from integrations.tasks import sync_aliexpress_products
from celery.schedules import crontab

# Tous les jours à 2h du matin
sync_aliexpress_products.apply_async(
    args=["smart watch", 5],
    eta=datetime(2025, 11, 9, 2, 0, 0)
)
```

---

## 📞 Support

**Chef de Projet**: Celestin K. M. GNONOUGLO  
**Email**: gnonouglocelestin@gmail.com  
**Entreprise**: AGH - Data Agency Holding SA

---

## ✅ Checklist de Démarrage

- [ ] Installer les dépendances (`pip install -r requirements.txt`)
- [ ] Configurer Redis (`redis-server`)
- [ ] Démarrer Celery Worker
- [ ] Démarrer Celery Beat
- [ ] Tester l'import manuel
- [ ] Vérifier les produits dans l'admin
- [ ] Configurer les tâches planifiées
- [ ] Activer Tor (optionnel)

---

**Date de création**: 8 Novembre 2025  
**Version**: 1.0  
**Statut**: ✅ Opérationnel
