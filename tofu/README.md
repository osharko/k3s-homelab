# OpenTofu — plumbing secret

Scope attuale: **bootstrap del token ESO** e (opzionale) gestione degli item 1Password.
L'infra Proxmox (VM/LXC/ZFS) è una fase successiva, fuori da questa cartella.

## Cosa fa

- crea il namespace `external-secrets`
- crea il Secret `op-service-account` (token del Service Account 1P) **da var fuori repo**
- (opzionale) `1password/onepassword`: dichiara vault/item/field in 1Password

## Regole

- **Mai** committare `*.tfvars`, state, `.terraform/`.
- Lo **state contiene valori in chiaro**: usare cifratura state (vedi `versions.tf`) o backend locale protetto.
- I valori arrivano da `terraform.tfvars` (gitignored) o da variabili d'ambiente `TF_VAR_*`.

## Uso

```bash
cd tofu
cp terraform.tfvars.example terraform.tfvars   # riempi (gitignored)
tofu init
tofu plan
tofu apply
```
