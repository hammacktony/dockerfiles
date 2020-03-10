FROM nvidia/cuda:10.0-devel

# Download & build OpenCV 4.2.0
RUN apt update && apt install -y wget \
    libgtk2.0-dev \ 
    pkg-config \ 
    libavcodec-dev \ 
    libavformat-dev \ 
    libswscale-dev \ 
    libtbb2 \
    libtbb-dev \ 
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libdc1394-22-dev \
    x11-apps \
    wget \
    ffmpeg \
    unzip \
    libcanberra-gtk-module \
    cmake \
    && rm -rf /var/lib/apt/lists/* 

# Default to 4.2.0
ENV OPENCV_VERSION=4.2.0
ENV OPENCV_CONTRIB_VERSION=4.2.0

# Download OpenCV
RUN wget -q -P /usr/local/src/ --no-check-certificate https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
    && unzip /usr/local/src/${OPENCV_VERSION}.zip -d /usr/local/src \
    && rm /usr/local/src/${OPENCV_VERSION}.zip 

# Download OpenCV Contrib
RUN wget -q -P /usr/local/src/ --no-check-certificate https://github.com/opencv/opencv_contrib/archive/${OPENCV_CONTRIB_VERSION}.zip \
    && unzip /usr/local/src/${OPENCV_CONTRIB_VERSION}.zip -d /usr/local/src \
    && rm /usr/local/src/${OPENCV_CONTRIB_VERSION}.zip 

# Get to the right place
RUN cd /usr/local/src/opencv-${OPENCV_VERSION}/ \
    && mkdir build \
    && cd /usr/local/src/opencv-${OPENCV_VERSION}/build
WORKDIR /usr/local/src/opencv-${OPENCV_VERSION}/build

# Prep
RUN cmake -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-${OPENCV_CONTRIB_VERSION}/modules -DWITH_CUDA=ON -DBUILD_EXAMPLES=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local/ ..

# Build
RUN make -j8
RUN make install

# Cleanup
WORKDIR /
RUN rm -rf /usr/local/src/opencv-${OPENCV_VERSION}
