# VltraRECON

A work-flow oriented bash script aimed at quick deployment of modern bug bounty recon tools in a cloud VPS environment.

### Prerequisites

Cloud VPS: 2 cores, 4GB RAM, Ubuntu 18.04

### Installation

Clone the repository to the "$HOME" directory
```
git clone https://github.com/VltraHeaven/VltraRECON.git $HOME/
```
Give the script execute permissions
```
chmod +x $HOME/VltraRECON/vltrarecon.sh
```
Add your API keys (if so desired) to the shodan_API, config.ini and config.json files and run.
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

sudo -H $HOME/vltrarecon.sh
```
The final output files can be found in $HOME/Targets/


## Built With

* Docker CE (https://github.com/docker/docker-ce)
* OWASP Amass (https://github.com/OWASP/Amass)
* Subfinder (https://github.com/subfinder/subfinder)
* Subjack (https://github.com/haccer/subjack)
* TKO-Subs (https://github.com/anshumanbh/tko-subs)
* MassDNS (https://github.com/blechschmidt/massdns
* Aquatone (https://github.com/michenriksen/aquatone)
* CORScanner (https://github.com/chenjj/CORScanner)
* Masscan (https://github.com/robertdavidgraham/masscan)
* Wafw00f (https://github.com/EnableSecurity/wafw00f.git)
* Shodan-CLI (https://cli.shodan.io/)

## Acknowledgements

Big thank you to the researchers and developers that led to the creation of the tools leveraged in this script and that continue to push the boundaries of knowledge in technology.
