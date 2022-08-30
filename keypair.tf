resource "aws_key_pair" "nidio-terraform-aws-key" {
  key_name = "nidio-terraform-aws"
  public_key = file("terraform-aws.pub")
}