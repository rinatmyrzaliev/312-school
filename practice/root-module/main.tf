module myapp {
  source = "../child-module"
  bucket = "rinat-06092025-terraform"
}

output module_s3_bucket_arn {
  value = module.myapp.s3_bucket_arn
}