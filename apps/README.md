# apps

Servizi applicativi — **una cartella per servizio** (flat, `apps/<svc>/`), così il git
directory generator (`apps/*`) crea una Application per ciascuno.

Migrazione dagli attuali `<svc>/manifest.yaml` in `/mnt/tank/containers/`.

Servizi da migrare (namespace → cartella):

- `apps/jellyfin/` (ns media)
- `apps/sonarr/`, `apps/sonarr4k/`, `apps/radarr/`, `apps/radarr4k/`, `apps/prowlarr/`,
  `apps/bazarr/`, `apps/lidarr/`, `apps/readarr/`, `apps/jellyseerr/`, `apps/pinchflat/`,
  `apps/flaresolverr/`, `apps/qbittorrent/` (ns download)
- `apps/immich/`, `apps/nextcloud/`, `apps/komga/`, `apps/suwayomi/`, `apps/gitea/` (ns cloud)

Ogni cartella: `kustomization.yaml` (+ `namespace.yaml` se serve) e i manifest del servizio.
