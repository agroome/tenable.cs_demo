resource "aws_s3_bucket" "tenable_cs_demo_s3_bucket" {
  bucket = "tenablecsdemos3bucket"
  acl    = "public-read"
  tags   = var.default_tags
}
resource "aws_s3_bucket_policy" "tenable_cs_demo_s3_bucketPolicy" {
  bucket = "${aws_s3_bucket.tenable_cs_demo_s3_bucket.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "tenable_cs_demo_s3_bucket-restrict-access-to-users-or-roles",
      "Effect": "Allow",
      "Principal": [
        {
          "AWS": [
            <aws_policy_role_arn>
          ]
        }
      ],
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.tenable_cs_demo_s3_bucket.id}/*"
    }
  ]
}
POLICY
}