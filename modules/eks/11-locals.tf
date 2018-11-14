# locals

locals {
  full_name  = "${var.city}-${var.stage}-${var.name}"
  lower_name = "${lower(local.full_name)}"
}
