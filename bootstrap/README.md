# Bootstrap

Passi manuali una-tantum per portare il cluster in GitOps.

1. **ArgoCD** — `bootstrap/argocd/` (namespace, install, IngressRoute `argocd.osharko.lan`).
2. **Root app** — `kubectl apply -f bootstrap/root-app.yaml`.
3. Da lì in poi ArgoCD gestisce il resto (`clusters/homelab` → ApplicationSet → `apps/*`, `projects/*`).

> I secret arrivano in un secondo momento (Fase 2, ESO + 1Password). Finché non è pronta,
> le app che richiedono secret restano con `syncPolicy` manuale.
