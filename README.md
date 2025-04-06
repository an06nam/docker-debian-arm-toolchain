# About this repo
This image will be used to develop firmware for bms based on stm32f407 chip.

The changes within container path $HOME/workspace will affect the workspace directory will be saved within the repo workspace

   
## Generate and use the image
1. Clone this repo
   ```bash
   git clone https://github.com/an06nam/BMS-STM32-Firmware.git
   cd BMS-STM32-Firmware
   ```
2. Install Dependencies for flashing and debuggin the firmware
   
    NOTE : DEFAULT CONTAINER PASSWORD will be 'user'
    
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
   docker build -t bms-firmware -f Dockerfile .
   ```
5. Create the container and mount the workspace direcotry
    ```bash
    docker run -dit --name bms-firmware \
       -p  2222:22 \
       --mount type=bind,source=$(pwd)/Workspace/,target=/home/user/Workspace \
       bms-firmware
   ```
