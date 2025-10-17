#!/bin/bash

# Quick Start Script for Kronos Docker Deployment
# This is a simplified version for quick testing

echo "🚀 Kronos Quick Start"
echo "===================="

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Create directories
echo "📁 Creating directories..."
mkdir -p data models outputs

# Create sample data if it doesn't exist
if [ ! -f "data/sample_data.csv" ]; then
    echo "📊 Creating sample data..."
    cat > data/sample_data.csv << 'EOF'
timestamps,open,high,low,close,volume,amount
2024-01-01 00:00:00,100.0,105.0,98.0,102.0,1000,102000
2024-01-01 00:05:00,102.0,108.0,101.0,106.0,1200,127200
2024-01-01 00:10:00,106.0,110.0,104.0,108.0,1100,118800
2024-01-01 00:15:00,108.0,112.0,106.0,110.0,1300,143000
2024-01-01 00:20:00,110.0,115.0,109.0,113.0,1400,158200
2024-01-01 00:25:00,113.0,118.0,112.0,116.0,1500,174000
2024-01-01 00:30:00,116.0,120.0,115.0,118.0,1600,188800
2024-01-01 00:35:00,118.0,122.0,117.0,120.0,1700,204000
2024-01-01 00:40:00,120.0,125.0,119.0,123.0,1800,221400
2024-01-01 00:45:00,123.0,128.0,122.0,126.0,1900,239400
EOF
fi

# Build and run
echo "🔨 Building Docker image (this may take a few minutes)..."
docker-compose build

echo "🚀 Starting Kronos container..."
docker-compose up -d

echo "⏳ Waiting for container to start..."
sleep 10

# Check if container is running
if docker-compose ps | grep -q "Up"; then
    echo "✅ Kronos is running successfully!"
    echo ""
    echo "📋 Next steps:"
    echo "  1. View logs: docker-compose logs -f"
    echo "  2. Access container: docker-compose exec kronos bash"
    echo "  3. Check outputs: ls -la outputs/"
    echo "  4. Stop when done: docker-compose down"
    echo ""
    echo "📊 Your sample data is in: data/sample_data.csv"
    echo "📈 Prediction results will be in: outputs/"
else
    echo "❌ Container failed to start. Check logs:"
    docker-compose logs
fi