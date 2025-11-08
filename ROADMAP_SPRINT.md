# 🚀 Roadmap Sprint - Dropshipping Finder

**Projet**: Dropshipping Finder  
**Chef de Projet**: Celestin K. M. GNONOUGLO  
**Objectif**: Atteindre 90%+ de conformité au cahier des charges

---

## 📊 État Actuel

**Conformité**: 82%  
**Fonctionnalités Core**: ✅ Implémentées  
**Intégrations Externes**: ❌ À faire  
**Visualisations**: ⚠️ Basiques

---

## 🎯 Sprint 1 - Fonctionnalités Critiques (Semaines 1-2)

### Tâches Backend (4-5 jours)

1. **Recherche Avancée**
   - Créer endpoint `/api/products/advanced_search/`
   - Filtres: prix, score, volume, marge, catégorie, source
   - Endpoint `/api/products/autocomplete/` pour suggestions
   - Optimiser avec Elasticsearch si disponible

2. **Fiche Produit Enrichie**
   - Ajouter champs: `profit_margin`, `sales_volume`, `price_history`
   - Créer `ProductDetailSerializer` avec:
     - Analyse de rentabilité (coûts, marge, ROI)
     - Liste fournisseurs
     - Produits similaires
     - Historique prix (30 jours)
   - Endpoint `/api/products/{id}/similar/`

3. **Système d'Alertes**
   - Configurer Firebase Admin SDK
   - Créer service de notifications
   - Jobs Celery pour alertes automatiques
   - Endpoint `/api/alerts/send_test/`

### Tâches Frontend (5-6 jours)

1. **Recherche Avancée**
   - Écran `AdvancedSearchScreen`
   - Auto-complétion en temps réel
   - Bottom sheet de filtres
   - Chips de filtres actifs

2. **Fiche Produit**
   - Ajouter package `fl_chart: ^0.66.2`
   - Graphique d'évolution des prix
   - Card d'analyse de rentabilité
   - Section fournisseurs
   - Carrousel produits similaires

3. **Notifications Push**
   - Intégrer Firebase FCM
   - Écran de gestion des alertes
   - Demander permissions
   - Gérer réception notifications

---

## 🎯 Sprint 2 - Intégrations & Visualisations (Semaines 3-4)

### Backend (5-6 jours)

1. **Connecteurs API**
   - Module `integrations/aliexpress.py`
   - Module `integrations/amazon.py`
   - Module `integrations/google_trends.py`
   - Jobs Celery pour scraping automatique

2. **Web Scraping**
   - Installer Playwright/Puppeteer
   - Créer scrapers robustes
   - Gestion erreurs et retry
   - Rate limiting

### Frontend (4-5 jours)

1. **Tableau de Bord Analytique**
   - Graphiques de tendances (fl_chart)
   - KPI cards animés
   - Filtres par période
   - Export données

2. **Charte Graphique AGH**
   - Intégrer logo AGH
   - Créer `theme.dart` complet
   - Implémenter dark mode
   - Cohérence couleurs

---

## 🎯 Sprint 3 - Finalisation (Semaines 5-6)

### Tâches (3-4 jours)

1. **Support & FAQ**
   - Écran FAQ
   - Formulaire contact
   - Guide utilisateur

2. **Tests & Optimisations**
   - Tests d'acceptation
   - Optimisation performance
   - Correction bugs

3. **Déploiement**
   - Configuration production
   - Documentation
   - Release v1.0

---

## 📋 Checklist Prioritaire

### Cette Semaine
- [ ] Endpoint recherche avancée
- [ ] Autocomplete API
- [ ] Écran recherche Flutter
- [ ] Enrichir fiche produit backend
- [ ] Graphiques fl_chart

### Semaine Prochaine
- [ ] Firebase FCM
- [ ] Connecteur AliExpress
- [ ] Tableau de bord analytique
- [ ] Logo AGH + dark mode

### Moyen Terme
- [ ] Support & FAQ
- [ ] Tests utilisateurs
- [ ] Optimisations
- [ ] Release production

---

## 🎯 Objectifs de Conformité

**Objectif Sprint 1**: 88% conformité  
**Objectif Sprint 2**: 93% conformité  
**Objectif Sprint 3**: 95%+ conformité

---

**Dernière mise à jour**: 8 Novembre 2025
