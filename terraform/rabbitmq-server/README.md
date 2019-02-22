
## Create

```bash
$ export AWS_PROFILE=<YOUR PROFILE NAME GOES HERE> 
```

### Init

```bash

$ terraform init

$ terraform workspace new demo // next time you must use "terraform workspace select demo"
```

### Plan

```bash
$ terraform plan
```

## Describe images

```bash

$ aws ec2 describe-images --image-ids ami-0ff760d16d9497662 // CentOS 7 (x86_64) - with Updates HVM
$ aws ec2 describe-images --image-ids ami-09f0b8b3e41191524 // Ubuntu Server 16.04 LTS (HVM), SSD Volume Type
$ aws ec2 describe-images --image-ids ami-0e12cbde3e77cbb98 // Red Hat Enterprise Linux 7.6 (HVM), SSD Volume Type
$ aws ec2 describe-images --image-ids ami-0fad7378adf284ce0 // Amazon Linux 2 AMI (HVM), SSD Volume Type
{
    "Images": [
        {
            "Architecture": "x86_64",
            "CreationDate": "2019-01-14T19:17:28.000Z",
            "ImageId": "ami-0fad7378adf284ce0",
            "ImageLocation": "amazon/amzn2-ami-hvm-2.0.20190115-x86_64-gp2",
            "ImageType": "machine",
            "Public": true,
            "OwnerId": "137112412989",
            "State": "available",
            "BlockDeviceMappings": [
                {
                    "DeviceName": "/dev/xvda",
                    "Ebs": {
                        "DeleteOnTermination": true,
                        "SnapshotId": "snap-01f52bce2fae5bea9",
                        "VolumeSize": 8,
                        "VolumeType": "gp2",
                        "Encrypted": false
                    }
                }
            ],
            "Description": "Amazon Linux 2 AMI 2.0.20190115 x86_64 HVM gp2",
            "EnaSupport": true,
            "Hypervisor": "xen",
            "ImageOwnerAlias": "amazon",
            "Name": "amzn2-ami-hvm-2.0.20190115-x86_64-gp2",
            "RootDeviceName": "/dev/xvda",
            "RootDeviceType": "ebs",
            "SriovNetSupport": "simple",
            "VirtualizationType": "hvm"
        }
    ]
}

```