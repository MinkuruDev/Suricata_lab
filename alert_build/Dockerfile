FROM alpine

RUN apk update

RUN apk add iputils curl

RUN apk add bash

WORKDIR /app

# Remember, NO SPACE
# ENV bot_name=AlertBot1

# ENV webhook_url={put discord webhook url here}

COPY *.sh ./

ENTRYPOINT [ "./ping_alert.sh" ]

CMD [ "suricata", "es01"]
