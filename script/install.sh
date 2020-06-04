# Base
apt update &&  apt-get install -y \
    wget \
    curl \
    htop \
    build-essential \
    libxml2 \
    git \
    vim \
    neovim \
    tmux \
    screen \
    sshfs

# NVIDIA CUDA Toolkit
cd /tmp/
wget http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run
sh cuda_10.2.89_440.33.01_linux.run --silent --driver --toolkit
rm -f cuda_10.2.89_440.33.01_linux.run

# NVIDIA CDNN
cd /tmp/
wget http://10.204.100.111:9999/cudnn-10.2-linux-x64-v7.6.5.32.tgz
tar -xzvf cudnn-10.2-linux-x64-v7.6.5.32.tgz
cp cuda/include/cudnn.h /usr/local/cuda/include
cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*