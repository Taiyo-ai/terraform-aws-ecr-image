# Checks if build folder has changed
data "external" "build_folder" {
  program = ["${path.module}/bin/folder_contents.sh", var.dockerfile_dir]
}

# Builds test-service and pushes it into aws_ecr_repository
resource "null_resource" "build_and_push" {
  triggers = {
    build_folder_content_md5 = data.external.build_folder.result.md5
  }

  # See build.sh for more details
  # See build.sh for more details
  provisioner "local-exec" {
    command = "${path.module}/bin/build.sh ${var.dockerfile_dir} ${var.ecr_repository_url}/${var.docker_service_name}:${var.docker_image_tag} ${var.aws_region} && ${path.module}/bin/tags.sh -s ${var.docker_service_name} -f ${var.docker_image_tag} -t ${var.docker_image_other_tags}  -a ${var.aws_region}  -r ${var.ecr_repository_url}"
  }
}

