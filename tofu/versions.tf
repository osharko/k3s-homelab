terraform {
  required_version = ">= 1.8"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }
    # Opzionale: gestione item 1Password come codice.
    # onepassword = {
    #   source  = "1Password/onepassword"
    #   version = "~> 2.1"
    # }
  }

  # Cifratura dello state (OpenTofu >= 1.7). Chiave age tenuta FUORI repo (es. 1Password).
  # Decommentare dopo aver generato la chiave e definito il metodo.
  #
  # encryption {
  #   method "aes_gcm" "default" {
  #     keys = key_provider.pbkdf2.default
  #   }
  #   key_provider "pbkdf2" "default" {
  #     passphrase = var.state_passphrase
  #   }
  #   state {
  #     method = method.aes_gcm.default
  #   }
  # }
}

# Il kubeconfig di k3s sta in /etc/rancher/k3s/k3s.yaml (leggibile solo da root).
# Per tofu: copiarlo in un path utente o esportare KUBE_CONFIG_PATH.
provider "kubernetes" {
  config_path    = var.kubeconfig_path
  config_context = var.kube_context
}
