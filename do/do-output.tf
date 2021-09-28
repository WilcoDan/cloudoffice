output "cloudblock-output" {
  value = <<OUTPUT

#############
## OUTPUTS ##
#############

## SSH ##
ssh ubuntu@${digitalocean_droplet.nc-droplet.ipv4_address}

## WebUI ##
${var.enable_duckdns == 1 && var.web_port == "443" ? "https://${var.duckdns_domain}/nc/" : ""}${var.enable_duckdns == 1 && var.web_port != "443" ? "https://${var.duckdns_domain}:${var.web_port}/nc/" : ""}${var.enable_duckdns == 0 && var.web_port == "443" ? "https://${digitalocean_droplet.nc-droplet.ipv4_address}/" : ""}${var.enable_duckdns == 0 && var.web_port != "443" ? "https://${digitalocean_droplet.nc-droplet.ipv4_address}:${var.web_port}/" : ""}

## ############## ##
## One Time Setup ##
## ############## ##
scp ${var.nc_prefix}-setup-${random_string.nc-random.result}.sh ubuntu@${digitalocean_droplet.nc-droplet.ipv4_address}:~/${var.nc_prefix}-setup-${random_string.nc-random.result}.sh
ssh ubuntu@${digitalocean_droplet.nc-droplet.ipv4_address} "chmod +x ${var.nc_prefix}-setup-${random_string.nc-random.result}.sh && ~/${var.nc_prefix}-setup-${random_string.nc-random.result}.sh"

## ################### ##
## Update Instructions ##
## ################### ##
ssh ubuntu@${digitalocean_droplet.nc-droplet.ipv4_address}

# If updating containers
# remove the old containers - this brings down the service until ansible is re-applied.
sudo docker rm -f cloudoffice_nextcloud cloudoffice_database cloudoffice_webproxy cloudoffice_onlyoffice

# Re-apply Ansible playbook via systemd service
sudo systemctl start cloudoffice-ansible-state.service

################
## Destroying ##
################

# Before terraform destroy, delete all objects from buckets using the aws CLI - this action is irreversible.
# Install awscli via pip3
sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt-get -q -y install python3-pip
pip3 install --upgrade pip
pip3 install --user --upgrade awscli

# Set credentials
aws configure set aws_access_key_id ${var.do_storageaccessid}
aws configure set aws_secret_access_key ${var.do_storagesecretkey}

# Remove objects
aws s3 rm --recursive s3://${var.nc_prefix}-bucket-${random_string.nc-random.result}/ --endpoint https://${var.do_region}.digitaloceanspaces.com
aws s3 rm --recursive s3://${var.nc_prefix}-bucket-data-${random_string.nc-random.result}/ --endpoint https://${var.do_region}.digitaloceanspaces.com
OUTPUT
}
