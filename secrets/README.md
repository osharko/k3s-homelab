# Secrets — config in git, valori in 1Password

Questa cartella contiene **solo config non sensibile**:

- `store/<provider>/` — il `ClusterSecretStore` (provider-specifico). Oggi: `1password`.
- `base/<namespace>/` — le `ExternalSecret` (provider-agnostiche): mappano item/key 1Password → chiavi di un Secret k8s.

**Mai in git**: token Service Account 1P, `.env`, state OpenTofu, `*.tfvars`.

## Flusso

1. Il valore segreto sta in **1Password** (vault `Homelab`, item per servizio).
2. Una `ExternalSecret` in `base/<ns>/` lo referenzia.
3. ESO lo sincronizza in un Secret k8s nel namespace.
4. Il pod lo consuma via `secretKeyRef` (nessun valore nei manifest).

## Cambiare vault manager

Le `ExternalSecret` restano invariate. Si sostituisce solo `store/<provider>/` e, se serve,
l'install dell'operatore. Provider previsti da ESO: 1Password, Vault, AWS/GCP/Azure SM, Bitwarden, Infisical…
