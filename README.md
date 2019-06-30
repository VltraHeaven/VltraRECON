Welcome to...
║ ║║  ═╔╝╔═║╔═║╔═║╔═╝╔═╝╔═║╔═ 
║ ║║   ║ ╔╔╝╔═║╔╔╝╔═╝║  ║ ║║ ║
 ╝ ══╝ ╝ ╝ ╝╝ ╝╝ ╝══╝══╝══╝╝ ╝

A bash script aimed at quick deployment of modern reconnisance tools in a cloud VPS environment. 

Tested on an Ubuntu 18.04 DigitalOcean Droplet and Vultr VPS (2 Processors, 4086 GB RAM).

This script leverages the following technologies on an Ubuntu 18.04 VPS for Bug Bounty/Web Application Penetration Testing reconnaissance:

> Docker CE (https://github.com/docker/docker-ce)
> OWASP Amass [Containerized] (https://github.com/OWASP/Amass)
> Subfinder [Containerized](https://github.com/subfinder/subfinder)
> Subjack (https://github.com/haccer/subjack)
> TKO-Subs [Containerized] (https://github.com/anshumanbh/tko-subs)
> MassDNS (https://github.com/blechschmidt/massdns)
> Aquatone (https://github.com/michenriksen/aquatone)
> CORScanner (https://github.com/chenjj/CORScanner)
> Masscan (https://github.com/robertdavidgraham/masscan)
> Wafw00f (https://github.com/EnableSecurity/wafw00f) 
> Jason Haddix's DNS wordlist from Seclists (https://github.com/danielmiessler/SecLists) concatenated with the latest Commonspeak Wordlist (https://github.com/pentester-io/commonspeak).

Installation:

# Clone the repository:

git clone https://github.com/VltraHeaven/VltraRECON.git

# Give the script execute permissions

chmod +x vltrarecon.sh

# Add your API keys (if so desired) to config.ini and config.json and run.

sudo ./vltrarecon.sh

The final output files can be found in $HOME/Targets/
