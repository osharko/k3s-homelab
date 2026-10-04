# Architettura

## GitOps

```
GitHub (questo repo, pubblico)
   │  watch
ArgoCD (ns argocd)
   ├─ root app (bootstrap/root-app.yaml)
   └─ ApplicationSet (clusters/homelab/apps.yaml)
        ├─ apps/*        → servizi esistenti
        └─ projects/*    → nuovi progetti k3s
```

- **App-of-apps**: una root Application punta a `clusters/homelab`.
- **ApplicationSet** con *git directory generator*: aggiungere una cartella = aggiungere un'app.
- Adozione **incrementale**: `syncPolicy` manuale + `prune: false` finché un'app non è allineata.

## Secret

```
1Password (valori)
   ▲ read
External Secrets Operator + ClusterSecretStore ──► k8s Secret ──► pod
   ▲ ExternalSecret (config in git)
OpenTofu ── bootstrap token ESO (+ opz. item 1P)
```

- In git: `ExternalSecret` (mapping item→key), `ClusterSecretStore`, install ESO.
- Mai in git: token Service Account 1P, `.env`, state OpenTofu, `*.tfvars`.
- **Provider-agnostico**: le `ExternalSecret` non citano il vault manager; solo `secrets/store/<provider>/` cambia.

## Tool (decisioni)

- **ArgoCD** scelto per il requisito "visuale" (UI, diff, sync, history). Ribalta l'ADR "NO ArgoCD" di `restructure.md`.
- **Flux** alternativa (SOPS nativo) scartata per assenza di UI nativa.
- **OpenTofu**: solo plumbing secret ora; infra Proxmox (VM/LXC/ZFS) in fase successiva.
