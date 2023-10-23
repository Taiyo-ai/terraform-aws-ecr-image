variable "dockerfile_folder" {
  type        = string
  description = "This is the folder which contains the Dockerfile"
}

variable "aws_region" {
  type        = string
  description = "AWS region for ECR"
  default     = ""
}

variable "ecr_repository_url" {
  type        = string
  description = "Base url for the ecr repository"
}

variable "docker_service_name" {
  type        = string
  description = "Name of service"
}

variable "docker_image_tag" {
  type        = string
  description = "This is the tag which will be used for the image that you created"
  default     = "latest"
}

variable "docker_image_other_tags" {
  type        = string
  description = "comma separated list of tags"
}
