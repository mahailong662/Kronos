# 🐳 Kronos Docker Deployment Guide

This guide will help you deploy Kronos using Docker with GPU support for financial market forecasting.

## 📋 Prerequisites

### System Requirements
- **OS**: Linux (Ubuntu 20.04+ recommended) or Windows with WSL2
- **GPU**: NVIDIA GPU with CUDA support (recommended)
- **RAM**: At least 8GB (16GB+ recommended)
- **Storage**: At least 10GB free space

### Software Requirements
1. **Docker**: [Install Docker](https://docs.docker.com/get-docker/)
2. **Docker Compose**: [Install Docker Compose](https://docs.docker.com/compose/install/)
3. **NVIDIA Docker**: [Install nvidia-docker2](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/mahailong662/Kronos.git
cd Kronos
```

### 2. Run the Deployment Script
```bash
chmod +x scripts/deploy.sh
./scripts/deploy.sh
```

This script will:
- Create necessary directories (`data/`, `models/`, `outputs/`, `notebooks/`)
- Generate sample data
- Build the Docker image
- Start the Kronos container

### 3. Verify Installation
```bash
# Check if container is running
docker-compose ps

# View logs
docker-compose logs -f
```

## 🔧 Manual Deployment

If you prefer manual setup:

### 1. Create Directories
```bash
mkdir -p data models outputs notebooks
```

### 2. Prepare Your Data
Place your CSV files in the `data/` directory. Your data should have columns:
- `timestamps`: DateTime column
- `open`, `high`, `low`, `close`: Price data
- `volume`, `amount`: Optional trading volume data

Example data structure:
```csv
timestamps,open,high,low,close,volume,amount
2024-01-01 00:00:00,100.0,105.0,98.0,102.0,1000,102000
2024-01-01 00:05:00,102.0,108.0,101.0,106.0,1200,127200
```

### 3. Build and Run
```bash
# Build the image
docker-compose build

# Start the service
docker-compose up -d
```

## 📊 Using Kronos

### Basic Prediction
The container will automatically run the prediction example. To run custom predictions:

```bash
# Access the container
docker-compose exec kronos bash

# Run custom prediction
python examples/prediction_example.py
```

### Batch Prediction
```bash
# Run batch prediction example
python examples/prediction_batch_example.py
```

### Without Volume Data
```bash
# Run prediction without volume/amount data
python examples/prediction_wo_vol_example.py
```

## 🖥️ Jupyter Notebook Development

To use Jupyter notebooks for interactive development:

```bash
# Start Jupyter service
docker-compose --profile jupyter up jupyter

# Access Jupyter at: http://localhost:8888
```

## 📁 Directory Structure

```
Kronos/
├── data/           # Input CSV files
├── models/         # Downloaded models (auto-created)
├── outputs/        # Prediction results
├── notebooks/      # Jupyter notebooks
├── examples/       # Example scripts
├── scripts/        # Deployment scripts
├── Dockerfile      # Docker configuration
└── docker-compose.yml
```

## 🔧 Configuration

### Environment Variables
You can modify the following in `docker-compose.yml`:

- `CUDA_VISIBLE_DEVICES`: GPU device selection
- `NVIDIA_VISIBLE_DEVICES`: NVIDIA GPU visibility
- Port mappings: Change `7860:7860` for web interface

### Model Selection
Edit the prediction scripts to use different models:
- `NeoQuasar/Kronos-mini` (4.1M parameters)
- `NeoQuasar/Kronos-small` (24.7M parameters)
- `NeoQuasar/Kronos-base` (102.3M parameters)

## 🐛 Troubleshooting

### Common Issues

1. **GPU not detected**
   ```bash
   # Check NVIDIA Docker installation
   docker run --rm --gpus all nvidia/cuda:11.8-base-ubuntu20.04 nvidia-smi
   ```

2. **Out of memory**
   - Reduce batch size in prediction scripts
   - Use smaller model (Kronos-mini)
   - Increase system RAM

3. **Model download fails**
   ```bash
   # Check internet connection
   docker-compose exec kronos ping huggingface.co
   ```

4. **Permission issues**
   ```bash
   # Fix permissions
   sudo chown -R $USER:$USER data models outputs notebooks
   ```

### Useful Commands

```bash
# View container logs
docker-compose logs -f kronos

# Stop all services
docker-compose down

# Rebuild and restart
docker-compose down && docker-compose up --build -d

# Access container shell
docker-compose exec kronos bash

# Check GPU usage
docker-compose exec kronos nvidia-smi
```

## 📈 Performance Tips

1. **Use GPU**: Ensure NVIDIA Docker is properly installed
2. **Batch Processing**: Use `predict_batch` for multiple time series
3. **Model Size**: Choose appropriate model size for your hardware
4. **Data Preprocessing**: Ensure data is properly formatted

## 🔄 Updates

To update to the latest version:

```bash
# Pull latest changes
git pull origin master

# Rebuild and restart
docker-compose down
docker-compose up --build -d
```

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/mahailong662/Kronos/issues)
- **Documentation**: [Original Kronos README](https://github.com/shiyu-coder/Kronos)
- **Paper**: [arXiv:2508.02739](https://arxiv.org/abs/2508.02739)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.