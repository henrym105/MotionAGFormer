#!/bin/bash

# Check if uv is installed
if ! command -v uv &> /dev/null; then
    echo "uv is not installed. Installing uv..."
    curl -sSf https://astral.sh/uv/install.sh | sh
    echo "uv installed successfully."
fi

uv init

# Create a virtual environment using uv
echo "Creating virtual environment using uv..."
uv venv .venv
echo "Virtual environment created successfully."

# Activate the virtual environment
echo "Activating virtual environment..."
source .venv/bin/activate
echo "Virtual environment activated."

# Install dependencies using uv
echo "Installing dependencies using uv..."
# uv pip install
uv sync
echo "Dependencies installed successfully."