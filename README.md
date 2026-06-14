# Homebrew Tools

Personal Homebrew tap.

## Installation

```bash
brew tap mhriemers/tools
```

## Casks

Media-server apps. Kept current by a daily GitHub Actions workflow
(`.github/workflows/update-casks.yml`), since their official Homebrew casks
are deprecated (they fail the macOS Gatekeeper check).

| Cask | Description |
|------|-------------|
| **qbittorrent** | Peer-to-peer BitTorrent client |
| **sonarr** | PVR for Usenet and BitTorrent users |
| **radarr** | Movie collection manager for Usenet and BitTorrent users |
| **tautulli** | Monitoring and tracking tool for Plex Media Server |

## Formulae

| Formula | Description |
|---------|-------------|
| **overseerr** | Request management and media discovery tool for the Plex ecosystem |

## Usage

```bash
brew install --cask mhriemers/tools/<cask>      # e.g. qbittorrent
brew install mhriemers/tools/<formula>          # e.g. overseerr
brew services start mhriemers/tools/overseerr   # run a formula as a service
```
