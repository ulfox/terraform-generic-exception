// ------------------------------------------------------------
// Exception Variables
// ------------------------------------------------------------
variable "exit_code" {
  type        = string
  default     = null
  description = "The exit code"
}

variable "condition" {
  type        = list(string)
  default     = null
  description = "The condition"
}

variable "shell_condition" {
  type        = string
  default     = null
  description = "The shell condition"
}

variable "message" {
  type        = string
  default     = null
  description = "The exit message"
}
