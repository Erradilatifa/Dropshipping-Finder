# 🚀 Dropshipping Finder - Production Deployment Guide

Complete guide for deploying Dropshipping Finder to production.

---

## 📋 Pre-Deployment Checklist

### Security
- [ ] Change `SECRET_KEY` to a strong random value
- [ ] Set `DEBUG=False` in production
- [ ] Configure `ALLOWED_HOSTS` with your domain
- [ ] Enable HTTPS/SSL certificates
- [ ] Set up firewall rules
- [ ] Configure CORS properly
- [ ] Enable rate limiting
- [ ] Set up monitoring and logging

### Database
- [ ] PostgreSQL configured and optimized
- [ ] Database backups automated
- [ ] Connection pooling enabled
- [ ] Indexes created for performance

### Services
- [ ] Redis configured for caching
- [ ] Celery workers running
- [ ] Celery beat scheduler active
- [ ] Tor service running and secured

### Infrastructure
- [ ] Domain name registered
- [ ] DNS configured
- [ ] SSL certificate installed
- [ ] CDN configured (optional)
- [ ] Load balancer set up (if needed)

---

## 🖥️ Server Setup (Ubuntu 22.04)

### 1. Initial Server Configuration

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install essential packages
sudo apt install -y python3-pip python3-venv nginx postgresql postgresql-contrib redis-server tor git supervisor

# Create deployment user
sudo adduser dropshipping
sudo usermod -aG sudo dropshipping
```

### 2. Install and Configure PostgreSQL

```bash
# Switch to postgres user
sudo -u postgres psql

# Create database and user
CREATE DATABASE dropshipping_finder_prod;
CREATE USER df_prod WITH PASSWORD 'STRONG_PASSWORD_HERE';
ALTER ROLE df_prod SET client_encoding TO 'utf8';
ALTER ROLE df_prod SET default_transaction_isolation TO 'read committed';
ALTER ROLE df_prod SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE dropshipping_finder_prod TO df_prod;
\q

# Configure PostgreSQL for production
sudo nano /etc/postgresql/14/main/postgresql.conf
# Set: max_connections = 100
# Set: shared_buffers = 256MB
# Set: effective_cache_size = 1GB

sudo systemctl restart postgresql
```

### 3. Configure Redis

```bash
# Edit Redis config
sudo nano /etc/redis/redis.conf
# Set: maxmemory 256mb
# Set: maxmemory-policy allkeys-lru

sudo systemctl restart redis
```

### 4. Configure Tor

```bash
# Edit Tor config
sudo nano /etc/tor/torrc

# Add these lines:
SOCKSPort 9050
ControlPort 9051
HashedControlPassword YOUR_HASHED_PASSWORD
CookieAuthentication 0

# Generate hashed password
tor --hash-password "YOUR_PASSWORD"

sudo systemctl restart tor
```

---

## 🐍 Backend Deployment

### 1. Clone Repository

```bash
# Switch to deployment user
su - dropshipping

# Clone repository
cd /home/dropshipping
git clone https://github.com/your-org/dropshipping-finder.git
cd dropshipping-finder/backend
```

### 2. Setup Python Environment

```bash
# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install --upgrade pip
pip install -r requirements.txt
pip install gunicorn
```

### 3. Configure Environment

```bash
# Create production .env file
nano .env
```

```env
# Production Environment Variables
SECRET_KEY=generate-a-very-strong-secret-key-here
DEBUG=False
ALLOWED_HOSTS=yourdomain.com,www.yourdomain.com

# Database
DB_NAME=dropshipping_finder_prod
DB_USER=df_prod
DB_PASSWORD=STRONG_PASSWORD_HERE
DB_HOST=localhost
DB_PORT=5432

# Redis
REDIS_URL=redis://localhost:6379/0

# Tor
TOR_PROXY_HOST=127.0.0.1
TOR_PROXY_PORT=9050
TOR_CONTROL_PORT=9051
TOR_PASSWORD=YOUR_TOR_PASSWORD

# Email
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=noreply@yourdomain.com
EMAIL_HOST_PASSWORD=your-app-password
```

### 4. Run Migrations and Collect Static

```bash
# Run migrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser

# Collect static files
python manage.py collectstatic --noinput

# Populate sample data (optional)
python manage.py populate_sample_data --products 100
```

### 5. Configure Gunicorn

```bash
# Create Gunicorn config
nano /home/dropshipping/dropshipping-finder/backend/gunicorn_config.py
```

```python
import multiprocessing

bind = "127.0.0.1:8000"
workers = multiprocessing.cpu_count() * 2 + 1
worker_class = "sync"
worker_connections = 1000
max_requests = 1000
max_requests_jitter = 50
timeout = 30
keepalive = 2

# Logging
accesslog = "/home/dropshipping/logs/gunicorn-access.log"
errorlog = "/home/dropshipping/logs/gunicorn-error.log"
loglevel = "info"
```

```bash
# Create logs directory
mkdir -p /home/dropshipping/logs
```

### 6. Configure Supervisor for Gunicorn

```bash
sudo nano /etc/supervisor/conf.d/dropshipping-gunicorn.conf
```

```ini
[program:dropshipping-gunicorn]
directory=/home/dropshipping/dropshipping-finder/backend
command=/home/dropshipping/dropshipping-finder/backend/venv/bin/gunicorn dropshipping_finder.wsgi:application -c /home/dropshipping/dropshipping-finder/backend/gunicorn_config.py
user=dropshipping
autostart=true
autorestart=true
redirect_stderr=true
stdout_logfile=/home/dropshipping/logs/gunicorn-supervisor.log
```

### 7. Configure Supervisor for Celery

```bash
sudo nano /etc/supervisor/conf.d/dropshipping-celery.conf
```

```ini
[program:dropshipping-celery-worker]
directory=/home/dropshipping/dropshipping-finder/backend
command=/home/dropshipping/dropshipping-finder/backend/venv/bin/celery -A dropshipping_finder worker -l info
user=dropshipping
autostart=true
autorestart=true
redirect_stderr=true
stdout_logfile=/home/dropshipping/logs/celery-worker.log

[program:dropshipping-celery-beat]
directory=/home/dropshipping/dropshipping-finder/backend
command=/home/dropshipping/dropshipping-finder/backend/venv/bin/celery -A dropshipping_finder beat -l info
user=dropshipping
autostart=true
autorestart=true
redirect_stderr=true
stdout_logfile=/home/dropshipping/logs/celery-beat.log
```

### 8. Start Services

```bash
# Reload supervisor
sudo supervisorctl reread
sudo supervisorctl update

# Start all services
sudo supervisorctl start all

# Check status
sudo supervisorctl status
```

---

## 🌐 Nginx Configuration

### 1. Create Nginx Config

```bash
sudo nano /etc/nginx/sites-available/dropshipping-finder
```

```nginx
upstream dropshipping_backend {
    server 127.0.0.1:8000;
}

server {
    listen 80;
    server_name yourdomain.com www.yourdomain.com;
    
    # Redirect HTTP to HTTPS
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name yourdomain.com www.yourdomain.com;
    
    # SSL Configuration
    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    
    # Security Headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
    
    # Client upload size
    client_max_body_size 10M;
    
    # Static files
    location /static/ {
        alias /home/dropshipping/dropshipping-finder/backend/staticfiles/;
        expires 30d;
        add_header Cache-Control "public, immutable";
    }
    
    # Media files
    location /media/ {
        alias /home/dropshipping/dropshipping-finder/backend/media/;
        expires 7d;
    }
    
    # API and admin
    location / {
        proxy_pass http://dropshipping_backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_redirect off;
        
        # Timeouts
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }
    
    # Logging
    access_log /var/log/nginx/dropshipping-access.log;
    error_log /var/log/nginx/dropshipping-error.log;
}
```

### 2. Enable Site and SSL

```bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx

# Get SSL certificate
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com

# Enable site
sudo ln -s /etc/nginx/sites-available/dropshipping-finder /etc/nginx/sites-enabled/

# Test configuration
sudo nginx -t

# Restart Nginx
sudo systemctl restart nginx
```

---

## 📱 Mobile App Deployment

### Android (Google Play Store)

#### 1. Prepare for Release

```bash
cd frontend

# Update version in pubspec.yaml
version: 1.0.0+1

# Update API endpoint in .env
API_BASE_URL=https://api.yourdomain.com
```

#### 2. Generate Signing Key

```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

#### 3. Configure Signing

Create `android/key.properties`:
```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=upload
storeFile=/home/user/upload-keystore.jks
```

Update `android/app/build.gradle`:
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    ...
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

#### 4. Build Release APK

```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk

# Or build App Bundle (recommended)
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

#### 5. Upload to Play Store

1. Go to https://play.google.com/console
2. Create new app
3. Fill in store listing details
4. Upload app bundle
5. Set up pricing and distribution
6. Submit for review

### iOS (App Store)

```bash
# Build iOS app (macOS only)
flutter build ios --release

# Open in Xcode
open ios/Runner.xcworkspace

# Archive and upload via Xcode
```

---

## 🔄 Continuous Deployment

### GitHub Actions Workflow

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Production

on:
  push:
    branches: [ main ]

jobs:
  deploy-backend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Deploy to server
        uses: appleboy/ssh-action@master
        with:
          host: ${{ secrets.SERVER_HOST }}
          username: ${{ secrets.SERVER_USER }}
          key: ${{ secrets.SSH_PRIVATE_KEY }}
          script: |
            cd /home/dropshipping/dropshipping-finder
            git pull origin main
            cd backend
            source venv/bin/activate
            pip install -r requirements.txt
            python manage.py migrate
            python manage.py collectstatic --noinput
            sudo supervisorctl restart all

  deploy-mobile:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      
      - name: Build APK
        run: |
          cd frontend
          flutter pub get
          flutter build apk --release
      
      - name: Upload to Play Store
        # Configure Play Store upload
```

---

## 📊 Monitoring & Logging

### 1. Install Monitoring Tools

```bash
# Install Prometheus
sudo apt install prometheus

# Install Grafana
sudo apt install grafana
```

### 2. Configure Log Rotation

```bash
sudo nano /etc/logrotate.d/dropshipping
```

```
/home/dropshipping/logs/*.log {
    daily
    rotate 30
    compress
    delaycompress
    notifempty
    create 0640 dropshipping dropshipping
    sharedscripts
    postrotate
        supervisorctl restart all
    endscript
}
```

### 3. Set Up Alerts

Configure email alerts for:
- Server errors (500s)
- High CPU/memory usage
- Database connection issues
- Celery task failures

---

## 🔐 Security Hardening

### 1. Firewall Configuration

```bash
# Enable UFW
sudo ufw enable

# Allow SSH
sudo ufw allow 22/tcp

# Allow HTTP/HTTPS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Check status
sudo ufw status
```

### 2. Fail2Ban

```bash
# Install Fail2Ban
sudo apt install fail2ban

# Configure
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo nano /etc/fail2ban/jail.local

# Start service
sudo systemctl start fail2ban
sudo systemctl enable fail2ban
```

### 3. Regular Updates

```bash
# Create update script
nano /home/dropshipping/update.sh
```

```bash
#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
```

```bash
chmod +x /home/dropshipping/update.sh

# Add to crontab (weekly updates)
crontab -e
0 2 * * 0 /home/dropshipping/update.sh
```

---

## 📈 Performance Optimization

### 1. Database Optimization

```sql
-- Create indexes
CREATE INDEX idx_product_score ON core_product(score DESC);
CREATE INDEX idx_product_trending ON core_product(is_trending, score DESC);
CREATE INDEX idx_favorite_user ON core_favorite(user_id);

-- Analyze tables
ANALYZE core_product;
ANALYZE core_favorite;
```

### 2. Redis Caching

Configure Django caching in settings:

```python
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.redis.RedisCache',
        'LOCATION': 'redis://127.0.0.1:6379/1',
        'OPTIONS': {
            'CLIENT_CLASS': 'django_redis.client.DefaultClient',
        },
        'KEY_PREFIX': 'dropshipping',
        'TIMEOUT': 300,
    }
}
```

### 3. CDN Configuration

Use CloudFlare or AWS CloudFront for:
- Static files
- Media files
- API caching (for public endpoints)

---

## 🆘 Troubleshooting

### Check Service Status

```bash
# Gunicorn
sudo supervisorctl status dropshipping-gunicorn

# Celery
sudo supervisorctl status dropshipping-celery-worker
sudo supervisorctl status dropshipping-celery-beat

# Nginx
sudo systemctl status nginx

# PostgreSQL
sudo systemctl status postgresql

# Redis
sudo systemctl status redis
```

### View Logs

```bash
# Application logs
tail -f /home/dropshipping/logs/gunicorn-error.log

# Celery logs
tail -f /home/dropshipping/logs/celery-worker.log

# Nginx logs
tail -f /var/log/nginx/dropshipping-error.log
```

### Common Issues

**502 Bad Gateway**
- Check if Gunicorn is running
- Verify Nginx upstream configuration

**Database Connection Error**
- Check PostgreSQL is running
- Verify credentials in .env

**Celery Tasks Not Running**
- Check Redis connection
- Verify Celery worker is running

---

## ✅ Post-Deployment Checklist

- [ ] All services running
- [ ] SSL certificate valid
- [ ] Database backups configured
- [ ] Monitoring set up
- [ ] Error tracking enabled
- [ ] DNS propagated
- [ ] Mobile app published
- [ ] Documentation updated
- [ ] Team notified

---

**🎉 Deployment Complete!**

Your Dropshipping Finder application is now live in production.

**Support:** deployment@dropshippingfinder.com
