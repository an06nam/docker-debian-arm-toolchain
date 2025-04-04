# About this repo
This image will be used to develop firmware for bms based on stm32f407 chip.

The changes within container path $HOME/workspace will affect the workspace directory will be saved within the repo workspace

   NOTE : DEFAULT CONTAINER PASSWORD will be 'user'
   
## Generate and use the image
1. Clone this repo
   ```bash
   git clone https://github.com/an06nam/docker-debian-arm-toolchain.git
   cd docker-debian-arm-toolchain
   ```
2. Install Dependencies for flashing and debuggin the firmware
   ```bash
   sudo apt update && sudo apt install -y \
      build-essential \
      ca-certificates \
      openocd \
      gdb-multiarch \
      stlink-tools
   ```
4. abuild this image
   ```bash
   docker build -t arm-toolchain -f Dockerfile .
   ```
5. Create the container and mount the workspace direcotry
    ```bash
    docker run -dit --name arm-toolchain \
       -p  2222:22 \
       --mount type=bind,source=$(pwd)/Workspace/,target=/home/user/Workspace \
       arm-toolchain
   ```
