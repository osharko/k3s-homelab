# templates/project — scaffold nuovo progetto k3s

Copia la cartella e rinomina il namespace:

```bash
cp -r templates/project projects/<nome>
# sostituisci "example" con <nome> nei file
git add projects/<nome> && git commit -m "add project <nome>" && git push
```

L'ApplicationSet crea automaticamente l'Application; sincronizzi dalla UI ArgoCD.
