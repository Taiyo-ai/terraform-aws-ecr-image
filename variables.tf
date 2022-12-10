variable "dockerfile_dir" {
  type = string
  description = "The directory that contains the Dockerfile"
}

variable "ecr_repository_url" {
  type        = string
  description = "Full url for the ECR repository"
}

variable "docker_image_tag" {
  type        = string
  description = "This is the tag which will be used for the image that you created"
  default     = "latest"
}

variable "pip_auth_link" {
  type        = string
  description = "This is the pip auth link for pip3 config set global.index-url $PIP_AUTH_LINK which will be used for the image that you created"
  default     = "latest"
}
