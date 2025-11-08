# ⚡ Dropshipping Finder - Quick Start Guide

Get up and running in 10 minutes!

---

## 🚀 Prerequisites

Make sure you have installed:
- **Python 3.10+**
- **Flutter 3.x**
- **PostgreSQL 14+**
- **Redis 6+**
- **Tor** (optional for development)

---

## 📱 Option 1: Mobile App Only (Fastest)

If you just want to run the mobile app with mock data:

```bash
# Navigate to frontend
cd frontend

# Install dependencies
flutter pub get

# Run the app
flutter run
```

**Note**: This will run with mock/sample data. For full functionality, set up the backend.

---

## 🔧 Option 2: Full Stack Setup

### Step 1: Clone Repository

```bash
git clone https://github.com/your-org/dropshipping-finder.git
cd dropshipping-finder
```

### Step 2: Backend Setup (5 minutes)

```bash
# Navigate to backend
cd backend

# Create virtual environment
python -m venv venv

# Activate virtual environment
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Copy environment file
cp .env.example .env

# Edit .env with your database credentials
# (Use any text editor)
```

**Minimal .env configuration:**
```env
SECRET_KEY=your-secret-key-change-this
DEBUG=True
DB_NAME=dropshipping_finder
DB_USER=postgres
DB_PASSWORD=your_postgres_password
DB_HOST=localhost
DB_PORT=5432
REDIS_URL=redis://localhost:6379/0
```

```bash
# Create database
# In PostgreSQL:
# CREATE DATABASE dropshipping_finder;

# Run migrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser

# Load sample data
python manage.py populate_sample_data --products 50

# Start server
python manage.py runserver
```

**Backend is now running at**: http://localhost:8000

### Step 3: Frontend Setup (3 minutes)

Open a new terminal:

```bash
# Navigate to frontend
cd frontend

# Install dependencies
flutter pub get

# Configure API endpoint
# Edit .env file:
API_BASE_URL=http://localhost:8000/api

# For Android emulator, use:
API_BASE_URL=http://10.0.2.2:8000/api

# Run the app
flutter run
```

**Done!** 🎉

---

## 🧪 Test the Application

### Test Backend API

1. **Admin Panel**: http://localhost:8000/admin
   - Login with superuser credentials
   - View products, users, etc.

2. **API Documentation**: http://localhost:8000/swagger/
   - Interactive API explorer
   - Test endpoints directly

3. **Test API Endpoint**:
```bash
curl http://localhost:8000/api/products/
```

### Test Mobile App

1. **Onboarding**: Swipe through welcome screens
2. **Login**: Use superuser credentials or create new account
3. **Browse Products**: View sample products
4. **Search**: Try searching for products
5. **Favorites**: Add products to favorites
6. **Profile**: View and edit profile

---

## 🔑 Default Credentials

After running `populate_sample_data`, you can use:

**Test Users:**
- Username: `user1` / Password: `password123`
- Username: `user2` / Password: `password123`

**Admin:**
- Use the superuser you created

---

## 📊 Sample Data

The `populate_sample_data` command creates:
- ✅ 5 sample users
- ✅ 50 sample products
- ✅ Random favorites
- ✅ Trend alerts

To create more data:
```bash
python manage.py populate_sample_data --users 10 --products 100
```

---

## 🛠️ Common Issues & Solutions

### Issue: Database Connection Error

**Solution:**
```bash
# Make sure PostgreSQL is running
# Windows: Check Services
# Linux: sudo systemctl status postgresql
# macOS: brew services list

# Verify credentials in .env match your PostgreSQL setup
```

### Issue: Redis Connection Error

**Solution:**
```bash
# Make sure Redis is running
# Windows: Check Services
# Linux: sudo systemctl status redis
# macOS: brew services list

# Test Redis:
redis-cli ping
# Should return: PONG
```

### Issue: Flutter Build Error

**Solution:**
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

### Issue: API Not Accessible from Android Emulator

**Solution:**
```bash
# Use 10.0.2.2 instead of localhost in .env
API_BASE_URL=http://10.0.2.2:8000/api
```

---

## 📱 Run on Different Devices

### Android Emulator
```bash
flutter run
# Select Android emulator from list
```

### iOS Simulator (macOS only)
```bash
flutter run
# Select iOS simulator from list
```

### Physical Device
```bash
# Enable USB debugging on device
# Connect via USB
flutter devices
flutter run -d <device-id>
```

### Web Browser
```bash
flutter run -d chrome
```

---

## 🔄 Background Services (Optional)

For full functionality, run these in separate terminals:

### Terminal 1: Django Server
```bash
cd backend
source venv/bin/activate  # or venv\Scripts\activate on Windows
python manage.py runserver
```

### Terminal 2: Celery Worker
```bash
cd backend
source venv/bin/activate
celery -A dropshipping_finder worker -l info
```

### Terminal 3: Celery Beat (Scheduled Tasks)
```bash
cd backend
source venv/bin/activate
celery -A dropshipping_finder beat -l info
```

---

## 🎯 Next Steps

Now that you're up and running:

1. **Explore the Code**
   - Check out `frontend/lib/screens/` for UI screens
   - Look at `backend/api/views.py` for API endpoints
   - Review `backend/ai_engine/scoring.py` for AI logic

2. **Read Documentation**
   - [Setup Guide](SETUP_GUIDE.md) - Detailed setup instructions
   - [API Documentation](API_DOCUMENTATION.md) - Complete API reference
   - [Deployment Guide](DEPLOYMENT.md) - Production deployment

3. **Customize**
   - Modify colors in `frontend/lib/utils/theme.dart`
   - Add new features
   - Integrate real scraping sources

4. **Deploy**
   - Follow [DEPLOYMENT.md](DEPLOYMENT.md) for production setup

---

## 📚 Useful Commands

### Backend
```bash
# Create new migration
python manage.py makemigrations

# Apply migrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser

# Run tests
pytest

# Collect static files
python manage.py collectstatic

# Django shell
python manage.py shell
```

### Frontend
```bash
# Run app
flutter run

# Build APK
flutter build apk

# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
flutter format .

# Clean build
flutter clean
```

---

## 🆘 Getting Help

**Documentation:**
- [README.md](README.md) - Project overview
- [SETUP_GUIDE.md](SETUP_GUIDE.md) - Detailed setup
- [API_DOCUMENTATION.md](API_DOCUMENTATION.md) - API reference

**Support:**
- GitHub Issues: Report bugs
- Email: support@dropshippingfinder.com
- Discord: Join our community

---

## ✅ Verification Checklist

Make sure everything is working:

- [ ] Backend server running at http://localhost:8000
- [ ] Can access admin panel at http://localhost:8000/admin
- [ ] API docs available at http://localhost:8000/swagger/
- [ ] Mobile app launches successfully
- [ ] Can login to mobile app
- [ ] Products are visible in app
- [ ] Can add products to favorites
- [ ] Search functionality works

---

**🎉 You're all set! Happy coding!**

For questions or issues, check the documentation or reach out to support.

**Built with ❤️ by AGH - Data Agency Holding SA**
