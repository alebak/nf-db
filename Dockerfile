FROM alpine:3.14

RUN apk update

RUN apk add --no-cache --upgrade bash mysql-client

ENTRYPOINT ["mysql"]
