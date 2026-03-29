# Postman Testing Guide - Real Estate CRM API

## ✅ Working Endpoints (Tested & Verified)

### 1. Health Check
```
Method: GET
URL: http://localhost:8080/api/health
Headers: None needed
Body: None

Expected Response:
{
  "service": "RealEstateCRM API",
  "status": "UP",
  "timestamp": 1774774859869
}
```

### 2. Login
```
Method: POST
URL: http://localhost:8080/api/auth/login
Headers: 
  Content-Type: application/json
Body (raw JSON):
{
  "email": "admin@realestatecrm.com",
  "password": "Admin@123456"
}

Expected Response:
{
  "success": true,
  "message": "Login successful",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiJ9...",
    "userId": 1,
    "name": "Admin User",
    "email": "admin@realestatecrm.com",
    "role": "ADMIN"
  }
}
```

### 3. Get All Properties (Public - No Auth)
```
Method: GET
URL: http://localhost:8080/api/properties
Headers: None needed
Body: None

Expected Response:
{
  "success": true,
  "message": "Properties retrieved successfully",
  "data": [
    {
      "id": 1,
      "title": "Luxury 3BHK in Anna Nagar",
      "location": "Anna Nagar, Chennai",
      "price": 8500000,
      ...
    }
  ]
}
```

### 4. Get Property by ID
```
Method: GET
URL: http://localhost:8080/api/properties/1
Headers: None needed
Body: None
```

### 5. Get All Leads (Requires Auth)
```
Method: GET
URL: http://localhost:8080/api/leads
Headers:
  Content-Type: application/json
  Authorization: Bearer YOUR_TOKEN_FROM_LOGIN
Body: None
```

### 6. Create Lead (Requires Auth)
```
Method: POST
URL: http://localhost:8080/api/leads
Headers:
  Content-Type: application/json
  Authorization: Bearer YOUR_TOKEN_FROM_LOGIN
Body (raw JSON):
{
  "name": "John Doe",
  "email": "john@example.com",
  "phone": "9876543210",
  "propertyId": 1,
  "message": "Interested in this property",
  "status": "NEW"
}
```

### 7. Submit Contact Form (Public - No Auth)
```
Method: POST
URL: http://localhost:8080/api/contact
Headers:
  Content-Type: application/json
Body (raw JSON):
{
  "name": "Jane Smith",
  "email": "jane@example.com",
  "phone": "1234567890",
  "message": "I would like more information about your services"
}
```

### 8. Get Analytics (Admin Only - Requires Auth)
```
Method: GET
URL: http://localhost:8080/api/admin/analytics
Headers:
  Content-Type: application/json
  Authorization: Bearer YOUR_TOKEN_FROM_LOGIN
Body: None
```

## 🔴 Common Errors & Solutions

### Error: "An unexpected error occurred"
**Causes:**
1. Missing required fields in request body
2. Invalid JSON format
3. Wrong data types (e.g., sending string instead of number)
4. Missing Content-Type header for POST requests

**Solution:**
- Make sure Content-Type is set to `application/json`
- Verify all required fields are included
- Check JSON syntax is valid
- Match the exact format shown above

### Error: 401 Unauthorized
**Cause:** Missing or invalid authentication token

**Solution:**
1. First call the login endpoint
2. Copy the token from the response
3. Add header: `Authorization: Bearer YOUR_TOKEN`

### Error: 404 Not Found
**Cause:** Wrong URL or endpoint doesn't exist

**Solution:**
- Check the URL is exactly: `http://localhost:8080/api/...`
- Verify the endpoint path is correct
- Make sure backend is running on port 8080

## 📝 Step-by-Step: Testing in Postman

1. **Start with Health Check**
   - Confirms API is running
   - No auth needed

2. **Login to get token**
   - Use admin credentials
   - Save the token from response

3. **Test public endpoints**
   - Get properties (no auth)
   - Get property by ID (no auth)

4. **Test protected endpoints**
   - Add Authorization header with token
   - Get leads
   - Create lead
   - Get analytics

## 🎯 Quick Test Commands (PowerShell)

```powershell
# Test Health
Invoke-RestMethod -Uri 'http://localhost:8080/api/health' -Method Get

# Test Login
$body = @{email='admin@realestatecrm.com'; password='Admin@123456'} | ConvertTo-Json
Invoke-RestMethod -Uri 'http://localhost:8080/api/auth/login' -Method Post -Body $body -ContentType 'application/json'

# Test Get Properties
Invoke-RestMethod -Uri 'http://localhost:8080/api/properties' -Method Get
```

## ⚠️ Important Notes

- Always set `Content-Type: application/json` for POST/PUT requests
- Token expires after 24 hours - login again if needed
- Property IDs start from 1
- Lead status must be one of: NEW, CONTACTED, QUALIFIED, CONVERTED, LOST
- Property types: APARTMENT, VILLA, COMMERCIAL, OFFICE, PLOT, WAREHOUSE
