terraform {
  backend "local" {
    path = "prod/terraform-prod.tfstate"
  }
}