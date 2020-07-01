resource "aws_s3_bucket" "s3bucket" {
  bucket = var.bucket_name
  region = "var.region"
}

resource "aws_s3_bucket_policy" "bucketpolicy" {
  bucket = "${aws_s3_bucket.s3bucket.bucket}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "SSMBucketPermissionsCheck",
            "Effect": "Allow",
            "Principal": {
                "Service": "ssm.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::${var.bucket_name}"
        },
        {
            "Sid": " SSMBucketDelivery",
            "Effect": "Allow",
            "Principal": {
                "Service": "ssm.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": ["arn:aws:s3:::${var.bucket_name}/*"],
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
EOF
}

resource "aws_ssm_resource_data_sync" "sync" {
  name = "resources"

  s3_destination {
    bucket_name = "${var.bucket_name}"
    region      = "${var.region}"
  }
}
