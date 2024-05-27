#!/bin/bash

# Install pyngrok
pip install pyngrok

# Prompt user for ngrok authentication token
read -p "Enter your ngrok authentication token: " ngrok_auth_token

# Prompt user for device selection
echo "Select device:"
echo "1. CPU"
echo "2. GPU"
read -p "Enter your choice (1 or 2): " device_option

# Function to start the Web UI
start_webui() {
    device=$1
    cd /home/studio-lab-user/stable-diffusion-webui
    if [ "$device" == "cpu" ]; then
        python launch.py --port 7860 --skip-torch-cuda-test
    elif [ "$device" == "gpu" ]; then
        python launch.py --port 7860
    fi
}

# Function to start ngrok
start_ngrok() {
    public_url=$(python -c "
import os
from pyngrok import ngrok

ngrok.set_auth_token('$ngrok_auth_token')
public_url = ngrok.connect(7860)
print(public_url)
")
    echo "Starting ngrok tunnel: $public_url"
}

# Set ngrok authentication token
python -c "from pyngrok import ngrok; ngrok.set_auth_token('$ngrok_auth_token')"

# Start the Web UI and ngrok based on device option
if [ "$device_option" == "1" ]; then
    start_webui "cpu" &
    start_ngrok
elif [ "$device_option" == "2" ]; then
    start_webui "gpu" &
    start_ngrok
else
    echo "Invalid option selected."
    exit 1
fi

# Wait for Web UI process to finish
wait
