cask "qbittorrent" do
  version "5.2.2"
  sha256 "4d6eec9ffd932cd64d35d3fa3df85932bf397457461a69cebcde6d5b737ae5e4"

  url "https://downloads.sourceforge.net/qbittorrent/qbittorrent-mac/qbittorrent-#{version}/qbittorrent-#{version}.dmg",
      verified: "downloads.sourceforge.net/qbittorrent/qbittorrent-mac/"
  name "qBittorrent"
  desc "Peer to peer BitTorrent client"
  homepage "https://www.qbittorrent.org/"

  # qBittorrent has no built-in updater, so Homebrew is the update mechanism.
  # The GitHub Actions workflow bumps version+sha256 from this SourceForge feed.
  livecheck do
    url "https://sourceforge.net/projects/qbittorrent/rss?path=/qbittorrent-mac"
    regex(%r{url=.*?/qbittorrent[._-]v?(\d+(?:\.\d+)+)\.dmg}i)
  end

  depends_on macos: :ventura

  # The .app is lower-case in the DMG; rename to match the Finder name.
  app "qbittorrent.app", target: "qBittorrent.app"

  zap trash: [
    "~/.config/qBittorrent",
    "~/Library/Application Support/qBittorrent",
    "~/Library/Caches/qBittorrent",
    "~/Library/Preferences/org.qbittorrent.qBittorrent.plist",
    "~/Library/Saved Application State/org.qbittorrent.qBittorrent.savedState",
  ]
end
