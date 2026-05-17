terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  # No real credentials needed — we won't apply, just plan
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t4g.xlarge"

  tags = {
    Name        = "demo-web-server"
    Environment = "Stage"
    Service     = "web"
  }
}

resource "aws_db_instance" "postgres" {
  engine         = "postgres"
  instance_class = "db.r7i.2xlarge"
  allocated_storage = 100
  db_name        = "appdb"
  username       = "admin"
  password       = "notreal123"
  skip_final_snapshot = true

  tags = {
    Name        = "demo-postgres"
    Environment = "Stage"
    Service     = "database"
  }
}
