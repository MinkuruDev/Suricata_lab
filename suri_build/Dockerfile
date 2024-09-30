FROM ubuntu

RUN apt update -y & apt upgrade -y

RUN apt-get update && apt-get install -y apt-transport-https

RUN apt -y install net-tools curl

RUN apt-get -y install software-properties-common

RUN add-apt-repository -y ppa:oisf/suricata-stable

RUN apt update -y

RUN apt install -y suricata jq

RUN suricata-update

COPY *.rules /var/lib/suricata/rules/

COPY suricata.yaml /etc/suricata/

ENTRYPOINT [ "suricata" ]

CMD [ "-i", "eth0" ]
