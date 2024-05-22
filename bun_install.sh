#!/bin/bash

# Install bun for macOS, Linux, and WSL
echo "Installing bun..."
curl -fsSL https://bun.sh/install | bash

# Increase the number of file watchers to avoid ENOSPC errors
echo "Increasing the number of file watchers..."
CURRENT_WATCHES=$(cat /proc/sys/fs/inotify/max_user_watches)
echo "Current max_user_watches: $CURRENT_WATCHES"
sudo sysctl fs.inotify.max_user_watches=524288
sudo sysctl -p
echo 'fs.inotify.max_user_watches=524288' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Install watchman for better file watching
echo "Installing watchman..."
sudo apt-get install watchman -y

# Set environment variable to use polling for file watching
echo "Setting CHOKIDAR_USEPOLLING environment variable..."
export CHOKIDAR_USEPOLLING=true
echo 'export CHOKIDAR_USEPOLLING=true' >> ~/.bashrc
source ~/.bashrc

# Create a new React app using bun
echo "Creating a new React app with bun..."
bun create react-app hello-react
cd hello-react

# Install dependencies using bun
echo "Installing dependencies..."
bun install

# Start the development server
echo "Starting the development server..."
bun start