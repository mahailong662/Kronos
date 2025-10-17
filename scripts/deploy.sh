#!/bin/bash

# Kronos Docker Deployment Script
# This script helps you deploy Kronos using Docker

set -e

echo "🚀 Kronos Docker Deployment Script"
echo "=================================="

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Check if NVIDIA Docker runtime is available
if ! docker info | grep -q nvidia; then
    echo "⚠️  NVIDIA Docker runtime not detected. GPU support may not work."
    echo "   Please install nvidia-docker2 for GPU support."
fi

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p data models outputs notebooks

# Check if sample data exists
if [ ! -f "data/sample_data.csv" ]; then
    echo "📊 Creating sample data structure..."
    cat > data/sample_data.csv << EOF
timestamps,open,high,low,close,volume,amount
2024-01-01 00:00:00,100.0,105.0,98.0,102.0,1000,102000
2024-01-01 00:05:00,102.0,108.0,101.0,106.0,1200,127200
2024-01-01 00:10:00,106.0,110.0,104.0,108.0,1100,118800
2024-01-01 00:15:00,108.0,112.0,106.0,110.0,1300,143000
2024-01-01 00:20:00,110.0,115.0,109.0,113.0,1400,158200
EOF
    echo "✅ Sample data created at data/sample_data.csv"
fi

# Build and run the container
echo "🔨 Building Docker image..."
docker-compose build

echo "🚀 Starting Kronos container..."
docker-compose up -d

echo "✅ Kronos container is running!"
echo ""
echo "📋 Useful commands:"
echo "  - View logs: docker-compose logs -f"
echo "  - Stop container: docker-compose down"
echo "  - Access container: docker-compose exec kronos bash"
echo "  - Run Jupyter: docker-compose --profile jupyter up jupyter"
echo ""
echo "🌐 If using web interface, it should be available at: http://localhost:7860"
echo "📓 Jupyter notebook (if enabled): http://localhost:8888"
echo ""
echo "📁 Directory structure:"
echo "  - data/: Place your CSV data files here"
echo "  - models/: Downloaded models will be stored here"
echo "  - outputs/: Prediction results will be saved here"
echo "  - notebooks/: Jupyter notebooks for development"