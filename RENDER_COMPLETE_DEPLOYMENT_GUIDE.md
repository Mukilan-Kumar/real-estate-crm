# 🚀 Complete Render.com Deployment Guide
## Deploy Both Frontend & Backend to Render

---

## Prerequisites

- [ ] GitHub account
- [ ] Render.com account (free)
- [ ] Your code ready to push

---

## Step 1: Push Your Code to GitHub

### 1.1 Create GitHub Repository

1. Go to https://github.com/new
2. Fill in:
   - **Repository name**: `real-estate-crm`
   - **Description**: Real Estate CRM - Full Stack Application
   - **Visibility**: Public (required for Render free tier)
   - **DO NOT** check "Initialize with README"
3. Click "Create repository"

### 1.2 Push Your Code

Copy your repository URL (looks like: `https://github.com/YOUR_USERNAME/real-estate-crm.git`)

Run these commands in your project folder:

```bash
# Check if remote already exists
git remote -v

# If no remote exists, add it (replace YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/real-estate-crm.git

# If remote exists but wrong URL, update it
git remote set-url origin https://github.com/YOUR_USERNAME/real-estate-crm.git

# Push to GitHub
git branch -M main
git push -u origin main
```

**Verify:** Go to your GitHub repository and confirm files are there.

---

## Step 2: Deploy Backend to Render

### 2.1 Sign Up for Render

1. Go to https://render.com
2. Click "Get Started for Free"
3. Click "GitHub" to sign up with GitHub
4. Authorize Render to access your repositories

### 2.2 Create Backend Web Service

1. Click "New +" (top right)
2. Select "Web Service"
3. Click "Connect account" if needed
4. Find and select your `real-estate-crm` repository
5. Click "Connect"

### 2.3 Configure Backend Service

Fill in these settings:

```
Name: realestatecrm-backend
Region: Singapore (or closest to you)
Branch: main
Root Directory: backend
Runtime: Docker
```

**Build Command:**
```bash
mvn clean package -DskipTests
```

**Start Command:**
```bash
java -jar target/backend-1.0.0.jar
```

### 2.4 Add Backend Environment Variables

Click "Advanced" → Scroll down to "Environment Variables"

Add these variables one by one (click "Add Environment Variable" for each):

| Key | Value |
|-----|-------|
| `DB_URL` | `jdbc:postgresql://aws-1-ap-south-1.pooler.supabase.com:5432/postgres?sslmode=require&prepareThreshold=0` |
| `DB_USERNAME` | `postgres.msdahccfpizeopomlkws` |
| `DB_PASSWORD` | `fmwRxIonoRUPfDZj` |
| `JWT_SECRET` | `cjsoeAr5mjrWk+FnYHnt7PRu/OYjY6jQt2y72ypa8/fVr/i5J8cAVcOzO1zFOWgHXPMjh8mD+7KqNJj2v5xnPQ==` |
| `CORS_ALLOWED_ORIGINS` | `https://realestatecrm-frontend.onrender.com` |
| `ADMIN_EMAIL` | `admin@realestatecrm.com` |
| `ADMIN_PASSWORD` | `Admin@123456` |
| `ADMIN_NAME` | `Admin User` |
| `CONTACT_PHONE` | `9360004968` |
| `CONTACT_EMAIL` | `contact@realestatecrm.com` |
| `COMPANY_NAME` | `Real Estate CRM` |
| `COMPANY_ADDRESS` | `Mumbai, India` |
| `PORT` | `8080` |

**Note:** We'll update `CORS_ALLOWED_ORIGINS` after deploying frontend

### 2.5 Select Plan and Deploy

1. Scroll down to "Instance Type"
2. Select **"Free"** plan
3. Click "Create Web Service"

### 2.6 Wait for Backend Deployment

- Watch the logs (they'll appear automatically)
- Wait for "Your service is live 🎉" (takes 10-15 minutes)
- You'll see logs like:
  ```
  Started RealEstateCrmApplication in X seconds
  Tomcat started on port 8080
  ```

### 2.7 Get Your Backend URL

1. At the top of the page, you'll see your URL
2. Example: `https://realestatecrm-backend.onrender.com`
3. **Copy this URL** - you'll need it for frontend!

### 2.8 Test Backend

Open a new browser tab and go to:
```
https://your-backend-url.onrender.com/api/health
```

Should return:
```json
{
  "service": "RealEstateCRM API",
  "status": "UP",
  "timestamp": 1234567890
}
```

✅ **Backend is deployed!**

---

## Step 3: Deploy Frontend to Render

### 3.1 Create Frontend Web Service

1. Go back to Render Dashboard
2. Click "New +" → "Web Service"
3. Select your `real-estate-crm` repository again
4. Click "Connect"

### 3.2 Configure Frontend Service

Fill in these settings:

```
Name: realestatecrm-frontend
Region: Singapore (same as backend)
Branch: main
Root Directory: frontend
Runtime: Node
```

**Build Command:**
```bash
npm install && npm run build
```

**Start Command:**
```bash
npm run preview
```

### 3.3 Add Frontend Environment Variables

Click "Advanced" → "Environment Variables"

Add these variables:

| Key | Value |
|-----|-------|
| `VITE_API_URL` | `https://your-backend-url.onrender.com` |
| `VITE_CONTACT_PHONE` | `9360004968` |
| `VITE_CONTACT_EMAIL` | `contact@realestatecrm.com` |
| `VITE_COMPANY_NAME` | `Real Estate CRM` |

**Important:** Replace `your-backend-url.onrender.com` with your actual backend URL from Step 2.7!

### 3.4 Select Plan and Deploy

1. Select **"Free"** plan
2. Click "Create Web Service"

### 3.5 Wait for Frontend Deployment

- Watch the logs
- Wait for "Your service is live 🎉" (takes 3-5 minutes)
- Faster than backend!

### 3.6 Get Your Frontend URL

1. Copy your frontend URL
2. Example: `https://realestatecrm-frontend.onrender.com`

✅ **Frontend is deployed!**

---

## Step 4: Update Backend CORS

Now that you have your frontend URL, update the backend:

### 4.1 Update CORS in Backend

1. Go to Render Dashboard
2. Click on your **backend** service
3. Click "Environment" in the left sidebar
4. Find `CORS_ALLOWED_ORIGINS`
5. Click the edit icon (pencil)
6. Change value to your frontend URL:
   ```
   https://realestatecrm-frontend.onrender.com
   ```
7. Click "Save Changes"

### 4.2 Wait for Redeploy

- Backend will automatically redeploy (2-3 minutes)
- Watch the logs to confirm it's done

✅ **CORS is configured!**

---

## Step 5: Test Your Application

### 5.1 Open Your Frontend

Go to your frontend URL:
```
https://realestatecrm-frontend.onrender.com
```

### 5.2 Test Login

1. Click "Login" or go to `/login`
2. Enter credentials:
   - **Email**: `admin@realestatecrm.com`
   - **Password**: `Admin@123456`
3. Click "Login"

✅ Should redirect to dashboard!

### 5.3 Test Features

1. **View Properties**: Should see 8 sample properties
2. **View Property Details**: Click on a property
3. **Create Lead**: Fill out inquiry form on a property
4. **Admin Dashboard**: Check analytics and leads

---

## 🎯 Your Deployment URLs

### Frontend (Public Site):
```
https://realestatecrm-frontend.onrender.com
```

### Backend (API):
```
https://realestatecrm-backend.onrender.com
```

### API Documentation:
```
https://realestatecrm-backend.onrender.com/swagger-ui.html
```

### Admin Login:
- **Email**: `admin@realestatecrm.com`
- **Password**: `Admin@123456`

---

## 📋 Environment Variables Reference

### Backend Environment Variables:
```env
DB_URL=jdbc:postgresql://aws-1-ap-south-1.pooler.supabase.com:5432/postgres?sslmode=require&prepareThreshold=0
DB_USERNAME=postgres.msdahccfpizeopomlkws
DB_PASSWORD=fmwRxIonoRUPfDZj
JWT_SECRET=cjsoeAr5mjrWk+FnYHnt7PRu/OYjY6jQt2y72ypa8/fVr/i5J8cAVcOzO1zFOWgHXPMjh8mD+7KqNJj2v5xnPQ==
CORS_ALLOWED_ORIGINS=https://realestatecrm-frontend.onrender.com
ADMIN_EMAIL=admin@realestatecrm.com
ADMIN_PASSWORD=Admin@123456
ADMIN_NAME=Admin User
CONTACT_PHONE=9360004968
CONTACT_EMAIL=contact@realestatecrm.com
COMPANY_NAME=Real Estate CRM
COMPANY_ADDRESS=Mumbai, India
PORT=8080
```

### Frontend Environment Variables:
```env
VITE_API_URL=https://realestatecrm-backend.onrender.com
VITE_CONTACT_PHONE=9360004968
VITE_CONTACT_EMAIL=contact@realestatecrm.com
VITE_COMPANY_NAME=Real Estate CRM
```

---

## 🔧 Troubleshooting

### Backend Issues

**Problem: "No open ports detected" - Backend exits with status 1**
- **FIXED**: Added `server.address=0.0.0.0` to application.properties
- This ensures the app binds to all network interfaces (not just localhost)
- Render needs to detect the port from outside the container
- After this fix, push your code and redeploy

**Problem: Backend won't start**
- Check logs in Render dashboard
- Verify all environment variables are set correctly
- Check database connection (test with psql)

**Problem: Database connection failed**
- Verify `DB_URL`, `DB_USERNAME`, `DB_PASSWORD`
- Check Supabase database is running
- Ensure `sslmode=require` is in URL

**Problem: Build fails**
- Check Java version (should be 17+)
- Verify Maven can download dependencies
- Check logs for specific error

### Frontend Issues

**Problem: Frontend shows blank page**
- Check browser console for errors
- Verify `VITE_API_URL` is set correctly
- Check if backend is running

**Problem: "Network Error" when logging in**
- Verify `VITE_API_URL` points to backend
- Check CORS settings in backend
- Test backend health endpoint

**Problem: CORS Error**
- Update `CORS_ALLOWED_ORIGINS` in backend
- Make sure it matches frontend URL exactly
- Wait for backend to redeploy

### General Issues

**Problem: First request takes 30-60 seconds**
- This is normal on Render free tier
- Backend "sleeps" after 15 minutes of inactivity
- First request "wakes it up"
- Solution: Upgrade to paid plan or use UptimeRobot

**Problem: Changes not showing**
- Clear browser cache
- Hard refresh (Ctrl+Shift+R or Cmd+Shift+R)
- Check if deployment finished
- Verify correct environment variables

---

## 🚀 Post-Deployment Tasks

### 1. Change Admin Password
1. Login to admin dashboard
2. Go to Settings/Profile
3. Change password from default

### 2. Add Custom Domain (Optional)
1. Go to Render Dashboard → Your Service → Settings
2. Click "Custom Domain"
3. Add your domain (e.g., `myapp.com`)
4. Update DNS records as instructed
5. Update CORS and environment variables

### 3. Set Up Monitoring
1. Use UptimeRobot (free) to ping backend every 10 minutes
2. Keeps backend awake on free tier
3. Get alerts if site goes down

### 4. Configure Email (Optional)
1. Sign up for SendGrid (free tier: 100 emails/day)
2. Get API key
3. Update `SENDGRID_API_KEY` in backend
4. Verify sender email

---

## 💡 Render Free Tier Limitations

### What You Get (Free):
- ✅ 750 hours/month (enough for 1 service 24/7)
- ✅ Automatic HTTPS
- ✅ Automatic deployments from Git
- ✅ Custom domains
- ✅ Environment variables

### Limitations:
- ⚠️ Services sleep after 15 min of inactivity
- ⚠️ First request after sleep takes 30-60 seconds
- ⚠️ 512 MB RAM per service
- ⚠️ Shared CPU

### Solutions:
- Use UptimeRobot to keep backend awake
- Upgrade to paid plan ($7/month per service)
- Optimize application startup time

---

## 📊 Monitoring Your Application

### Check Backend Logs:
1. Go to Render Dashboard
2. Click on backend service
3. Click "Logs" tab
4. See real-time logs

### Check Frontend Logs:
1. Go to Render Dashboard
2. Click on frontend service
3. Click "Logs" tab

### Check Database:
1. Go to Supabase Dashboard
2. Check Table Editor
3. Verify data is being saved

---

## 🔄 Updating Your Application

### When You Make Code Changes:

1. **Commit and push to GitHub:**
   ```bash
   git add .
   git commit -m "Your changes"
   git push
   ```

2. **Render auto-deploys:**
   - Both services will automatically redeploy
   - Watch logs to confirm deployment
   - Takes 3-15 minutes depending on service

### Manual Redeploy:
1. Go to Render Dashboard
2. Click on service
3. Click "Manual Deploy" → "Deploy latest commit"

---

## ✅ Deployment Checklist

- [ ] Code pushed to GitHub
- [ ] Backend service created on Render
- [ ] Backend environment variables added
- [ ] Backend deployed successfully
- [ ] Backend health check returns 200
- [ ] Backend URL copied
- [ ] Frontend service created on Render
- [ ] Frontend environment variables added (with backend URL)
- [ ] Frontend deployed successfully
- [ ] Backend CORS updated with frontend URL
- [ ] Can access frontend URL
- [ ] Can login successfully
- [ ] Properties load correctly
- [ ] Can create a lead
- [ ] Dashboard shows data
- [ ] Admin password changed

---

## 🎉 Congratulations!

Your Real Estate CRM is now live on the internet!

**Share your app:**
- Frontend: `https://realestatecrm-frontend.onrender.com`
- Anyone can access it!

**Next steps:**
- Add custom domain
- Set up email notifications
- Add more properties
- Invite team members
- Monitor usage

---

## 📞 Need Help?

**Check these first:**
1. Render Dashboard → Logs
2. Browser Console (F12)
3. Backend health endpoint
4. Environment variables spelling

**Common fixes:**
- Clear browser cache
- Wait for deployment to finish
- Check CORS settings
- Verify environment variables

**Still stuck?**
- Check Render documentation
- Review error logs
- Test backend API directly
- Verify database connection
