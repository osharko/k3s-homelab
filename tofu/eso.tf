# Bootstrap ESO: namespace + token del Service Account 1Password.
# L'installazione dell'operatore ESO può avvenire via ArgoCD (infrastructure/external-secrets).

resource "kubernetes_namespace_v1" "external_secrets" {
  metadata {
    name = "external-secrets"
  }
}

resource "kubernetes_secret_v1" "op_service_account" {
  metadata {
    name      = "op-service-account"
    namespace = kubernetes_namespace_v1.external_secrets.metadata[0].name
  }

  data = {
    token = var.op_service_account_token
  }

  type = "Opaque"
}
