# Suricata lab Docker

A Suricata lab in Docker to test IPS/IDS, Dashboard is powered by Kibana

![diagram](./images/Suricata_lab_2.drawio.png)

## Quickstart

1. Clone the repo:
```bash
git clone https://github.com/MinkuruDev/Suricata_lab.git
cd Suricata_lab
```

2. Change `.env.example` to `.env`

Linux/bash:
```bash
mv .env.example .env
```
Windows/cmd:
```cmd
ren .env.example .env
```

3. Change the value of `ELASTIC_PASSWORD`, `KIBANA_PASSWORD` and `DISCORD_WEBHOOK` in `.env`

4. Run the lab:
```bash
docker compose up -d
```

5. Take a coffee. It take about a minitue to run if cached

Wait the container `filebeat_setup` to auto exit(0)

6. Test the Suricata IDS:

*NOTE: folder name is `suricata` so the network name is `suricata_elastic_net`, you should change the value to match the network name, if you follow the instruction, it will likely named: `suricata_lab_elastic_net`*

Test nmap detection:
```bash
docker run --rm -it --network suricata_elastic_net instrumentisto/nmap -sV -v -p 0-1024 suricata
```

Test sql injection detection:
```bash
docker run --rm -it --network suricata_elastic_net googlesky/sqlmap:latest-alpine http://suricata?page=1 --dbs
```

Test dos detection
```bash
docker run --rm -it --network suricata_elastic_net minkurudev/dos:0.0.1 http://suricata
```
