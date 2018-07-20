variable "db_uname" {
  description = "Database user name"
  default = "default"
}

variable "db_pwd" {
  description = "Database password"
  default = "default"
}

output "DB Uname" {
  value = "${var.db_uname}"
}

output "DB Password" {
  sensitive = true
  value = "${var.db_pwd}"
}
