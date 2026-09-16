#
# Example aliases to consider for your local environment
#

alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.RunningFor}}\t{{.Status}}\t{{.Size}}\t{{.Ports}}"'

alias kt='kafka-topics --bootstrap-server localhost:19092,localhost:29092,localhost:39092'

alias kcc='kafka-console-consumer \
        --bootstrap-server localhost:19092,localhost:29092,localhost:39092 \
        --key-deserializer=org.apache.kafka.common.serialization.BytesDeserializer  \
        --property print.key=true \
        --property key.separator=" | " \
        --from-beginning \
        --topic '

alias kccv='kafka-console-consumer \
        --bootstrap-server localhost:19092,localhost:29092,localhost:39092 \
        --from-beginning \
        --topic'

alias kacc='kafka-avro-console-consumer \
        --bootstrap-server localhost:19092,localhost:29092,localhost:39092 \
        --property schema.registry.url="http://localhost:8081" \
        --key-deserializer=org.apache.kafka.common.serialization.BytesDeserializer \
        --property print.key=true \
        --property key.separator=" | " \
        --from-beginning --topic'

alias kaccv='kafka-avro-console-consumer \
        --bootstrap-server localhost:19092,localhost:29092,localhost:39092 \
        --property schema.registry.url="http://localhost:8081" \
        --from-beginning --topic'
