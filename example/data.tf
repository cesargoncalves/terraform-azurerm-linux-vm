data "template_cloudinit_config" "custom_data" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = <<-EOT
#!/bin/bash
echo "hello world" > /tmp/temp.txt
apt -y update && apt -y full-upgrade && apt -y autoremove && reboot
EOT
  }
}

data "template_file" "init" {
  template = file("files/cloudinit.sh")
}
