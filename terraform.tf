resource "aws_launch_template" "this" {
  count                  = var.enable ? 1 : 0
  name                   = local.name
  update_default_version = true
  image_id               = var.ami
  instance_type          = var.instance_type
  iam_instance_profile {
    name = aws_iam_instance_profile.this[0].name
  }
  vpc_security_group_ids = [
    aws_security_group.this[0].id,
  ]
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      encrypted             = "true"
      volume_size           = try(var.volume.size, null)
      volume_type           = try(var.volume.type, null)
      iops                  = try(var.volume.iops, null)
      delete_on_termination = try(var.volume.delete_on_termination, false)
    }
  }
}
