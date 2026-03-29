# 🚀 Quick Deployment Guide

## Step 1: Prepare Your Environment Variables

### Backend Variables (Copy these to your deployment platform):

```env
# Database (Already working - from Supabase)
DB_URL=jdbc:postgresql://aws-1-ap-south-1.pooler.supabase.com:5432/postgres?sslmode=require&prepareThreshold=0
DB_USERNAME=postgres.msdahccfpizeopomlkws
DB_PASSWORD=fmwRxIonoRUPfDZj

# JWT Secret (New secure key generated for you)
JWT_SECRET=cjsoeAr5mjrWk+FnYHnt7PRu/OYjY6jQt2y72ypa8/fVr/i5J8cAVcOzO1zFOWgHXPMjh8mD+7KqNJj2v5xnPQ==

# CORS (Change after deploying frontend)
CORS_ALLOWED_ORIGINS=https://your-frontend-url.vercel.app

# Admin Credentials
ADMIN_EMAIL=admin@realestatecrm.com
ADMIN_PASSWORD=Admin@123456
ADMIN_NAME=Admin User

# Contact Info
CONTACT_PHONE=9360004968
CONTACT_EMAIL=contact@realestatecrm.com
COMPANY_NAME=Real Estate CRM
COMPANY_ADDRESS=Mumbai, India

# Optional Email
SENDGRID_API_KEY=your_key_here
MAIL_FROM=noreply@realestatecrm.com
```

### Frontend Variables (Copy these to your deployment platform):

```env
# API URL (Change after deploying backend)
VITE_API_URL=https://your-backend-url.onrender.com

# Contact Info (Optional)
VITE_CONTACT_PHONE=9360004968
VITE_CONTACT_EMAIL=contact@realestatecrm.com
VITE_COMPANY_NAME=Real Estate CRM
```

---

## Step 2: Deploy Backend First

### Option A: Deploy to Render.com (Recommended)

1. Go to https://render.com
2. Click "New +" → "Web Service"
3. Connect your GitHub repository
4. Configure:
   - **Name**: `realestatecrm-backend`
   - **Root Directory**: `backend`
   - **Build Command**: `mvn clean package -DskipTests`
   - **Start Command**: `java -jar target/backend-1.0.0.jar`
   - **Environment**: Java
5. Add all backend environment variables (from Step 1)
6. Click "Create Web Service"
7. Wait for deployment (5-10 minutes)
8. Copy your backend URL (e.g., `https://realestatecrm-backend.onrender.com`)

### Option B: Deploy to Railway.app

1. Go to https://railway.app
2. Click "New Project" → "Deploy from GitHub repo"
3. Select your repository
4. Add backend environment variables
5. Deploy and copy the URL

---

## Step 3: Deploy Frontend

### Option A: Deploy to Vercel (Recommended)

1. Go to https://vercel.com
2. Click "Add New" → "Project"
3. Import your GitHub repository
4. Configure:
   - **Framework Preset**: Vite
   - **Root Directory**: `frontend`
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`
5. Add environment variable:
   - `VITE_API_URL` = Your backend URL from Step 2
6. Click "Deploy"
7. Copy your frontend URL (e.g., `https://your-app.vercel.app`)

### Option B: Deploy to Netlify

1. Go to https://netlify.com
2. Click "Add new site" → "Import an existing project"
3. Connect GitHub and select repository
4. Configure:
   - **Base directory**: `frontend`
   - **Build command**: `npm run build`
   - **Publish directory**: `frontend/dist`
5. Add environment variable: `VITE_API_URL`
6. Deploy

---

## Step 4: Update CORS

1. Go back to your backend deployment (Render/Railway)
2. Update environment variable:
   ```
   CORS_ALLOWED_ORIGINS=https://your-frontend-url.vercel.app
   ```
3. Save and redeploy

---

## Step 5: Test Your Deployment

1. Open your frontend URL
2. Try logging in:
   - Email: `admin@realestatecrm.com`
   - Password: `Admin@123456`
3. Check if properties load
4. Try creating a lead

---

## 🎯 Summary

**You need to provide:**
1. ✅ Database credentials (You already have from Supabase)
2. ✅ JWT Secret (Generated: `cjsoeAr5mjrWk+FnYHnt7PRu/OYjY6jQt2y72ypa8/fVr/i5J8cAVcOzO1zFOWgHXPMjh8mD+7KqNJj2v5xnPQ==`)
3. 🔄 Frontend URL (Get after deploying frontend)
4. 🔄 Backend URL (Get after deploying backend)

**Deployment Order:**
1. Deploy Backend → Get backend URL
2. Deploy Frontend with backend URL → Get frontend URL
3. Update backend CORS with frontend URL
4. Test!

---

## 📞 Need Help?

- Backend not starting? Check database connection
- Frontend can't connect? Verify VITE_API_URL
- CORS errors? Update CORS_ALLOWED_ORIGINS
- Login not working? Check admin credentials
