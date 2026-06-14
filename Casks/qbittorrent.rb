cask "qbittorrent" do
  version "5.0.5"
  sha256 "7285e98b5ef4b9a227247dcd933f1a556bfc1ff10901fc7aedb0c4b7ad082814"

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
