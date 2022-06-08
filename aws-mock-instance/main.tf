provider "aws" {
  secret_key = "aws-mock-secertkey-prelude-1a12046d-3d1b-4596-8bd9-0e3a76397c54"
  access_key = "aws-mock-accessid-prelude-1a12046d-3d1b-4596-8bd9-0e3a76397c54"
  region = "us-east-1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_force_path_style         = true
  insecure = true
  skip_region_validation = true
  skip_get_ec2_platforms = true
  endpoints {
    ec2 = "http://ad3554453643e4883a0734ef30ece6ce-532856250.us-west-2.elb.amazonaws.com/aws-mock/ec2-endpoint/"
  }
}
resource "aws_instance" "machine1" {
  ami = "ami-04b9e92b5572fa0d1"
  instance_type = "t2.micro"
}
