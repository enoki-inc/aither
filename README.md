[![enoki.so](https://github.com/enoki-inc/alpine-sway-docker/blob/main/gh-landing.png)](https://enoki.so)

[![Website](https://img.shields.io/static/v1.svg?color=FBBC04&labelColor=003E8A&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=website)](https://enoki.so "check out our landing page!")
[![Github](https://img.shields.io/static/v1.svg?color=FBBC04&labelColor=003E8A&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=github)](https://github.com/enoki-inc "check out our github!")
[![Twitter](https://img.shields.io/static/v1.svg?color=FBBC04&labelColor=003E8A&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=twitter)](https://twitter.com/Enoki_Inc "check out our twitter page!")
[![Linkedin](https://img.shields.io/static/v1.svg?color=FBBC04&labelColor=003E8A&logoColor=ffffff&style=for-the-badge&label=enoki-inc&message=linkedin)](https://linkedin.com/company/enoki-inc/ "check out our linkedin page!")

# Aither
Aither let's you work on software development projects on a browser based full Linux desktop experience powered by ChatGPT and Github Copilot. Sharing your desktop is as easy as running two terminal commands.

<img src="demo.gif" alt="Demo" width="400">

Check out our image on dockerhub: https://hub.docker.com/r/enokiinc/aither

## 🚀 Usage

Try it out at https://enoki.so

### Running locally
All you need is docker installed: 
Docker: https://docker-docs.netlify.app/install/ \

To run locally, clone the repository and run the following:
```bash
sudo docker build -t enoki-base -f Dockerfile .

sudo docker run --name enoki-base \
--privileged \
-e XDG_RUNTIME_DIR=/home/dev \
-e XDG_CACHE_HOME=/home/dev \
-e XDG_CONFIG_HOME=/home/dev/.cache \
-e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
-e WLR_BACKENDS=headless \
-e WLR_LIBINPUT_NO_DEVICES=1 \
-e TEAM_NAME=enoki \
-e WORKSPACE_NAME=test-workspace \
-e USERS=2 \
-e --user=dev \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/home/1000/$WAYLAND_DISPLAY \
-p 6080:6080 \
-p 6081:6081 \
--rm  enoki-base dbus-run-session -- sway
```````
Now you can access the desktop at `0.0.0.0:6080/vnc.html` in your browser

### Sharing your desktop

To share your desktop with someone, first retrieve your free authtoken from ngrok (https://dashboard.ngrok.com/get-started/your-authtoken) and run the following within the terminal of Aither:
```bash
ngrok config add-authtoken <authtoken>
ngrok http 6081
```````
You'll see an ngrok url generated. Share this with your friend and they will have access to your desktop at `<ngrok_url>/vnc_lite.html`. You'll now be able to collaborate together in real-time!

<img src="share.gif" alt="Demo" width="400">


### Using ChatGPT

We enable ChatGPT in Aither using ShellGPT (https://github.com/TheR1D/shell_gpt). 
In order to use ShellGPT, all you need to do is retrieve your `OPENAI_API_KEY` from https://platform.openai.com/account/api-keys and pass it in as an environment variable in the `docker run` command. 

You'll now be able to use ShellGPT in the terminal.
