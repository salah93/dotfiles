# https://www.digitalocean.com/community/tutorials/how-to-use-doctl-the-official-digitalocean-command-line-client
# wget https://github.com/digitalocean/doctl/releases/download/v1.6.0/doctl-1.6.0-linux-amd64.tar.gz
# tar xf doctl-1.6.0-linux-amd64.tar.gz
# mv doctl ~/.scripts
# doctl auth init


if [ "$#" -ne 1 ]; then
    echo Creating droplet...
    DROPLET_ID=$(doctl compute droplet create notebook-`date +%Y%m%d-%H%M` --image 21190386 --region nyc3 --size 1gb --ssh-keys d0:e8:09:c3:ef:17:28:74:bf:8c:48:f8:da:a2:5a:ff --output json --wait | jq '.[0]["id"]')
    echo DROPLET_ID=$DROPLET_ID
    echo
else
    DROPLET_ID=$1
fi;

echo Getting ip address...
DROPLET_IP_ADDRESS=$(doctl compute droplet get $DROPLET_ID --format PublicIPv4 --no-header)
echo DROPLET_IP_ADDRESS=$DROPLET_IP_ADDRESS
echo

echo Running ansible scripts...
echo [notebooks] > /tmp/inventory
echo $DROPLET_IP_ADDRESS >> /tmp/inventory
ssh root@$DROPLET_IP_ADDRESS bash -c 'dnf install python2-dnf'
if ansible-playbooks -i /tmp/inventory ~/Projects/setup_server/playbook.yml; then
echo nice dude
cat <<EOF >> ~/.ssh/config

Host remote
    User goku
    HostName $DROPLET_IP_ADDRESS
    IdentityFile ~/.ssh/id_rsa
EOF
else
echo !!! ANSIBLE SCRIPTS FAILED !!!
echo DROPLET_ID=$DROPLET_ID
echo DROPLET_IP_ADDRESS=$DROPLET_IP_ADDRESS
fi
