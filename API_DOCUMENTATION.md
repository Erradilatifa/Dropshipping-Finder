# 📡 Dropshipping Finder API Documentation

Complete API reference for the Dropshipping Finder platform.

**Base URL:** `http://localhost:8000/api`  
**Production URL:** `https://api.dropshippingfinder.com`

---

## 🔐 Authentication

All API endpoints (except registration and login) require JWT authentication.

### Register New User

**POST** `/api/auth/register/`

**Request Body:**
```json
{
  "username": "john_doe",
  "email": "john@example.com",
  "password": "securePassword123",
  "password_confirm": "securePassword123",
  "first_name": "John",
  "last_name": "Doe"
}
```

**Response:**
```json
{
  "user": {
    "id": 1,
    "username": "john_doe",
    "email": "john@example.com",
    "first_name": "John",
    "last_name": "Doe"
  },
  "token": "eyJ0eXAiOiJKV1QiLCJhbGc...",
  "refresh": "eyJ0eXAiOiJKV1QiLCJhbGc..."
}
```

### Login

**POST** `/api/auth/login/`

**Request Body:**
```json
{
  "username": "john_doe",
  "password": "securePassword123"
}
```

**Response:**
```json
{
  "user": {
    "id": 1,
    "username": "john_doe",
    "email": "john@example.com"
  },
  "profile": {
    "subscription_plan": "pro",
    "profitability_score": 87
  },
  "token": "eyJ0eXAiOiJKV1QiLCJhbGc...",
  "refresh": "eyJ0eXAiOiJKV1QiLCJhbGc..."
}
```

### Refresh Token

**POST** `/api/auth/token/refresh/`

**Request Body:**
```json
{
  "refresh": "eyJ0eXAiOiJKV1QiLCJhbGc..."
}
```

**Response:**
```json
{
  "access": "eyJ0eXAiOiJKV1QiLCJhbGc..."
}
```

### Using Authentication

Include the JWT token in the Authorization header:

```
Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGc...
```

---

## 👤 User Management

### Get Current User Profile

**GET** `/api/profiles/my_profile/`

**Response:**
```json
{
  "id": 1,
  "user": {
    "id": 1,
    "username": "john_doe",
    "email": "john@example.com"
  },
  "subscription_plan": "pro",
  "profitability_score": 87,
  "favorite_count": 12,
  "view_count": 847,
  "notifications_enabled": true
}
```

### Update Subscription

**POST** `/api/profiles/update_subscription/`

**Request Body:**
```json
{
  "plan": "premium"
}
```

**Response:**
```json
{
  "subscription_plan": "premium",
  "message": "Subscription updated successfully"
}
```

### Toggle Notifications

**POST** `/api/profiles/toggle_notifications/`

**Request Body:**
```json
{
  "enabled": false
}
```

---

## 📦 Products

### List Products

**GET** `/api/products/`

**Query Parameters:**
- `page` (int): Page number (default: 1)
- `page_size` (int): Items per page (default: 20)
- `search` (string): Search query
- `category` (string): Filter by category
- `source` (string): Filter by source (aliexpress, amazon, shopify)
- `is_trending` (boolean): Filter trending products
- `ordering` (string): Sort field (-score, price, -created_at)

**Example:**
```
GET /api/products/?category=tech&ordering=-score&page=1
```

**Response:**
```json
{
  "count": 150,
  "next": "http://localhost:8000/api/products/?page=2",
  "previous": null,
  "results": [
    {
      "id": 1,
      "name": "Casque Sans-fil Premium",
      "category": "tech",
      "price": "29.99",
      "profit": "15.50",
      "image_url": "https://example.com/image.jpg",
      "score": 95,
      "trend_percentage": "45.00",
      "is_trending": true,
      "is_favorite": false,
      "source": "aliexpress"
    }
  ]
}
```

### Get Product Details

**GET** `/api/products/{id}/`

**Response:**
```json
{
  "id": 1,
  "name": "Casque Sans-fil Premium",
  "description": "Casque audio de haute qualité...",
  "source": "aliexpress",
  "source_url": "https://aliexpress.com/item/123",
  "category": "tech",
  "price": "29.99",
  "cost": "14.49",
  "profit": "15.50",
  "image_url": "https://example.com/image.jpg",
  "images": ["https://example.com/image1.jpg"],
  "available_colors": ["beige", "green", "blue"],
  "score": 95,
  "demand_level": 90,
  "popularity": 88,
  "competition": 65,
  "profitability": 92,
  "trend_percentage": "45.00",
  "is_trending": true,
  "performance_metrics": {
    "demand_level": 90,
    "popularity": 88,
    "competition": 65,
    "profitability": 92
  },
  "supplier": {
    "name": "AliExpress Premium",
    "rating": 4.8,
    "review_count": 2341
  },
  "is_favorite": false
}
```

### Get Trending Products

**GET** `/api/products/trending/`

**Response:**
```json
[
  {
    "id": 1,
    "name": "Casque Sans-fil Premium",
    "score": 95,
    "trend_percentage": "45.00"
  }
]
```

### Get Top Rated Products

**GET** `/api/products/top_rated/`

### Analyze Product

**GET** `/api/products/{id}/analyze/`

**Response:**
```json
{
  "scores": {
    "demand_level": 90,
    "popularity": 88,
    "competition": 65,
    "profitability": 92,
    "trend": 85,
    "overall": 87
  },
  "insights": [
    {
      "type": "positive",
      "title": "Forte demande",
      "message": "Ce produit bénéficie d'une demande élevée sur le marché"
    },
    {
      "type": "positive",
      "title": "Marge importante",
      "message": "Potentiel de profit élevé avec de bonnes marges"
    }
  ],
  "recommendations": [
    "Excellent produit - Lancement recommandé",
    "Analyser la concurrence locale"
  ],
  "risk_level": "low",
  "is_recommended": true
}
```

### Get Category Trends

**GET** `/api/products/category_trends/?category=tech`

**Response:**
```json
{
  "category": "tech",
  "average_score": 82,
  "average_trend": 15.5,
  "total_products": 45,
  "top_products": [...],
  "is_growing": true,
  "recommendation": "Catégorie en forte croissance - Opportunité excellente"
}
```

---

## ❤️ Favorites

### List Favorites

**GET** `/api/favorites/`

**Response:**
```json
{
  "count": 12,
  "results": [
    {
      "id": 1,
      "product": {
        "id": 5,
        "name": "Montre Connectée Sport",
        "price": "39.99",
        "profit": "18.00"
      },
      "created_at": "2024-01-15T10:30:00Z"
    }
  ]
}
```

### Toggle Favorite

**POST** `/api/favorites/toggle/`

**Request Body:**
```json
{
  "product_id": 5
}
```

**Response:**
```json
{
  "status": "added",
  "is_favorite": true
}
```

---

## 🔔 Trend Alerts

### List Alerts

**GET** `/api/alerts/`

**Response:**
```json
{
  "count": 5,
  "results": [
    {
      "id": 1,
      "alert_type": "category",
      "title": "Tendance Sport & Fitness",
      "message": "La catégorie Sport & Fitness connaît une hausse de 32%",
      "product": null,
      "is_read": false,
      "created_at": "2024-01-15T09:00:00Z"
    }
  ]
}
```

### Get Unread Alerts

**GET** `/api/alerts/unread/`

### Mark Alert as Read

**POST** `/api/alerts/{id}/mark_read/`

---

## 📊 Dashboard

### Get Dashboard Statistics

**GET** `/api/dashboard/stats/`

**Response:**
```json
{
  "favorites_count": 12,
  "views_count": 847,
  "profitability_score": 87,
  "trending_count": 24,
  "subscription_plan": "pro",
  "recent_favorites": [...]
}
```

---

## 🔍 Search

Search is integrated into the products endpoint:

**GET** `/api/products/?search=casque`

The search will look for matches in:
- Product name
- Product description

---

## 📈 Pagination

All list endpoints support pagination:

**Query Parameters:**
- `page`: Page number (default: 1)
- `page_size`: Items per page (default: 20, max: 100)

**Response Format:**
```json
{
  "count": 150,
  "next": "http://localhost:8000/api/products/?page=2",
  "previous": null,
  "results": [...]
}
```

---

## ⚠️ Error Responses

### 400 Bad Request
```json
{
  "error": "Invalid request parameters",
  "details": {
    "field_name": ["Error message"]
  }
}
```

### 401 Unauthorized
```json
{
  "detail": "Authentication credentials were not provided."
}
```

### 404 Not Found
```json
{
  "detail": "Not found."
}
```

### 500 Internal Server Error
```json
{
  "error": "Internal server error",
  "message": "An unexpected error occurred"
}
```

---

## 🚀 Rate Limiting

**Free Plan:** 100 requests/hour  
**Starter Plan:** 1000 requests/hour  
**Pro Plan:** 10000 requests/hour  
**Premium Plan:** Unlimited

Rate limit headers:
```
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1640000000
```

---

## 📝 Subscription Plans

| Plan | Price | Features |
|------|-------|----------|
| **Free** | 0 DH | 10 searches/month, Basic analysis |
| **Starter** | 99 DH/month | 100 searches/month, 5 favorites |
| **Pro** | 249 DH/month | Unlimited searches, Advanced analysis |
| **Premium** | 499 DH/month | All Pro + API access, 24/7 support |

---

## 🔗 Webhooks (Premium)

Premium users can configure webhooks for real-time notifications:

**Events:**
- `product.trending` - New trending product detected
- `alert.created` - New trend alert
- `favorite.price_drop` - Price drop on favorited product

**Webhook Payload:**
```json
{
  "event": "product.trending",
  "timestamp": "2024-01-15T10:30:00Z",
  "data": {
    "product_id": 123,
    "product_name": "Casque Sans-fil Premium",
    "score": 95
  }
}
```

---

## 📚 SDKs

Official SDKs available for:
- **Python**: `pip install dropshipping-finder-sdk`
- **JavaScript**: `npm install dropshipping-finder-sdk`
- **Flutter/Dart**: Already integrated in the mobile app

---

## 🆘 Support

- **Documentation**: https://docs.dropshippingfinder.com
- **API Status**: https://status.dropshippingfinder.com
- **Support Email**: api-support@dropshippingfinder.com
- **Discord**: https://discord.gg/dropshipping-finder

---

**Last Updated:** November 2024  
**API Version:** v1.0.0
