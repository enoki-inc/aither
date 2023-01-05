[![enoki.so](https://github.com/enoki-inc/alpine-sway-docker/blob/main/gh-landing.png)](https://enoki.so)

[![Website](https://img.shields.io/static/v1.svg?color=FBBC04&labelColor=003E8A&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=website)](https://enoki.so "check out our landing page!")
[![Github](https://img.shields.io/static/v1.svg?color=FBBC04&labelColor=003E8A&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=github)](https://github.com/enoki-inc "check out our github!")
[![Twitter](https://img.shields.io/static/v1.svg?color=FBBC04&labelColor=003E8A&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=twitter)](https://twitter.com/Enoki_Inc "check out our twitter page!")
[![Linkedin](https://img.shields.io/static/v1.svg?color=FBBC04&labelColor=003E8A&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=linkedin)](https://linkedin.com/company/enoki-inc/ "check out our linkedin page!")

# Aither - Browser-Based Multiplayer Desktop Environment

Aither is the browser-based version of our containerized multiplayer desktop environment Aither. By utilizing tailscale, we can make this desktop accessible in the web browser of any user on the same tailscale network that it is authenticated to.

Check out our image on dockerhub: https://hub.docker.com/r/enokiinc/aither

<img src="https://github.com/enoki-inc/aither/blob/66e1b3da29111920ee5825629ce89e4ea4d84275/Aither%20Desktop.jpg">

## 🚀 Installation

### Before starting, please make sure you have created a tailscale account and have docker and docker-compose installed on the machine you're hosting Aither on.
Tailscale: https://tailscale.com/ \
Docker: https://docker-docs.netlify.app/install/ \
Docker Compose: https://docker-docs.netlify.app/compose/install/

### Here is a demo showcasing the installation: 

[![IMAGE ALT TEXT](http://img.youtube.com/vi/Z7jxQPwqZGc/0.jpg)](http://www.youtube.com/watch?v=Z7jxQPwqZGc "Z7jxQPwqZGc")

### In order to get Aither up and running, please follow these instructions:

open terminal and run 
```bash
git clone --branch aither-ubuntu https://github.com/enoki-inc/aither.git
cd aither
```````
within your account on tailscale's website, navigate to the auth keys page of the admin console to retrieve an emphemeral key (screenshot below) \
<img src="https://tailscale.com/kb/1132/flydotio/ephemeral-keys.png" width="450" height="450"> \
copy the generated ephemeral key into the `tailscale.env` file within the `aither` folder
```diff
- TAILSCALE_AUTH_KEY=
+ TAILSCALE_AUTH_KEY=<your key here>
```
```bash
sudo docker-compose up -d
sudo docker-compose exec tailscale tailscale up --authkey=$TAILSCALE_AUTH_KEY
`````
access the desktop container within the browser through ports `6080-6090` on any device that is authenticated on the same tailscale network using the url below:
```diff
- 0.0.0.0:<6080-6090>/vnc.html
+ <tailscale_ip>:<6080-6090>/vnc.html
```
\
Each port is mapped to a different seat, so multiple users can work simultaneously on the containerized desktop, as long as they are accessing the desktop on different ports. For example, user1 can access aither web through this url:
```bash
<tailscale_ip>:6080/vnc.html
`````
while user2 can connect by navigating to this url: 
```bash
<tailscale_ip>:6081/vnc.html
`````
### NOTE: If you have slow internet speed, you can improve Aither performance by reducing quality and maximizing compression in noVNC settings.

## 🔑 Keybinds 
These are basic keybinds for Aither:
|        Keybind         |                 Function                 |
| ---------------------- | ---------------------------------------- |
| `Alt + drag window`    | move window around while holding Alt key                |
| `Alt + H/J/K/L`        | move focused floating window left/down/up/right        |
| `Alt + left/down/up/right`      | move focused floating window left/down/up/right                      |
| `Alt + Shift + H/J/K/L`              | move focus around left/down/up/right                 |
| `Alt + Shift + down/up`              | shrink/grow focused floating window vertically               |
| `Alt + Shift + left/right`           | shrink/grow focused floating window horizontally                              |
| `Alt + 1>9`     | mark window for seat1>9 for specific border colors                         |

## 🔨 Troubleshooting

1) What if I get a `permission denied` error on `entrypoint.sh` when running `sudo docker-compose up -d`? \
You'll need to make the file executable on your local machine. On the command line, `cd` into the `aither` folder and run: 
```bash
sudo chmod +x entrypoint.sh
`````
2) When viewing Aither through vnc on my mac, why do some of my bindsym shortcuts not work? \
Certain bindsym shortcuts for aither might not work when viewing aither on a mac vnc viewer due to certain macOS key shortcuts.

## ⏳ Star History

[![Star History Chart](https://api.star-history.com/svg?repos=enoki-inc/aither&type=Date)](https://star-history.com/#enoki-inc/aither&Date)
