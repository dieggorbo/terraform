#terraform {
#  backend "s3" {
#    bucket = ""
#    key    = ""
#    region = ""
#  }
#}

terraform {
  backend "local" {
    path = "/tmp/terraform.tfstate"
  }
}
