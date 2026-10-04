# Inventory — homelab k3s

> Ricognizione 2026-10-04. I doc in `/mnt/tank/containers/.planning` erano stale (5 nodi, master `nas-control`
> a `10.10.0.200`): qui c'è lo stato **reale**.

## Host `nas`

- Proxmox VE 9.2.2 su Debian 13 (trixie), kernel `7.0.2-6-pve`
- 16 core, 93.7 GB RAM
- Bridge: `vmbr0` LAN `192.168.188.200/24` · `vmbr1` cluster `10.10.0.1/24`
- ZFS: `tank` 5.45T (raidz1 di **3× SSD SATA 2TB**, `/mnt/tank`), `Love_n_Family` 72.8T
  (raidz2 di **5× HDD Seagate 16TB**, `/mnt/Love_n_Family`), `morente` 238G (NVMe Patriot in via di guasto, scratch)

## Cluster k3s

- v1.35.5+k3s1 · control-plane **sull'host** · API `127.0.0.1:6443` / `10.10.0.1:6443`
- kubeconfig: `/etc/rancher/k3s/k3s.yaml`
- Template LXC: **9000** (`template-k3s-agent`) · rootfs LXC su `local-lvm` (non ZFS)
- Join URL reale: `https://10.10.0.1:6443`

| nodo | ruolo | IP | LXC | ns/tier | bind mount |
|---|---|---|---|---|---|
| nas | control-plane | 192.168.188.200 | (host) | infra, kube-system | FS host |
| media | agent | 10.10.0.201 | 201 | media | /dev/dri, tank/containers, Love_n_Family |
| download | agent | 10.10.0.202 | 202 | download | tank/containers, Love_n_Family |
| cloud | agent | 10.10.0.203 | 203 | cloud | tank/containers, Love_n_Family, tank/git |
| db | agent | 10.10.0.204 | 204 | data | tank/containers |
| wiki | agent | 10.10.0.205 | 205 | wiki | nessuno (PVC local-path) |

## Storage / path reali (hostPath nei manifest)

| path host | contenuto |
|---|---|
| `/mnt/tank/containers/<svc>` | config per-servizio (28 GB totali) |
| `/mnt/tank/git` | repo Gitea (solo nodo `cloud`) |
| `/mnt/Love_n_Family/Mediaserver/{HD,4K}/<cat>` | librerie media (Anime, Anime Series, Cartoon, Cartoon Series, Film, Tv Series) |
| `/mnt/Love_n_Family/Mediaserver/Download/{HD,4K}/{radarr,sonarr}` | hardlink target *arr |
| `/mnt/Love_n_Family/Drive/{Photos,Videos,Documents,_immich}` | dati cloud (Immich/Nextcloud) |
| `/mnt/Love_n_Family/Multimedia/Mediaserver/Manga` | legacy Komga |
| `/mnt/morente` | scratch (disco in via di guasto) |

## Workload (ns)

`infra` (traefik, pihole, cloudflared, headscale, homepage, tailscale-router) ·
`media` (jellyfin) · `download` (sonarr/radarr ±4k, prowlarr, bazarr, lidarr, readarr, jellyseerr, pinchflat, flaresolverr, qbittorrent) ·
`cloud` (immich, nextcloud, komga, suwayomi, gitea) · `data` (postgres) · `wiki` (mortewiki) · `kube-system`.

## Secret

- `/mnt/tank/containers/.env` (23 chiavi) · `/mnt/tank/containers/postgres/.env` (6 chiavi)
- k3s: `db-credentials`, `postgres-creds`, `pihole-admin`, `immich-db`, `wiki-gitkey`, `node-password.*`
- `sync-secrets.sh` sincronizza dai `.env` → **da dismettere** in favore di ESO + 1Password.

## Known unknowns

- [ ] disco FAULTED di `Love_n_Family` (serial/WWN, piano sostituzione)
- [ ] `readarr` ImagePullBackOff
- [ ] nodo `wiki` senza label `tier`
- [ ] `clone-k3s` punta a `10.10.0.200` (inesistente) → allineare a `10.10.0.1`
