variable "kubeconfig_path" {
  description = "Path del kubeconfig k3s (default: KUBE_CONFIG_PATH o ~/.kube/config)"
  type        = string
  default     = "~/.kube/config"
}

variable "kube_context" {
  description = "Context kubeconfig"
  type        = string
  default     = "default"
}

variable "op_service_account_token" {
  description = "Token del 1Password Service Account usato da ESO (NON committare)"
  type        = string
  sensitive   = true
}

# Solo se si abilita la cifratura dello state.
variable "state_passphrase" {
  description = "Passphrase per cifratura state (NON committare)"
  type        = string
  sensitive   = true
  default     = null
}
