# About this images
This image will use debian 12.10 as a base image. using clang toolchain and currently is used to develop firmware for libopencm3. tested on ubuntu 22.04

Your changes within container path $HOME/workspace will affect the workspace directory will be saved within the repo workspace

## Generate and use the image
1. Clone this repo
2. build this image
   ```bash
    docker build -t arm-toolchain -f Dockerfile .
   ```
3. Create the container and mount the workspace direcotry
    ```bash
    docker run -dit --name arm-toolchain \
        -p  2222:22 \
        --mount type=bind,source=Workspace/,target=/home/user/Workspace \
        arm-toolchain
   ```
4. (OPTIONAL) I prefer using vscode and the [Dev Container extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) to login and doing the development
