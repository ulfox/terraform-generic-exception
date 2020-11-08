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

variable "multi_condition" {
  type        = list(list(string))
  default     = null
  description = "Multi condition"
}

variable "multi_shell_condition" {
  type        = list(string)
  default     = null
  description = "Shell multi condition"
}

variable "message" {
  type        = string
  default     = null
  description = "The exit message"
}
