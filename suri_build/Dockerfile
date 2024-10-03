FROM ubuntu

RUN apt update -y & apt upgrade -y

RUN apt-get update && apt-get install -y apt-transport-https

RUN apt -y install net-tools curl

RUN apt-get -y install software-properties-common

RUN add-apt-repository -y ppa:oisf/suricata-stable

RUN apt update -y

RUN apt install -y suricata jq

RUN suricata-update

RUN apt install -y pip

# Python flask webserver
WORKDIR /app

# COPY ./flask_server/requirements.txt .
# RUN pip install -r requirements.txt

RUN apt install -y python3-flask

COPY *.rules /var/lib/suricata/rules/

COPY suricata.yaml /etc/suricata/

COPY ./flask_server/main.py /app
COPY ./flask_server/templates/ /app/templates

EXPOSE 80

CMD ["sh", "-c", "suricata -i eth0 & python3 main.py"]
