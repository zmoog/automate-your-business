// https://www.terraform.io/docs/providers/aws/index.html
// https://github.com/terraform-providers

provider "aws" {
  version = "1.59"
  region  = "eu-west-1"
}


//
// Route 53 — https://aws.amazon.com/route53/
//

// https://www.terraform.io/docs/providers/aws/d/route53_zone.html
data "aws_route53_zone" "selected" {
  name         = "weirdco.de."
  private_zone = false
}

// https://www.terraform.io/docs/providers/aws/r/route53_record.html
resource "aws_route53_record" "example" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "automate-your-business.weirdco.de"
  type    = "A"
  ttl     = "300"
  records = ["1.1.1.1"]
}
