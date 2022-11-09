[![enoki.so](https://github.com/enoki-inc/alpine-sway-docker/blob/main/aither.gif)](https://enoki.so)

[![Website](https://img.shields.io/static/v1.svg?color=b58900&labelColor=002b36&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=website)](https://enoki.so "check out our landing page!")
[![Github](https://img.shields.io/static/v1.svg?color=b58900&labelColor=002b36&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=github)](https://github.com/enoki-inc "check out our github!")
[![Twitter](https://img.shields.io/static/v1.svg?color=b58900&labelColor=002b36&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=twitter)](https://twitter.com/Enoki_Inc "check out our twitter page!")
[![Linkedin](https://img.shields.io/static/v1.svg?color=b58900&labelColor=002b36&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=linkedin)](https://linkedin.com/company/enoki-inc/ "check out our linkedin page!")

# Aither - Multiplayer Desktop OS

Aither is the first containerized multiplayer desktop OS. By utilizing tailscale, we can make this desktop accessible to any user on same tailscale network that it is authenticated to.

## Instructions

In order to get Aither up and running, please follow these instructions:

1. open terminal and run 
```bash
git clone https://github.com/enoki-inc/aither.git
`````
2. 
```bash
cd aither
```````
3. open tailscale website to retrieve emphemeral key and place it in `tailscale.env` file in `aither` folder
```diff
- TAILSCALE_AUTH_KEY=
+ TAILSCALE_AUTH_KEY=<your key here>
```
4. 
```bash
sudo docker-compose build --no-cache
`````
5. 
```bash
sudo docker-compose up -d
`````
6. 
```bash
sudo docker-compose exec tailscale tailscale up --authkey=$TAILSCALE_AUTH_KEY
`````
7. access the aither desktop container through vnc ports `5900-5910` using a vnc viewer on any device that is authenticated on the same tailscale network
```diff
- 0.0.0.0:<5900-5910>
+ <tailscale_ip>:<5900-5910>
```

Each port is mapped to a different seat, so multiple users can work simultaneously on the containerized desktop, as long as they are accessing the desktop on different ports. For example, user1 can access aither through a vnc viewer on:
```bash
<tailscale_ip>:5900
`````
while user2 can connect on: 
```bash
<tailscale_ip>:5900
`````

## Troubleshooting

1) What if I get a `permission denied` error on `entrypoint.sh` when running `sudo docker-compose up -d`? \
You'll need to make the file executable on your local machine. On the command line, `cd` into the `aither` folder and run: 
```bash
sudo chmod +x entrypoint.sh
`````
2) When viewing Aither through vnc on my mac, why do some of my bindsym shortcuts not work? \
Certain bindsym shortcuts for aither might not work when viewing aither on a mac vnc viewer due to certain macOS key shortcuts.
