# 🚀 Dropshipping Finder - Complete Setup Guide

This guide will walk you through setting up the complete Dropshipping Finder application, including the Flutter frontend and Django backend with Tor integration.

## 📋 Prerequisites

### Required Software
- **Python 3.10+** - Backend development
- **Flutter 3.x** - Mobile app development
- **PostgreSQL 14+** - Database
- **Redis 6+** - Caching and Celery broker
- **Tor Browser/Service** - Anonymous scraping
- **Node.js 16+** (optional) - For some build tools

### System Requirements
- **OS:** Windows 10/11, macOS 10.15+, or Linux
- **RAM:** Minimum 8GB (16GB recommended)
- **Storage:** 5GB free space

---

## 🔧 Backend Setup (Django)

### 1. Install Tor

#### Windows
1. Download Tor Expert Bundle from https://www.torproject.org/download/tor/
2. Extract to `C:\tor`
3. Create `torrc` config file:
```
SOCKSPort 9050
ControlPort 9051
HashedControlPassword 16:YOUR_HASHED_PASSWORD
```
4. Run Tor: `tor.exe -f torrc`

#### Linux/macOS
```bash
# Ubuntu/Debian
sudo apt-get install tor

# macOS
brew install tor

# Start Tor
sudo systemctl start tor  # Linux
brew services start tor   # macOS
```

### 2. Install PostgreSQL

#### Windows
1. Download from https://www.postgresql.org/download/
2. Install with default settings
3. Remember your postgres password

#### Linux
```bash
sudo apt-get install postgresql postgresql-contrib
sudo systemctl start postgresql
```

#### macOS
```bash
brew install postgresql
brew services start postgresql
```

### 3. Create Database
```bash
# Access PostgreSQL
psql -U postgres

# Create database
CREATE DATABASE dropshipping_finder;
CREATE USER df_user WITH PASSWORD 'your_password';
GRANT ALL PRIVILEGES ON DATABASE dropshipping_finder TO df_user;
\q
```

### 4. Install Redis

#### Windows
1. Download from https://github.com/microsoftarchive/redis/releases
2. Install and start service

#### Linux
```bash
sudo apt-get install redis-server
sudo systemctl start redis
```

#### macOS
```bash
brew install redis
brew services start redis
```

### 5. Setup Python Environment

```bash
cd backend

# Create virtual environment
python -m venv venv

# Activate virtual environment
# Windows
venv\Scripts\activate
# Linux/macOS
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

### 6. Configure Environment

```bash
# Copy example env file
cp .env.example .env

# Edit .env with your settings
# Update database credentials, Tor settings, etc.
```

### 7. Run Migrations

```bash
python manage.py makemigrations
python manage.py migrate
```

### 8. Create Superuser

```bash
python manage.py createsuperuser
```

### 9. Start Development Server

```bash
# Terminal 1: Django server
python manage.py runserver

# Terminal 2: Celery worker
celery -A dropshipping_finder worker -l info

# Terminal 3: Celery beat (scheduled tasks)
celery -A dropshipping_finder beat -l info
```

### 10. Verify Backend

- Django Admin: http://localhost:8000/admin
- API Docs: http://localhost:8000/swagger/
- Test API: http://localhost:8000/api/

---

## 📱 Frontend Setup (Flutter)

### 1. Install Flutter

#### Windows
1. Download Flutter SDK from https://flutter.dev/docs/get-started/install/windows
2. Extract to `C:\flutter`
3. Add to PATH: `C:\flutter\bin`

#### Linux/macOS
```bash
# Download Flutter
git clone https://github.com/flutter/flutter.git -b stable

# Add to PATH (add to ~/.bashrc or ~/.zshrc)
export PATH="$PATH:`pwd`/flutter/bin"
```

### 2. Verify Flutter Installation

```bash
flutter doctor
```

Fix any issues reported by `flutter doctor`.

### 3. Install Dependencies

```bash
cd frontend
flutter pub get
```

### 4. Configure API Endpoint

Edit `frontend/.env`:
```
API_BASE_URL=http://localhost:8000/api
TOR_PROXY_URL=socks5://127.0.0.1:9050
```

For Android emulator, use `10.0.2.2` instead of `localhost`:
```
API_BASE_URL=http://10.0.2.2:8000/api
```

### 5. Run the App

```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device_id>

# Or just run (will prompt for device)
flutter run
```

### 6. Build for Production

#### Android APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

#### iOS (macOS only)
```bash
flutter build ios --release
```

---

## 🔐 Tor Configuration

### Generate Tor Password

```bash
# Linux/macOS
tor --hash-password "your_password"

# Windows
tor.exe --hash-password "your_password"
```

Copy the hashed password to your `torrc` file and `.env`.

### Test Tor Connection

```python
# In Django shell
python manage.py shell

from tor_proxy.tor_client import get_tor_manager

manager = get_tor_manager()
result = manager.verify_connection()
print(result)
```

---

## 🧪 Testing

### Backend Tests

```bash
cd backend
pytest
```

### Frontend Tests

```bash
cd frontend
flutter test
```

---

## 📊 Populate Sample Data

### Option 1: Django Admin
1. Go to http://localhost:8000/admin
2. Manually add products, categories, etc.

### Option 2: Management Command (Create this)

```bash
python manage.py populate_sample_data
```

### Option 3: API

Use the Swagger UI at http://localhost:8000/swagger/ to create data via API.

---

## 🚀 Production Deployment

### Backend (Django)

#### Using Gunicorn + Nginx

```bash
# Install gunicorn
pip install gunicorn

# Run with gunicorn
gunicorn dropshipping_finder.wsgi:application --bind 0.0.0.0:8000
```

#### Nginx Configuration

```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /static/ {
        alias /path/to/staticfiles/;
    }

    location /media/ {
        alias /path/to/media/;
    }
}
```

#### Environment Variables

```bash
# Production settings
DEBUG=False
ALLOWED_HOSTS=your-domain.com,www.your-domain.com
SECRET_KEY=generate-a-strong-secret-key
```

### Frontend (Flutter)

#### Build Release APK

```bash
# Generate keystore
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key

# Configure in android/key.properties
storePassword=<password>
keyPassword=<password>
keyAlias=key
storeFile=<path-to-key.jks>

# Build
flutter build apk --release
```

#### Publish to Play Store
1. Create Google Play Developer account
2. Create new app
3. Upload APK from `build/app/outputs/flutter-apk/app-release.apk`
4. Fill in store listing details
5. Submit for review

---

## 🔍 Troubleshooting

### Backend Issues

**Database Connection Error**
```bash
# Check PostgreSQL is running
sudo systemctl status postgresql

# Verify credentials in .env
# Test connection
psql -U df_user -d dropshipping_finder
```

**Tor Connection Failed**
```bash
# Check Tor is running
ps aux | grep tor

# Test Tor proxy
curl --socks5 127.0.0.1:9050 https://check.torproject.org/api/ip
```

**Redis Connection Error**
```bash
# Check Redis is running
redis-cli ping
# Should return: PONG
```

### Frontend Issues

**API Connection Failed**
- Check backend is running
- Verify API_BASE_URL in .env
- For Android emulator, use `10.0.2.2` instead of `localhost`

**Build Errors**
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

---

## 📚 Additional Resources

### Documentation
- Django: https://docs.djangoproject.com/
- Flutter: https://flutter.dev/docs
- Tor: https://www.torproject.org/docs/
- PostgreSQL: https://www.postgresql.org/docs/

### API Documentation
- Swagger UI: http://localhost:8000/swagger/
- ReDoc: http://localhost:8000/redoc/

### Support
- GitHub Issues: https://github.com/your-repo/issues
- Email: support@dropshippingfinder.com

---

## 🎯 Next Steps

1. **Configure Scraping Jobs**: Set up periodic tasks to scrape products
2. **Train AI Models**: Improve scoring algorithms with real data
3. **Add Payment Integration**: Implement Stripe/PayPal for subscriptions
4. **Enable Push Notifications**: Set up Firebase for mobile notifications
5. **Implement Analytics**: Add Google Analytics or Mixpanel
6. **Add More Sources**: Integrate additional e-commerce platforms

---

## 📝 Development Workflow

### Git Workflow

```bash
# Create feature branch
git checkout -b feature/new-feature

# Make changes and commit
git add .
git commit -m "Add new feature"

# Push to remote
git push origin feature/new-feature

# Create pull request on GitHub
```

### Code Quality

```bash
# Backend
black .  # Format code
flake8 .  # Lint code

# Frontend
flutter analyze  # Analyze code
flutter format .  # Format code
```

---

**🎉 Congratulations! Your Dropshipping Finder application is now set up and ready to use!**

For questions or issues, please refer to the documentation or contact support.
