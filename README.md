# 🚀 Laravel + React (TS) + Inertia Setup for Coolify

## 🌐 About the Project
**Example** is a modern platform template developed using advanced web technologies. This project combines Laravel backend with React frontend in a single container for optimal performance and ease of deployment.

## 🔧 Installation Guide

### 🔄 Fork & Deploy with Coolify

1. 🍴 **Fork the repository** to your GitHub account
2. 🔐 Log in to your **Coolify** dashboard
3. ➕ Click **Create New Service** or **Add New Resource**
4. 📦 Select **Application**
5. 🔗 Connect your GitHub account and select the forked repository
6. 📝 Configure your deployment with the following settings:

#### ⚙️ Basic Configuration
- **Docker Compose Location**: `/docker-compose.yml`

#### 📄 Customizing the Application
Before deploying, consider modifying the following:

- 🔄 In `docker-compose.yml`, replace `example-app` with your application name:
  ```yaml
  services:
    your-app-name:  # Change from example-app to your app name
      container_name: your-app-name
      # ...
  
  networks:
    your-network-name:  # Also update network name
      driver: bridge
  ```

#### 🔑 Environment Variables
Set up the following environment variables in Coolify:

> **Note**: You can find a template for these environment variables in the `.env.production` file included in the project.

```
APP_ENV=production
APP_DEBUG=false
APP_KEY=your-generated-app-key
APP_URL=https://your-domain.com

DB_CONNECTION=pgsql
DB_HOST=your-db-host
# If you are setting up a database in Coolify, make sure to specify the Network as "Connect To Predefined Network" in your project settings.
DB_PORT=5432 or your other port that you are using
DB_DATABASE=your-db-name
DB_USERNAME=your-db-username
DB_PASSWORD=your-db-password

REDIS_HOST=your-redis-host
REDIS_PASSWORD=your-redis-password
REDIS_PORT=6379

DOMAIN=your-domain.com
```

#### 🌐 Domains Configuration
- Add your domain (e.g., `your-domain.com`) in the **Domains** section
- Enable **HTTPS** for secure connections

#### 🚀 Deploy
- Click the **Deploy** button to start the deployment process
- Wait for the build and deployment to complete

## 💻 Technology Stack

### Backend
- **🔧 Laravel** - PHP framework for backend development
- **🔄 API** - accessible via `/api` endpoints

### Frontend
- **⚛️ React** - library for building user interfaces
- **🔷 TypeScript** - all code migrated from JSX to TSX for better type safety
- **🎨 Tailwind CSS** - utility-first CSS framework
- **🔄 Inertia.js** - creating SPAs without building a separate API

### Infrastructure
- **⚡ Vite** - for fast development and production builds
- **🔥 SSR** - server-side rendering for better performance and SEO
- **📡 SSE** - server-sent events for real-time updates without page refreshes
- **🐳 Docker** - containerized deployment for consistency
- **🔗 Single Container** - backend and frontend in one container for simplified deployment and correct proxying

## 🧠 Features
- ⚡ Real-time updates without page reloads
- 🔄 Seamless integration between Laravel and React
- 📱 Responsive design
- 🚀 Optimized for performance
- 🔒 Secure by default

## 📝 Notes
- This project has been fully migrated from JSX to TypeScript (TSX) for improved code reliability
- The setup is specifically optimized for Coolify deployment
- The backend and frontend are integrated in a single container for easier deployment and proper proxy configuration

## 🙏 Acknowledgments
This setup required 6 days of work to function correctly with Coolify. Hopefully, it helps those who face difficulties with similar deployments!

## 📜 License
Open-source software licensed under the MIT license.

