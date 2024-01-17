FROM alpine:3.14

RUN apk update && apk upgrade --no-cache

RUN apk add --no-cache mysql-client

ENTRYPOINT ["mysql"]
