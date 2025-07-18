variable "cloud_id" {}
variable "folder_id" {}
variable "zone" {
  default = "ru-central1-a"
}
variable "ssh_key" {
  description = "Содержимое публичного SSH ключа"
}
