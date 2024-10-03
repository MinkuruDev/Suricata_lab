FROM docker.elastic.co/beats/filebeat:8.15.0

WORKDIR /usr/share/filebeat

COPY filebeat.yml .

RUN filebeat modules enable suricata

COPY suricata.yml ./modules.d
