# Environment Variables for Deployment

## 🔐 Backend Environment Variables (Required)

### Database Configuration
```env
DB_URL=jdbc:postgresql://your-database-host:5432/database_name?sslmode=require
DB_USERNAME=your_database_username
DB_PASSWORD=your_database_password
```

**Where to get:**
- **Supabase**: Project Settings → Database → Connection String (URI format, add `jdbc:` prefix)
- **Neon**: Dashboard → Connection Details
- **Heroku Postgres**: Settings → Config Vars → DATABASE_URL
- **Railway**: Database → Connect → JDBC URL

### JWT Configuration
```env
JWT_SECRET=your-super-secret-jwt-key-minimum-256-bits-long-change-this
```

**Generate a secure secret:**
```bash
# Option 1: Using OpenSSL
openssl rand -base64 64

# Option 2: Using PowerShell
[Convert]::ToBase64String((1..64 | ForEach-Object { Get-Random -Maximum 256 }))
```

### CORS Configuration
```env
CORS_ALLOWED_ORIGINS=https://your-frontend-domain.com,https://www.your-frontend-domain.com
```

**Examples:**
- Vercel: `https://your-app.vercel.app`
- Netlify: `https://your-app.netlify.app`
- Custom domain: `https://yourdomain.com`
- Multiple: `https://yourdomain.com,https://www.yourdomain.com`

### Admin User Configuration
```env
ADMIN_EMAIL=admin@yourdomain.com
ADMIN_PASSWORD=YourSecurePassword@123
ADMIN_NAME=Admin User
```

**Important:** Change these from defaults!

### Email Configuration (Optional but Recommended)
```env
SENDGRID_API_KEY=SG.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
MAIL_FROM=noreply@yourdomain.com
```

**Get SendGrid API Key:**
1. Sign up at https://sendgrid.com
2. Go to Settings → API Keys
3. Create API Key with "Mail Send" permissions
4. Verify sender email in SendGrid

### Contact Information
```env
CONTACT_PHONE=1234567890
CONTACT_EMAIL=contact@yourdomain.com
COMPANY_NAME=Your Company Name
COMPANY_ADDRESS=Your Company Address
```

### Server Configuration (Optional)
```env
PORT=8080
```

---

## 🎨 Frontend Environment Variables (Required)

### API Configuration
```env
VITE_API_URL=https://your-backend-domain.com
```

**Examples:**
- Render: `https://your-app.onrender.com`
- Railway: `https://your-app.up.railway.app`
- Heroku: `https://your-app.herokuapp.com`
- Custom domain: `https://api.yourdomain.com`

**Important:** Do NOT include `/api` at the end!

### Contact Information (Optional)
```env
VITE_CONTACT_PHONE=1234567890
VITE_CONTACT_EMAIL=contact@yourdomain.com
VITE_COMPANY_NAME=Your Company Name
```

---

## 📋 Complete Environment Variables Checklist

### Backend (.env)
```env
# Database (REQUIRED)
DB_URL=jdbc:postgresql://your-db-host:5432/dbname?sslmode=require
DB_USERNAME=your_username
DB_PASSWORD=your_password

# JWT (REQUIRED)
JWT_SECRET=your-256-bit-secret-key-here

# CORS (REQUIRED)
CORS_ALLOWED_ORIGINS=https://your-frontend.com

# Admin (REQUIRED)
ADMIN_EMAIL=admin@yourdomain.com
ADMIN_PASSWORD=SecurePassword@123
ADMIN_NAME=Admin User

# Email (OPTIONAL)
SENDGRID_API_KEY=SG.your_api_key_here
MAIL_FROM=noreply@yourdomain.com

# Contact Info (OPTIONAL)
CONTACT_PHONE=1234567890
CONTACT_EMAIL=contact@yourdomain.com
COMPANY_NAME=Your Company
COMPANY_ADDRESS=Your Address

# Server (OPTIONAL)
PORT=8080
```

### Frontend (.env.production)
```env
# API (REQUIRED)
VITE_API_URL=https://your-backend-api.com

# Contact (OPTIONAL)
VITE_CONTACT_PHONE=1234567890
VITE_CONTACT_EMAIL=contact@yourdomain.com
VITE_COMPANY_NAME=Your Company
```

---

## 🚀 Platform-Specific Setup

### Vercel (Frontend)
1. Go to Project Settings → Environment Variables
2. Add each variable:
   - `VITE_API_URL` = `https://your-backend.com`
3. Redeploy

### Render (Backend)
1. Go to Dashboard → Your Service → Environment
2. Add each variable from backend list
3. Click "Save Changes" (auto-redeploys)

### Railway (Backend/Frontend)
1. Go to Project → Variables
2. Add variables
3. Click "Deploy"

### Heroku (Backend)
```bash
heroku config:set DB_URL="jdbc:postgresql://..."
heroku config:set JWT_SECRET="your-secret"
heroku config:set CORS_ALLOWED_ORIGINS="https://your-frontend.com"
# ... add all other variables
```

### Docker Compose
Create `.env` file in project root:
```env
# Backend variables
DB_URL=jdbc:postgresql://postgres:5432/realestatecrm
DB_USERNAME=postgres
DB_PASSWORD=postgres
JWT_SECRET=your-secret-key
CORS_ALLOWED_ORIGINS=http://localhost:5173

# Frontend variables
VITE_API_URL=http://localhost:8080
```

---

## 🔒 Security Best Practices

### ✅ DO:
- Use strong, unique passwords
- Generate random JWT secrets (minimum 256 bits)
- Use environment-specific values (dev, staging, prod)
- Keep `.env` files in `.gitignore`
- Use HTTPS URLs in production
- Rotate secrets regularly

### ❌ DON'T:
- Commit `.env` files to Git
- Use default passwords in production
- Share secrets in plain text
- Use HTTP in production
- Reuse secrets across environments

---

## 🧪 Testing Environment Variables

### Test Backend Connection:
```bash
# Check if backend can connect to database
curl https://your-backend.com/api/health

# Expected response:
# {"service":"RealEstateCRM API","status":"UP"}
```

### Test Frontend Connection:
```bash
# Check if frontend can reach backend
curl https://your-frontend.com

# Open browser console and check for API calls
```

---

## 📝 Quick Setup Commands

### Generate JWT Secret:
```bash
openssl rand -base64 64
```

### Test Database Connection:
```bash
psql "postgresql://username:password@host:5432/dbname?sslmode=require"
```

### Verify Environment Variables (Backend):
```bash
cd backend
mvn spring-boot:run
# Check logs for successful startup
```

### Verify Environment Variables (Frontend):
```bash
cd frontend
npm run build
# Check if build succeeds
```

---

## 🆘 Troubleshooting

### Backend won't start:
- Check `DB_URL` format is correct
- Verify database credentials
- Ensure `JWT_SECRET` is set
- Check `CORS_ALLOWED_ORIGINS` includes frontend URL

### Frontend can't connect to backend:
- Verify `VITE_API_URL` is correct
- Check CORS settings in backend
- Ensure backend is running and accessible
- Check browser console for errors

### Database connection fails:
- Verify database is running
- Check firewall/security group settings
- Ensure SSL mode is correct
- Test connection with psql or database client

---

## 📦 Example Configurations

### Local Development:
```env
# Backend
DB_URL=jdbc:postgresql://localhost:5432/realestatecrm
CORS_ALLOWED_ORIGINS=http://localhost:5173
JWT_SECRET=local-dev-secret-key

# Frontend
VITE_API_URL=http://localhost:8080
```

### Production:
```env
# Backend
DB_URL=jdbc:postgresql://prod-db.region.provider.com:5432/realestatecrm?sslmode=require
CORS_ALLOWED_ORIGINS=https://yourdomain.com,https://www.yourdomain.com
JWT_SECRET=super-secure-random-256-bit-key

# Frontend
VITE_API_URL=https://api.yourdomain.com
```

---

## 🎯 Deployment Checklist

- [ ] Database created and accessible
- [ ] All required environment variables set
- [ ] JWT secret generated (256+ bits)
- [ ] CORS origins configured correctly
- [ ] Admin credentials changed from defaults
- [ ] SendGrid configured (if using email)
- [ ] Frontend API URL points to backend
- [ ] Backend health check returns 200
- [ ] Frontend can login successfully
- [ ] Test creating a lead/property
- [ ] Email notifications working (if configured)

---

## 📞 Need Help?

If you're stuck, check:
1. Backend logs for error messages
2. Frontend browser console
3. Database connection with psql
4. Environment variables are spelled correctly
5. No trailing spaces in values
