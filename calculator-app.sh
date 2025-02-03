#!/bin/bash

# Step 1: Create a temporary directory
mkdir -p tempdir

# Step 2: Remove any previous repo to avoid conflicts
rm -rf tempdir/repo

# Step 3: Clone the latest code from GitHub
echo "Cloning the latest Calculator App from GitHub..."
git clone --depth=1 https://github.com/23017469-PehXuanHe/C270-PS.git tempdir/repo

# Step 4: Move the required files into tempdir
cp tempdir/repo/index.html tempdir/
cp tempdir/repo/styles.css tempdir/

# Step 5: Create an Nginx configuration file
echo "Creating Nginx configuration..."
cat <<EOL > tempdir/nginx.conf
server {
    listen 80;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;
        index index.html;
    }

    location /styles.css {
        root /usr/share/nginx/html;
    }
}
EOL

# Step 6: Create Dockerfile
echo "Creating Dockerfile..."
cat <<EOL > tempdir/Dockerfile
FROM nginx:latest
COPY index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 5050
CMD ["nginx", "-g", "daemon off;"]
EOL

# Step 7: Build the Docker image
cd tempdir
docker build -t calculator-app .

# Step 8: Stop and remove any existing container
docker stop calculator-running 2>/dev/null
docker rm calculator-running 2>/dev/null

# Step 9: Run the new container on localhost:5050
docker run -t -d -p 5050:80 --name calculator-running calculator-app

# Step 10: Show running containers
docker ps -a

echo "Calculator App is running at http://localhost:5050"


