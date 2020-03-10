# Dockerfile for Compiling OpenCV for Nvidia GPU

Accepts two environment variables:
```
ENV OPENCV_VERSION=4.2.0
ENV OPENCV_CONTRIB_VERSION=4.2.0
```

Defaults to OpenCV 4.2.0 and OpenCV Contrib 4.2.0.

Based on `nvidia/cuda:10.0-devel`.