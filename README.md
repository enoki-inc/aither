# Aither - Multiplayer Desktop OS

We introduce you to Aither, the first containerized multiplayer desktop OS. By utilizing tailscale, we can make this desktop accessible to any user on the tailscale network.

## Instructions

In order to get Aither up and running, please follow these instructions:

1. open terminal and run `git clone https://github.com/enoki-inc/alpine-sway-docker.git`
2. open tailscale website to retrieve emphemeral key and place it in `tailscale.env` file in `alpine-sway-docker` folder
3. `cd alpine-sway-docker`
4. `sudo docker-compose build --no-cache`
5. `sudo docker-compose up -d`
6. `sudo docker-compose exec tailscale tailscale up --authkey=$TAILSCALE_AUTH_KEY`

You can now access the aither desktop container through vnc ports `5900-5910` on any device that is authenticated on same tailscale network

## Troubleshooting

1) What if I get a `permission denied` error on `entrypoint.sh` when running `sudo docker-compose up -d`?
   You'll need to make the file executable on your local machine. To do that, `cd` into the `alpine-sway-docker` folder and run `sudo chmod +x entrypoint.sh`