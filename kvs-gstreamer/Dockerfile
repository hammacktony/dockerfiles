FROM ubuntu:18.04
LABEL version="1.0" maintainer="Tony Hammack <hammack.tony@gmail.com>"

# General install
RUN apt-get update; apt-get install -y nano \
    git \
    pkg-config \
    cmake \
    m4

# GStreamer stuff
RUN apt-get install -y libssl-dev \
    libcurl4-openssl-dev \
    liblog4cplus-dev \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    gstreamer1.0-plugins-base-apps \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-ugly \ 
    gstreamer1.0-tools


# Clone directory
WORKDIR /opt/kvs
RUN git clone --recursive https://github.com/awslabs/amazon-kinesis-video-streams-producer-sdk-cpp.git


# Build file
RUN cd amazon-kinesis-video-streams-producer-sdk-cpp && mkdir build && cd build && \ 
    cmake -DBUILD_GSTREAMER_PLUGIN=ON .. && \
    make -j${nproc}

# Cleanup -> Remove everything not necessary
RUN cd amazon-kinesis-video-streams-producer-sdk-cpp && \
    find . ! -name "build" ! -name "open-source" -maxdepth 1 -type f -delete

# Stream stuff and aws stuff
ENV STREAM_NAME=""
ENV AWS_REGION=""
ENV AWS_ACCESS_KEY=""
ENV AWS_SECRET_KEY=""

WORKDIR /opt/kvs/amazon-kinesis-video-streams-producer-sdk-cpp

CMD export GST_PLUGIN_PATH=`pwd`/build && \
    export LD_LIBRARY_PATH=`pwd`/open-source/local/lib && \
    gst-launch-1.0 v4l2src do-timestamp=TRUE device=/dev/video0 \
    ! videoconvert \
    ! video/x-raw,format=I420,width=640,height=480,framerate=30/1 \
    ! x264enc  bframes=0 key-int-max=45 bitrate=500 \
    ! video/x-h264,stream-format=avc,alignment=au,profile=baseline \
    ! kvssink stream-name=$STREAM_NAME storage-size=512 \
    access-key=$AWS_ACCESS_KEY secret-key=$AWS_SECRET_KEY aws-region=$AWS_REGION
