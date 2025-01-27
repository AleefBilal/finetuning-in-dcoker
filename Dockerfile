FROM nvidia/cuda:12.2.0-base-ubuntu20.04

FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages and CUDA toolkit
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    curl \
    gnupg2 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Add CUDA repository key
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub

# Add CUDA repository to apt sources list
RUN echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /" \
    > /etc/apt/sources.list.d/cuda.list

# Install CUDA Toolkit 12.2
RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-toolkit-12-2 \
    && rm -rf /var/lib/apt/lists/*

# Set the CUDA environment variables
ENV PATH /usr/local/cuda-12.2/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/cuda-12.2/lib64:${LD_LIBRARY_PATH}

# Verify the CUDA installation
RUN apt-get update && apt-get install git-lfs -y && \
    apt-get install -y libsndfile1 ffmpeg &&  \
    apt-get clean && rm -rf /var/lib/apt/lists/* &&  \
    git lfs install

RUN nvcc --version

WORKDIR /



RUN pip3 install torch==2.4.1

COPY requirements.txt .

RUN pip3 install --upgrade pip && \
    pip3 install notebook && \
    pip3 install -r requirements.txt




ENV HF_DATASETS_CACHE="/runpod-volume/datasets"
ENV HUGGINGFACE_HUB_CACHE="/runpod-volume/hub"
ENV TRANSFORMERS_CACHE="/runpod-volume/transformers"
ENV TORCH_CACHE="/runpod-volume/torch"

RUN mkdir /work
WORKDIR /work

ENV PYTHONUNBUFFERED=true

EXPOSE 8900

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8900", "--no-browser", "--allow-root"]
