[![enoki.so](https://github.com/enoki-inc/alpine-sway-docker/blob/main/gh-landing.png)](https://enoki.so)

[![Website](https://img.shields.io/static/v1.svg?color=FBBC04&labelColor=003E8A&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=website)](https://enoki.so "check out our landing page!")
[![Github](https://img.shields.io/static/v1.svg?color=FBBC04&labelColor=003E8A&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=github)](https://github.com/enoki-inc "check out our github!")
[![Twitter](https://img.shields.io/static/v1.svg?color=FBBC04&labelColor=003E8A&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=twitter)](https://twitter.com/Enoki_Inc "check out our twitter page!")
[![Linkedin](https://img.shields.io/static/v1.svg?color=FBBC04&labelColor=003E8A&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=linkedin)](https://linkedin.com/company/enoki-inc/ "check out our linkedin page!")

# Aither - Multiplayer Desktop Environment

Aither is the first containerized multiplayer desktop environment. By utilizing tailscale, we can make this desktop accessible to any user on the same tailscale network that it is authenticated to.

<img src="https://github.com/enoki-inc/alpine-sway-docker/blob/main/demo-sc-aither.png">

## 🚀 Installation

### Before starting, please make sure you have created a tailscale account and have docker and docker-compose installed on the machine you're hosting Aither on. You will also need to install a vnc viewer on the device within your tailscale network that you want to access Aither with.
Tailscale: https://tailscale.com/ \
Docker: https://docker-docs.netlify.app/install/ \
Docker Compose: https://docker-docs.netlify.app/compose/install/ \
Remmina (vnc viewer for Linux): https://remmina.org/ \
TightVNC (vnc viewer for Windows): https://www.tightvnc.com/ \
RealVNC (vnc viewer for Mac): https://www.realvnc.com/en/ 

### Here is a demo showcasing the installation: 

[![IMAGE ALT TEXT](http://img.youtube.com/vi/dmAuGX1FmcU/0.jpg)](http://www.youtube.com/watch?v=dmAuGX1FmcU "dmAuGX1FmcU")

### In order to get Aither up and running, please follow these instructions:

open terminal and run 
```bash
git clone --branch aither-baseimage https://github.com/enoki-inc/aither.git
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
sudo docker-compose build --no-cache
sudo docker-compose up -d
sudo docker-compose exec tailscale tailscale up --authkey=$TAILSCALE_AUTH_KEY
`````
access the desktop container through vnc ports `5900-5910` using a vnc viewer on any device that is authenticated on the same tailscale network
```diff
- 0.0.0.0:<5900-5910>
+ <tailscale_ip>:<5900-5910>
```
\
Each port is mapped to a different seat, so multiple users can work simultaneously on the containerized desktop, as long as they are accessing the desktop on different ports. For example, user1 can access aither through a vnc viewer on:
```bash
<tailscale_ip>:5900
`````
while user2 can connect on: 
```bash
<tailscale_ip>:5901
`````
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
