provider "aws" {
  region = "us-west-2"
}

module "dcos" {
  source  = "dcos-terraform/dcos/aws"
#  version = "~> 0.1"
#  availability_zones = ["us-west-2a","us-west-2b","us-west-2c"]
  availability_zones = ["us-west-2a"]
  cluster_name       = "mjohnsonsbctest1"
  num_masters        = "3"
  num_private_agents = "8"
  num_public_agents  = "1"
  bootstrap_instance_type = "t2.medium"
  public_agents_instance_type = "c4.xlarge"
  private_agents_instance_type = "c4.4xlarge"
  masters_instance_type = "m4.xlarge"
  dcos_version = "1.12.0"
  dcos_instance_os    = "centos_7.5"

#  dcos_variant = "open"
  dcos_variant              = "ee"
  dcos_license_key_contents = "${file("./license.txt")}"
#  dcos_license_key_contents="LS0tLS1CRUdJTiBNRVNPU1BIRVJFIExJQ0VOU0UgS0VZLS0tLS0KSUQ6IG1lc29zcGhlcmUtZGV2ZWxvcGVyMgoKMXdqL1pjaVBEQzJkQkU4Z09YZ3BRWHNGS2JTaEQyL0tQSWhwcUpHR0dXWG1CQ0FURnl1K1NoaCtUb2ZpOElvUgplVi9nZVRpNHV3Qjllc09lWlJSbmU3TDVneTE5MHZtZUlYQVVpa1kwQzhCd1EyVnhuUkpaaEMxemFXaS8rakh3CjcxRjZpWlEvaEd1enVMR2JsSzBTbktQeHV2cVhybUV4N2VFcmh2Z0FCRUhUZkZnL1lTRU5Db2N3WXk4MzVwNDAKdjdOSG8zTXc4clZ2cE9idFg4WXRYYTF0ZmJaaDhYUU1BblI1R3BXWDdDQk5EQXNKQmVkVlFpaTZtZ08vT2E2ZApCZzlXcS8vSys3RnE3Qlo5eWVDUm9kMExuVVBRNGpGM1RSb0VWd0tYQTFzd2MwQldMV2NDcVFIUHlPUTZ5czBKCjdBYTFJTE5OMXpxTjl6dHZkQTFTY1Z1R3E4ajhjZXlDckkxbjU3cHU3T2p3eUV4UjZyZ29PZE1xWUlCTmludjkKOHdNc3dqOVZZT3hab2dkM1JUajg1NGt0YjR1bkE5S1dFRUsybDlmdWMyV2VPU0dNcDNrSnRNQ3owVWVQK0hxMgorRFloOXM3eldWcis0dHFpWjRnODdxc2NjWkcxVmkrYU9kSVIyNng2aE9BeCtWbkRVM05qR1IyNnhrMlBQcm42ClJzQ2NPSkVHQjAwcWlxa2tKWTh0UFhnY3VlRmVsVXJyVkRDQmk2T1NGZTVLQ0pFbzlXdUI1ZTdMcFZqV0xsbjQKcEJWM1lyMG0xMGxJYlVlak1qTC8veXhnemcrOWsxaEswSHNLa09BSEcxcmtFNzhPaDhoTklTYmFDRHZ4Y3drUApZUDFuZktsNGRvMXFDeEVxWUFmK0laWVoyQmErYjV4clhRWXhwY1ZGS0l5QWtZZjRnQit4OTlxL09mWGNtVDgwCmZWeEFrQUdNTHJ5UHh6SEZzVk5nRWV0d1ZSNFcvODRhbjgzdlZCUHgvcEtOczhxWnJCZzl5YkR6OGdSdjYzbnAKRXQyYWlZK1AzVkhqSUwvWE5wVUFyUDIwNGxRdTc3RTBsRE1SY3N3RHNHNkd6SFlhTXF5NkhxK21lVHFTc2VPNApYTnNKV0x3UTQ2aU0rOGlHM0RNemczaThkSlVWZTVnOGZhTDh6V25ucTUwNjBNdmtSUWdjcmxNaE53S2FLZzdECllVMWhhRHE3SFF2elhmNGtQaGQyM1lrRDByRzhsV1VmNm1HRFlHdi9FRlhVYUErcWZMWEp2MEREOVc1QlBjRkUKTnBwczZMQSsvOUNzV2lncUpzNWFYL1pJRk1URE5NdXRuSm5JWWlKN21TRjQwck9SWmZoZlNzVUhHQ1E5R0NPRgpPR2JMT2tpeHF2bEY0ZUkwU3VnaW95MFhseEE4YzhqM2ZGZlRoVnBNdWtpYU4wZGNrK3NiczBtTWZpTnRnS3crCm9heTdjdmx5MWlEa2ZXQUMrSUdMeXJJL1ExOWNxdEZITXpGSUw1TFI3N3JkSmxDMkxLdWxYSXltdXp5bmhxSVkKQ2xyT3ZpQnFhNFV1Z2Mwcm56dklna0JlKzVTME5VeUk3aFo3TWlOYzhTL0k4QzNOMUxQMExibjdOK0lQWTlZVwpiaGZVR1llaFlwbG5aYU5LVDRSakVoVG9SOU1nQ0ZCSUZDSjZFbmg0L2dEOE1UeU5LbTdGU1lZY0ROYjVCVHNnCkVFOTlvbEpOZHFZYnkyeTJiMkhIbXV0NEdqRFZlSWJrTisvNTVDS2pFMEN6aVg4WHZEanJmZ3JndXpUN3NTNkQKT0JRTTlZYW1uSXhJMWZiTTFpQ01lVVBKVHdXVnFPNGM3c1ZOMmJkWWJpcW5HdFBIRnpPTmkzU2VObnFLMktvYQpkbElkZ0t0bVlJbC9lbld5U3dJelc3NzkvK0V4VmlvY0FYZDBTTWdKYmRTUGhkZVQrL0s3TGxiVEhGSjdFdVdzCld3VHJ2Ti9VR3RFdEdCbkZhbXZWNDhueWxsY0pzTVhmZnRDTGpMcmNLSDA4SmNZYnRhTHQvNE5XdENTeEg2TzQKWTlDVm9Ec01EY3U2cmVEdmg5VW82ejBWam1kcjZzdk43QlBLcGszRlJDYnpyTUwwWEt6UjlCMXZ6OHl4SjMxSwpNZ3hpSXBiamJIckhUbklQcmEzZ1d5Q0Q2K1NtTkNzMDdFVU9WMEJRMHdnYTVSQzVqdm0rbUJ3VlBjbmhGN0p6CmJNWjBEZWlRcTNaL2NjSlN5NkhoVFlqN0JtU1Y0VHhvb0RIMXg0ZHI1Q1ZUUHJPL1A1cGdYZ3hZdHh1ZU5CZmgKTFQvVXRkVklSdG9yaUZ2eFp6NFVBVkNQbmVrZWxjYjlPdTJ5MUYrTDhjN2puN0xDM0cvOUN2ZGdrQ2R1WFV4RQpJUGtaSFd3MWlEazM1ZFZmclVUZk1hOWM4d3FKTlYxSUdXVkIvNEpZaTQzWWYrK0s0MTZ1WVZidHMvRlZhNmNsCktmOENqSXFHK0cySFhjV2FEbHRsTmlKTE01TzI4VVpUdGJHRlF2dFhiV1Z6YjNOd2FHVnlaUzFrWlhabGJHOXcKWlhJeUN5bHVmR29QcWRKZ2FNbzlGdDBiZFVWNUR5NVdDYkNzR285NVBvZTExUzI5OVA3UlAzdngxVlZmMHZySgpOK3BIS0RPV1JuZUpqMW1ERTYwLzNKSVhiNVBOZVdkOG9BN3FqcERYakZ1VXA3VU1xZ0l6MjVvaGloMDRvZkxJCklYWUZUVHU5OUZSemhlWUo1UlJLRDgzRGsvSFdGcFR5cVRiQmMvN2JFK0M2S2JvPQotLS0tLUVORCBNRVNPU1BIRVJFIExJQ0VOU0UgS0VZLS0tLS0K"
  admin_ips=["0.0.0.0/0"]
  ssh_public_key_file = "~/.ssh/id_rsa.pub"
#  admin_ips           = ["${data.http.whatismyip.body}/32"]
   dcos_resolvers      = "\n   - 169.254.169.253"

  dcos_install_mode = "${var.dcos_install_mode}"

  providers = {
    aws = "aws"
  }
}



variable "dcos_install_mode" {
  description = "specifies which type of command to execute. Options: install or upgrade"
  default     = "install"
}

data "http" "whatismyip" {
  url = "http://whatismyip.akamai.com/"
}

output "masters-ips" {
  value = "${module.dcos.masters-ips}"
}

output "cluster-address" {
  value = "${module.dcos.masters-loadbalancer}"
}

output "public-agents-loadbalancer" {
  value = "${module.dcos.public-agents-loadbalancer}"
}
