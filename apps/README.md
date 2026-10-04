# apps

Servizi applicativi, per namespace/tier.

- `media/` — jellyfin
- `download/` — sonarr, sonarr4k, radarr, radarr4k, prowlarr, bazarr, lidarr, readarr, jellyseerr, pinchflat, flaresolverr, qbittorrent
- `cloud/` — immich, nextcloud, komga, suwayomi, gitea

Convenzione: una cartella per servizio con un `kustomization.yaml`.
Si migrano dagli attuali `<svc>/manifest.yaml` in `/mnt/tank/containers/`.
