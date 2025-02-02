provider "oci" {
}

variable "oci_config_profile" {
  type        = string
  description = "The oci configuration file, generated by 'oci setup config'"
}

variable "oci_root_compartment" {
  type        = string
  description = "The tenancy OCID a.k.a. root compartment, see README for CLI command to retrieve it."
}

variable "oci_region" {
  type        = string
  description = "Region to deploy services in."
}

variable "oci_imageid" {
  type        = string
  description = "An OCID of an image, the playbook is compatible with Ubuntu 18.04+ minimal"
}

variable "oci_adnumber" {
  type        = number
  description = "The OCI Availability Domain, only certain AD numbers are free-tier, like Ashburn's 2"
}

variable "oci_instance_shape" {
  type        = string
  description = "The size of the compute instance, only certain sizes are free-tier"
}

variable "oci_instance_diskgb" {
  type        = string
  description = "Size of system boot disk, in gb"
}

variable "oci_instance_memgb" {
  type        = string
  description = "Memory GB(s) for instance"
  default     = 1
}

variable "oci_instance_ocpus" {
  type        = string
  description = "Oracle CPUs for instance"
  default     = 1
}

variable "ssh_key" {
  type        = string
  description = "Public SSH key for SSH to compute instance, user is ubuntu"
}

variable "vcn_cidr" {
  type        = string
  description = "Subnet (in CIDR notation) for the OCI network, change if would overlap existing resources"
}

variable "mgmt_cidr" {
  type        = string
  description = "Subnet (in CIDR notation) granted access to Pihole WebUI and SSH running on the compute instance. Also granted DNS access if dns_novpn = 1"
}

variable "nc_prefix" {
  type        = string
  description = "A friendly prefix (like 'pihole') affixed to many resources, like the bucket name."
}

variable "admin_password" {
  type        = string
  description = "Password for WebUI access"
}

variable "db_password" {
  type        = string
  description = "Nextcloud application db password"
}

variable "oo_password" {
  type        = string
  description = "Nextcloud application onlyoffice password"
}

variable "project_url" {
  type        = string
  description = "URL of the git project"
}

variable "docker_network" {
  type        = string
  description = "docker network ip"
}

variable "docker_gw" {
  type        = string
  description = "docker network gateway ip"
}

variable "docker_nextcloud" {
  type        = string
  description = "nextcloud app container ip"
}

variable "docker_webproxy" {
  type        = string
  description = "https web proxy container ip"
}

variable "docker_db" {
  type        = string
  description = "db container ip"
}

variable "docker_onlyoffice" {
  type        = string
  description = "onlyoffice container"
}

variable "docker_duckdnsupdater" {
  type        = string
  description = "duckdns dynamic dns update container ip"
}

variable "project_directory" {
  type        = string
  description = "Location to install/run project"
  default     = "/opt"
}

variable "web_port" {
  type        = string
  description = "Port to run web proxy"
  default     = "443"
}

variable "oo_port" {
  type        = string
  description = "Port to run onlyoffice"
  default     = "8443"
}

variable "enable_duckdns" {
  type = number
}

variable "duckdns_domain" {
  type = string
}

variable "duckdns_token" {
  type = string
}

variable "letsencrypt_email" {
  type = string
}
