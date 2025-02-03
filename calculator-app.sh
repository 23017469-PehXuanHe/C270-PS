#!/bin/bash

# Step 1: Create a temporary directory
mkdir -p tempdir
mkdir -p tempdir/static

# Step 2: Clone the latest code from GitHub
echo "Cloning the latest Calculator App from GitHub..."
git clone --depth=1 https://github.com/23017469-PehXuanHe/C270-PS.git tempdir/repo

# Step 3: Move the required files into tempdir
cp tempdir/repo/index.html tempdir/
cp tempdir/repo/styles.css tempdir/static/
cp tempdir/repo/script.js tempdir/static/

# Step 4: Create Dockerfile
echo "Creating Dockerfile..."
echo "FROM nginx:latest" > tempdir/Dockerfile
echo "COPY index.html /usr/share/nginx/html/" >> tempdir/Dockerfile
echo "COPY static /usr/share/nginx/html/static/" >> tempdir/Dockerfile
echo "EXPOSE 5050" >> tempdir/Dockerfile
echo "CMD [\"nginx\", \"-g\", \"daemon off;\"]" >> tempdir/Dockerfile

# Step 5: Build the Docker image
cd tempdir
docker build -t calculator-app .

# Step 6: Stop and remove any existing container
docker stop calculator-running 2>/dev/null
docker rm calculator-running 2>/dev/null

# Step 7: Run the new container on localhost:5050
docker run -t -d -p 5050:80 --name calculator-running calculator-app

# Step 8: Show running containers
docker ps -a

echo "Calculator App is running at http://localhost:5050"

