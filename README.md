[![enoki.so](https://github.com/enoki-inc/alpine-sway-docker/blob/main/aither.png)](https://enoki.so)

[![Website](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=website)](https://enoki.so "check out our landing page!")
[![Contact](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=contact)](founders@enoki.so "send us an email anytime!")
[![Github](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=github)](https://github.com/enoki-inc "check out our github!")
[![Reddit](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=reddit)](https://github.com/enoki-inc "check out our reddit account!")

# Aither - Multiplayer Desktop OS

Aither is the first containerized multiplayer desktop OS. By utilizing tailscale, we can make this desktop accessible to any user on same tailscale network that it is authenticated to.

## Instructions

In order to get Aither up and running, please follow these instructions:

1. open terminal and run 
```bash
git clone https://github.com/enoki-inc/alpine-sway-docker.git
`````
2. open tailscale website to retrieve emphemeral key and place it in `tailscale.env` file in `alpine-sway-docker` folder
```diff
- TAILSCALE_AUTH_KEY: tskey-abc123
+ TAILSCALE_AUTH_KEY: <your key here>
```
3. 
```bash
cd alpine-sway-docker
```````
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
7. Access the aither desktop container through vnc ports `5900-5910` using a vnc viewer on any device that is authenticated on the same tailscale network
```diff
- 0.0.0.0:<59000-5910>
+ <tailscale_ip>:<5900-5910>
```

Each port is mapped to a different seat, so multiple users can work simulataneously on the containerized desktop, as long as they are accessing the desktop on different ports. 

## Troubleshooting

1) What if I get a `permission denied` error on `entrypoint.sh` when running `sudo docker-compose up -d`?
   You'll need to make the file executable on your local machine. To do that, `cd` into the `alpine-sway-docker` folder and run `sudo chmod +x entrypoint.sh`
