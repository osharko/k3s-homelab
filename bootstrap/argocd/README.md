# ArgoCD install

Metodo consigliato: manifest ufficiale `stable` (oppure Helm, se si preferisce gestire i valori).

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Poi:

1. `bootstrap/argocd/ingressroute.yaml` → espone `argocd.osharko.lan` (Traefik).
2. DNS: aggiungere `argocd.osharko.lan` a `pihole.toml [dns] hosts` → `10.10.0.200` + restart pod pihole.
3. Password admin: `kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d`
   (da cambiare e salvare in 1Password).
4. **Repo pubblico** → nessuna credenziale richiesta per il clone HTTPS.

> TODO: pinnare la versione di ArgoCD invece di `stable` quando il setup è stabile.
