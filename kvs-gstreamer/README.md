# KVS Gstreamer


Needs the following environment variables (either pass in the variables one at a time or add an .env file like I did and pass them in.)

```shell
STREAM_NAME=""
AWS_REGION=""
AWS_ACCESS_KEY=""
AWS_SECRET_KEY=""
```

Run `docker build --pull --rm -f "Dockerfile" -t kvs-gstreamer:latest "."` to build docker image.

Run `docker run --rm --env-file .env --network="host" --device=/dev/video0 --name kvs-gstreamer kvs-gstreamer:latest` to run the gstreamer producer.

(Note: Docker image name might not be the same as mine.)
