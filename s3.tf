resource "aws_s3_bucket" "s3_terraform" {
  bucket = local.s3_sufix

  #   tags = {
  #     Name = "My bucket-${local.s3_sufix}"
  #   }
}
