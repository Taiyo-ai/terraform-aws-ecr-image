variable "dockerfile_dir" {
  type        = string
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

variable "src_copy_dir" {
  type        = string
  description = "This is the source package directory which will be used for the image that you created"
}
variable "domain_name" {
  type        = string
  description = "This is the pip auth domain which will be used for the image that you created"
  default     = "connect-taiyo-ai"
}
variable "owner_account" {
  type        = string
  description = "This is the pip auth account which will be used for the image that you created"
  default     = "965994533236"
}
variable "region" {
  type        = string
  description = "This is the pip auth region which will be used for the image that you created"
  default     = "eu-west-3"
}
