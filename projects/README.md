# projects

Nuovi progetti k3s. **Una cartella = un progetto.**

```bash
cp -r templates/project projects/<nome>
git add projects/<nome> && git commit -m "add project <nome>" && git push
```

L'ApplicationSet rileva la cartella e crea l'Application.

Primo progetto previsto: `wiki/` (mortewiki, oggi in ns `wiki` con `deploy/*.yaml`).
