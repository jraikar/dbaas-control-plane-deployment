terraform {
    backend "s3" {
        bucket = "terraformstatebucket5673"
        key = "terraformstatebucket"
        region = "us-east-1"
    }
}
