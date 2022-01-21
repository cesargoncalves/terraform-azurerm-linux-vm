data "template_file" "init" {
  template = file("files/cloudinit.sh")
}
