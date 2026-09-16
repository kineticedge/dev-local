
IMAGE="confluentinc/cp-kafkacat:latest"

docker pull "${IMAGE}" --platform "linux/amd64/v8"

docker run --tty --network dev-local --platform "linux/amd64" "${IMAGE}" \
           kafkacat -b broker-1:9092 -L

