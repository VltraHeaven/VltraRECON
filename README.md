# VltraRECON

A bash script aimed at quick deployment of modern reconnisance tools in a cloud VPS environment.

### Prerequisites

Cloud VPS: 2 cores, 4GB RAM, Ubuntu 18.04

### Installation

Clone the repository
```
git clone https://github.com/VltraHeaven/VltraRECON.git
```
Give the script execute permissions
```
chmod +x vltrarecon.sh
```
Add your API keys (if so desired) to config.ini and config.json and run
```
vim ./config.json
vim ./config.ini
sudo ./vltrarecon.sh
```
The final output files can be found in $HOME/Targets/


## Built With

* Docker CE (https://github.com/docker/docker-ce)
* OWASP Amass (https://github.com/OWASP/Amass)
* Subfinder (https://github.com/subfinder/subfinder)
* Subjack (https://github.com/haccer/subjack)
* TKO-Subs (https://github.com/anshumanbh/tko-subs)
* MassDNS (https://github.com/blechschmidt/
