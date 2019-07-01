#!/bin/bash

PUR='\033[0;35m'
GRN='\033[0;32m' 
NC='\033[0m' # No Color

clear

echo "Welcome to..."
sleep 1
echo -e "${GRN}║ ║║  ═╔╝╔═║╔═║${PUR}╔═║╔═╝╔═╝╔═║╔═ ${NC}"
echo -e "${GRN}║ ║║   ║ ╔╔╝╔═║${PUR}╔╔╝╔═╝║  ║ ║║ ║${NC}"
echo -e "${GRN} ╝ ══╝ ╝ ╝ ╝╝ ╝${PUR}╝ ╝══╝══╝══╝╝ ╝${NC}"
sleep 1

# Set Working Directory
    cd "$(dirname "$0")"

# Check Root User
if [[ $EUID -ne 0 ]]; 
then
   echo "[+] This script must be run with sudo or as root." 1>&2
   exit 1
fi

# Define Target
# DOMAIN = "USER INPUT"
read -p "[+] Enter the target domain: " DOMAIN

# Confirm
read -p "[+] Continue? (Y/N): " confirm && [[ "$confirm" == [yY] || "$confirm" == [yY][eE][sS] ]] || exit 1

# Check and install dependencies
     echo -e "${PUR}[+] Running updates and installing dependencies using APT package manager. Be sure to stick around until Masscan regression testing completes to confirm if the script should continue!${NC}"
     sleep 3
     apt-get update
     apt-get -y full-upgrade
     apt-get install -y nmap git python-minimal python-pip-whl python2.7 python2.7-minimal build-essential python-all-dev python-setuptools python-wheel golang-1.10 golang-1.10-doc golang-1.10-go golang-1.10-src golang-doc golang-go golang-src chromium-browser gcc make libpcap-dev
     echo -e "${PUR}[+] Updates complete. Checking for script dependencies...${NC}"

    if [ -f /usr/bin/docker ]
    then
        echo -e "${PUR}[+] Docker is installed${NC}"
        systemctl restart docker.service
    else
        echo -e "${PUR}[+] Installing Docker CE...${NC}"
        apt-get remove docker docker-engine docker.io containerd runc
        apt-get update
        apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        apt-get update
        apt-get install -y docker-ce docker-ce-cli containerd.io
        systemctl start docker.service
        echo -e "${PUR}[+] Docker installed successfully!${NC}"
    fi

    if [ -d $HOME/Git ]
    then 
        echo -e "${PUR}[+] Git Repository Exists${NC}"
    else 
        echo -e "${PUR}[+] Creating Git Repository...${NC}"
        mkdir -p $HOME/Git
        echo -e "${PUR}[+] Git Repository created successfully!${NC}"
    fi

    if [ -d $HOME/Targets/"$DOMAIN" ]
    then
        echo -e "${PUR}[+] Target's workspace exists.${NC}"
    else
        echo -e "${PUR}[+] Creating Target workspace...${NC}"
        mkdir -p $HOME/Targets/"$DOMAIN"
        echo -e "${PUR}[+] Target's workspace created successfully!${NC}"
    fi

    if [ -d $HOME/Git/Amass ]
    then
        echo -e "${PUR}[+] OWASP Amass is already installed.${NC}" 
    else
        echo -e "${PUR}[+] Installing OWASP Amass...${NC}"
        git clone https://github.com/OWASP/Amass.git $HOME/Git/Amass
        docker build -t amass:latest $HOME/Git/Amass/
        mkdir -p $HOME/Git/Amass/config
        cp ./config.ini $HOME/Git/Amass/config/
        echo -e "${PUR}[+] Amass installed successfully!${NC}"
    fi

    if [ -d $HOME/Git/subfinder ]
    then
        echo -e "${PUR}[+] Subfinder is already installed.${NC}"
    else
        echo -e "${PUR}[+] Installing Subfinder...${NC}"
        git clone https://github.com/subfinder/subfinder.git $HOME/Git/subfinder
        mkdir -p $HOME/Git/subfinder/config
        cp ./dns-Haddix_CSpeak.txt $HOME/Git/subfinder/config
        cp ./config.json $HOME/Git/subfinder/config
        docker build -t subfinder:latest $HOME/Git/subfinder
        echo -e "${PUR}[+] Subfinder installed successfully!${NC}"
    fi

    if [ -f /usr/local/bin/subjack ]
    then 
        echo -e "${PUR}[+] Subjack is already installed.${NC}"
    else
        echo -e "${PUR}[+] Installing Subjack...${NC}"
        go get github.com/haccer/subjack
        cp $HOME/go/bin/subjack /usr/local/bin
        echo -e "${PUR}[+] Subjack installed successfully!${NC}"
    fi

    if [ -d $HOME/Git/tko-subs ]
    then 
        echo -e "${PUR}[+] TKO-Subs is already installed.${NC}"
    else
        echo -e "${PUR}[+] Installing TKO-Subs...${NC}"
        git clone https://github.com/anshumanbh/tko-subs.git $HOME/Git/tko-subs
        docker build -t tko-subs:latest $HOME/Git/tko-subs; echo "[+] TKO-Subs installed successfully!${NC}"
    fi

    if [ -f /usr/local/bin/massdns ]
    then 
        echo -e "${PUR}[+] MassDNS is already installed.${NC}"
    else
        echo -e "${PUR}[+] Installing MassDNS...${NC}"
        git clone https://github.com/blechschmidt/massdns.git $HOME/Git/massdns
        cd $HOME/Git/massdns
        make -C $HOME/Git/massdns/
        cp $HOME/Git/massdns/bin/massdns /usr/local/bin
        cd "$(dirname "$0")"
        echo -e "${PUR}[+] MassDNS installed successfully!${NC}"
    fi

    if [ -f /usr/local/bin/aquatone ]
    then 
        echo -e "${PUR}[+] Aquatone is already installed.${NC}"
    else
        echo -e "${PUR}[+] Installing Aquatone...${NC}"
        go get github.com/michenriksen/aquatone
        cp $HOME/go/bin/aquatone /usr/local/bin
        echo -e "${PUR}[+] Aquatone is installed successfully!${NC}"
    fi

    if [ -f $HOME/Git/CORScanner/cors_scan.py ]
    then
        echo -e "${PUR}[+] CORScanner is already installed.${NC}"
    else
        echo -e "${PUR}[+] Installing CORScanner...${NC}"
        git clone https://github.com/chenjj/CORScanner.git $HOME/Git/CORScanner
        pip2 install -r $HOME/Git/CORScanner/requirements.txt
        echo -e "${PUR}[+] CORScanner has been installed successfully!${NC}"
    fi

    if [ -f /usr/local/bin/masscan ]
    then
        echo -e "${PUR}[+] Masscan is already installed.${NC}"
    else
        echo -e "${PUR}[+] Installing Masscan...${NC}"
        git clone https://github.com/robertdavidgraham/masscan $HOME/Git/masscan
        cd $HOME/Git/masscan
        make -C $HOME/Git/masscan
        cp $HOME/Git/masscan/bin/masscan /usr/local/bin
        cd "$(dirname "$0")"
        masscan --regress
        read -p "Continue? (Y/N): " confirm && [[ "$confirm" == [yY] || "$confirm" == [yY][eE][sS] ]] || exit 1
        echo -e "${PUR}[+] Masscan has been installed successfully.${NC}"
    fi

    if [ -f /usr/local/bin/wafw00f ]
    then
        echo -e "${PUR}[+] wafw00f is already installed.${NC}"
    else
        echo -e "${PUR}[+] Installing wafw00f...${NC}"
        git clone https://github.com/EnableSecurity/wafw00f.git $HOME/Git/wafw00f
        cd $HOME/Git/wafw00f
        python $HOME/Git/wafw00f/setup.py install
        cd "$(dirname "$0")"
        echo -e "${PUR}[+] wafw00f has been installed successfully!${NC}"
    fi

# Running Subdomain Recon
echo -e "${PUR}[+] Dependencies installed and Docker service started. Starting ${GRN}Vltra${PUR}Recon...${NC}"

# Amass in docker container
/usr/bin/docker run -v $HOME/Git/Amass/config/:/root/config -v $HOME/Targets/"$DOMAIN":/root/"$DOMAIN" amass enum --passive -d "$DOMAIN" --config /root/config/config.ini -o /root/"$DOMAIN"/amass_results.txt

# Subfinder in docker container
/usr/bin/docker run -v $HOME/Git/subfinder/config:/root/.config/subfinder -v $HOME/Targets/"$DOMAIN":/root/"$DOMAIN" -it subfinder -d "$DOMAIN" -nW -b -w /root/.config/subfinder/dns-Haddix_CSpeak.txt -t 100 -v -oD /root/"$DOMAIN" -o subfinder_results.txt

# Cleanup
cat $HOME/Targets/"$DOMAIN"/amass_results.txt >> $HOME/Targets/"$DOMAIN"/subdomains_unsorted.txt
cat $HOME/Targets/"$DOMAIN"/subfinder_results.txt >> $HOME/Targets/"$DOMAIN"/subdomains_unsorted.txt
sort -u $HOME/Targets/"$DOMAIN"/subdomains_unsorted.txt >> $HOME/Targets/"$DOMAIN"/subdomains_unresolved.txt

# Resolving enumerated subdomains with MassDNS, simple and json output
cat $HOME/Targets/"$DOMAIN"/subdomains_unresolved.txt| /usr/local/bin/massdns -r $HOME/Git/massdns/lists/resolvers.txt -t A -o S -w $HOME/Targets/"$DOMAIN"/subdomains_resolved.txt
cat $HOME/Targets/"$DOMAIN"/subdomains_unresolved.txt| /usr/local/bin/massdns -r $HOME/Git/massdns/lists/resolvers.txt -t A -o J -w $HOME/Targets/"$DOMAIN"/subdomains_resolved.json --flush

# Parse Subdomains and IP addresses into separate output
sed 's/^.*A //' $HOME/Targets/"$DOMAIN"/subdomains_resolved.txt | sed 's/^.*CNAME //' | sort -u >> $HOME/Targets/"$DOMAIN"/ip_addresses.txt
sed 's/\s.*$//' $HOME/Targets/"$DOMAIN"/subdomains_resolved.txt | sort -u >> $HOME/Targets/"$DOMAIN"/subdomains_final.txt

# Remove trash
rm -rf $HOME/Targets/"$DOMAIN"/amass_results.txt $HOME/Targets/"$DOMAIN"/subfinder_results.txt $HOME/Targets/"$DOMAIN"/subdomains_unresolved.txt $HOME/Targets/"$DOMAIN"/subdomains_resolved.txt

# Check for subdomain takeover with Subjack and TKO-Subs
/usr/local/bin/subjack -w $HOME/Targets/"$DOMAIN"/subdomains_final.txt -t 100 -timeout 30 -o $HOME/Targets/"$DOMAIN"/subjack_results.txt -ssl
docker run -v $HOME/Targets/"$DOMAIN":/mnt/Target tko-subs -domains=/mnt/Target/subdomains_final.txt -data=providers-data.csv -output=/mnt/Target/tko-subs_results.csv

# WAF Enumeration
/usr/local/bin/wafw00f $(cat $HOME/Targets/"$DOMAIN"/subdomains_final.txt) -a -v 2>&1 | tee $HOME/Targets/"$DOMAIN"/wafw00f_results.txt

# CORS Vuln Scan
python2 $HOME/Git/CORScanner/cors_scan.py -i $HOME/Targets/"$DOMAIN"/subdomains_final.txt -t 100 -v -o $HOME/Targets/"$DOMAIN"/cors_scan_results.txt

# Aquatone Flyover
cat $HOME/Targets/"$DOMAIN"/subdomains_final.txt | /usr/local/bin/aquatone -ports xlarge -out $HOME/Targets/"$DOMAIN"/aquatone_results

# PortScan
nmap -T4 -sC -sV --script=banner -oA $HOME/Targets/"$DOMAIN"/nmap_results.txt $(cat $HOME/Targets/"$DOMAIN"/ip_addresses.txt)

#Docker Cleanup
echo -e "${PUR}[+] Cleaning up dangling Docker containers and images${NC}"
docker image prune -f
docker container prune -f

echo -e "${PUR}[+] Recon Complete!! Results saved in $HOME/Targets/"$DOMAIN", Thanks for playing!!${NC}"
exit 0