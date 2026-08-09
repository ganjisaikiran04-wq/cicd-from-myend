terraform {
  backend "s3" {
    bucket       = "bucketforpractice4477"
    key          = "dev/terraform.tfstate"
    region       = "ap-southeast-1"
    encrypt      = true
    use_lockfile = true
  }
}
