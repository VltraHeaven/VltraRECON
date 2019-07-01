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
nano ./config.json
{
        "virustotalApikey": "API_KEY_HERE",
        "passivetotalUsername": "USERNAME_HERE",
        "passivetotalKey": "API_KEY_HERE",
        "securitytrailsKey": "API_KEY_HERE",
        "riddlerEmail": "EMAIL_HERE",
        "riddlerPassword": "PASSWORD_HERE",
        "censysUsername": "USERNAME_HERE",
        "censysSecret": "API_SECRET_HERE",
        "shodanApiKey": "API_KEY_HERE"
}

nano ./config.ini
...
# Uncomment and provide API key information for each applicable data source
#[AlienVault]
#apikey =

#[BinaryEdge]
#apikey =

#[Censys]
#apikey =
#secret =

#[CertDB]
#username = 
#password =

#[CIRCL]
#username =
#password =

#[DNSDB]
#apikey =

#[PassiveTotal]
#username =
#apikey =
...

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
