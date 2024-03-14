provider "aws" {
  region = "eu-central-1"
  # Will use creds from this -> aws configure --profile miranda_devsecops
  profile = "miranda_devsecops"
}