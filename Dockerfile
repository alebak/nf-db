FROM alpine:3.14

RUN apk update

RUN apk add --no-cache --upgrade bash mysql-client

WORKDIR /usr/local/bin

COPY --chmod=0755 nf-db.sh ./nf-db

CMD ["/bin/bash"]
