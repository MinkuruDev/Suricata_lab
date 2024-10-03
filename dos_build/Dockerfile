FROM alpine

RUN apk update

RUN apk add iputils curl

RUN apk add bash

WORKDIR /app

COPY *.sh ./

ENTRYPOINT [ "./dos.sh" ]
