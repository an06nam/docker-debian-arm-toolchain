# Set debian 12.10 as the base image
FROM debian:12.10

# Set default shell during Docker image build to bash
SHELL ["/bin/bash", "-c"]

# Set non-interactive frontend for apt-get to skip any user confirmations
ENV DEBIAN_FRONTEND=noninteractive

# install dependencies
RUN apt update && apt upgrade -y && \
	apt install -y \
	build-essential \
	locales \
	file \
	git \
	curl \
	wget \
	man\
	gcc-arm-none-eabi \
	cmake \
	make \
	ninja-build \
	libnewlib-arm-none-eabi \
	libnewlib-doc \
	vim \
	sudo \
	clang-format-19 \
	clang-tidy-19 \
	openssh-server

# Create symlink
RUN ln -s $(which clang-format-19) /usr/bin/clang-format && \
	ln -s $(which clang-tidy-19) /usr/bin/clang-tidy

# Create user [ for a better user experiece at least for me ]
RUN useradd -ms /bin/bash user && \
	usermod -aG sudo user && \
	echo 'user:user' | chpasswd

USER user
RUN cd $HOME && \
	wget -c https://github.com/ARM-software/LLVM-embedded-toolchain-for-Arm/releases/download/release-19.1.5/LLVM-ET-Arm-19.1.5-Linux-x86_64.tar.xz && \
	tar xvf *.tar.xz && \
	mv LLVM-ET-Arm-19.1.5-Linux-x86_64 llvm-arm-19 && \
	rm *.tar.xz && \
	cd llvm-arm-19/bin && echo 'export PATH=$PATH:$(pwd)' >> $HOME/.bashrc && \
	cd $HOME && \
	git clone https://github.com/libopencm3/libopencm3.git && \
	mkdir Workspace

USER root
# Clean up stale packages
RUN apt-get clean -y && \
	apt-get autoremove --purge -y && \
	rm -rf /var/lib/apt/lists/*

# Set up sshd working directory
RUN mkdir -p /var/run/sshd && \
    sudo chmod 0755 /var/run/sshd

# Expose SSH port
EXPOSE 22

USER user
WORKDIR /home/user/Workdir
