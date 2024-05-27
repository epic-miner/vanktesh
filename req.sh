#!/bin/bash

echo -e "\033[1;32mInstalling requirements..."

# Install libglib and update conda
conda install -c conda-forge libglib -y
conda update -n base conda -y

# Install tqdm using pip
pip install tqdm

echo -e "\033[1;32mDone! Conda installed!"

# Clone the Stable Diffusion Web UI repository
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui

# Install requirements
pip install -r requirements.txt --quiet

# Clone the ControlNet and Reactor extensions
cd extensions/
git clone https://github.com/epic-miner/sd-webui-reactor.git
git clone https://github.com/Mikubill/sd-webui-controlnet.git
cd ..

echo -e "\033[1;32mDone!"
