variable cloud_id {
  description = "Cloud id"
}

variable folder_id {
  description = "Folder id"
}

variable zone {
  description = "Zone"
  default     = "ru-central1-a"
}

variable subnet_id {
  description = "Subnet"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable service_account_key_file {
  description = "key .json"
}

variable docker_disk_image {
  description = "Disk image for docker host"
}

variable instance_count {
  description = "How many inctances should be created"
  type        = number
  default     = 1
}
