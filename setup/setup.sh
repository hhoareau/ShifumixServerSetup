echo "Installation de ssh"
apt-get update -y
apt-get install -y ssh
echo "PermitRootLogin yes" > /etc/ssh/sshd_config
/etc/init.d/ssh restart

echo "Installation du cockpit"
echo 'deb http://deb.debian.org/debian stretch-backports main' > /etc/apt/sources.list.d/backports.list
apt-get install -y cockpit

echo "Sécurisation du server"
apt-get install -y python-certbot-nginx -t stretch-backports
certbot --nginx -d shifumix.com --email hhoareau@gmail.com
certbot renew --dry-run

echo "Installation de docker"
apt-get install -y curl
curl -fsSL https://get.docker.com | sh
systemctl start docker

echo "Installation du serveur wordpress"
apt-get  install -y python-pip
pip install --upgrade pip
pip install docker-compose
cd /home
rm docker-compose.yml
wget "https://raw.githubusercontent.com/hhoareau/WordpressInDocker/master/docker-compose.yaml"
docker-compose up -d

