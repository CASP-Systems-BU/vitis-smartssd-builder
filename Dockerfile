FROM ubuntu:20.04



COPY files/* /tmp/

RUN RUN apt-get update && \
    apt-get upgrade -y -qq && \
    apt-get install -y -qq --no-install-recommends \
    build-essential \
    libncurses5-dev \
    libncursesw5-dev \
    libncurses5 \
    libtinfo5 \
    libtinfo-dev \
    libboost-all-dev \
    opencl-clhpp-headers \
    zip \
    unzip \
    # default-jdk \
    \
    && \
    \
    apt-get clean && \
    apt-get autoclean && \
    ln -fs /bin/bash /bin/sh && \
    \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/* && \
    rm -rf /var/cache/* && \
    rm -rf /var/lib/apt/lists/* && \
    \
    cd /tmp && \
    tar -xzf xilinx-u2_2021.2_2021_1021_1001-all.deb.tar.gz && \
    apt install ./xrt*.deb && \
    apt install xilinx-u2-gen3x4-xdma-gc-2-202110-1-dev*.deb && \
    apt install xilinx-u2-gen3x4-xdma-gc-validate_2*.deb && \
    apt install xilinx-u2-gen3x4-xdma-gc-base_2*.deb && \
    \
    mkdir -p /opt/Xilinx && \
    \
    tar -xzf Xilinx_Unified_2021.2_1021_0703.tar.gz &&  \
    \
    ./Xilinx_Unified_2021.2_1021_0703/xsetup \
        --agree 3rdPartyEULA,XilinxEULA \
        --batch Install \
        --config install_config.txt && \
    \
    rm -rf Xilinx_Unified_2021.2_1021_0703* && \
    \
    tar -xzf Xilinx_Vivado_Vitis_Update_2021.2.1_1219_1431.tar.gz &&  \
    \
    ./Xilinx_Vivado_Vitis_Update_2021.2.1_1219_1431/xsetup \
        --agree 3rdPartyEULA,XilinxEULA \
        --batch Install \
        --config install_config.txt && \
    \
    rm -rf Xilinx_Vivado_Vitis_Update_2021.2.1_1219_1431* && \
    \
    unzip y2k22_patch-1.2.zip -d /opt/Xilinx && \
    \
    python3 /opt/Xilinx/y2k22_patch/patch.py && \
    \
    rm -rf /tmp/* && \
    \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/tmp/* && \
    rm -rf /var/cache/* && \
    rm -rf /var/lib/apt/lists/* && \

