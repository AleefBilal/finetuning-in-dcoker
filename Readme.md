
# Fine-Tuning Llama 3.1 Inside Docker

This project provides a Docker setup for fine-tuning the Llama 3.1 model. The Dockerfile installs the necessary dependencies and sets up the environment for training. This guide will help you understand how to build and run the Docker container for your fine-tuning tasks using jupyter notebook.

## Prerequisites

Before you begin, ensure you have the following installed on your machine:

- Docker
- NVIDIA GPU (with CUDA support)

## Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd <repository-folder>
```

### 2. Build the Docker Image

Run the following command to build the Docker image:

```bash
docker build -t llama-finetune .
```

### 3. Run the Docker Container

To start the container, execute in the same folder that contains the notebook and other data:

```bash
docker run --rm -it --gpus all -p 8900:8900 -v <local-data-dir>:/runpod-volume llama-finetune
```
For this particular docker, we used command

```bash
docker run -it --rm -v ~/.cache/huggingface:/runpod-volume -v ./llama3.1:/work -p 8900:8900 asdkazmi/docker-fine-tuning:0.0.1
```


Replace `<local-data-dir>` with the path to your local dataset directory.

### 4. Access the Jupyter Notebook

Once the container is running, you can access Jupyter Notebook by navigating to `http://localhost:8900` in your web browser. You can start creating or editing notebooks for fine-tuning the model.

## Dockerfile Overview

Here's a breakdown of the Dockerfile:

- **Base Images**: The image uses NVIDIA's CUDA base image for GPU support and Python 3.11 slim image for a lightweight environment.
- **Installing Packages**: Essential packages, CUDA Toolkit, and Python dependencies are installed.
- **Setting Environment Variables**: CUDA paths and cache directories for Hugging Face datasets and model storage are set.
- **Exposing Ports**: Port `8900` is exposed for Jupyter Notebook access.
- **Starting Jupyter Notebook**: The container runs a Jupyter Notebook server on startup.

## Requirements

Make sure to include a `requirements.txt` file in your project directory containing any additional Python packages you need for your fine-tuning task. The Dockerfile installs packages such as `torch`, `nemo_toolkit`, and `llama-cpp-python`.

## Fine-Tuning Steps

1. **Load the Dataset**: Ensure your dataset is correctly structured and accessible in the specified volume path.
2. **Modify Training Scripts**: Create or modify Jupyter Notebooks to include the fine-tuning logic for the Llama 3.1 model.
3. **Run Training**: Execute the cells in your Jupyter Notebook to start the fine-tuning process.

## Troubleshooting

- If you encounter issues with CUDA installation, ensure your GPU drivers are up to date.
- Check Docker logs for any errors using:
  ```bash
  docker logs <container-id>
  ```

## Conclusion

This Docker setup simplifies the process of fine-tuning the Llama 3.1 model. Modify the provided instructions as needed for your specific use case, and leverage the power of Docker to manage your machine learning environments effectively.

