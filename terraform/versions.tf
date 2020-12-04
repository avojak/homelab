terraform {
    required_version = ">= 0.13"
    required_providers {
        esxi = {
            source = "registry.terraform.io/josenk/esxi"
        }
        template = {
            source = "registry.terraform.io/hashicorp/template"
        }
    }
}