docker run --rm -it \
    --env-file .env \
    --network="host" \
    --device=/dev/video0 \
    --name kvs-gstreamer \
    kvs-gstreamer:latest
