cask "sonarr" do
  arch arm: "arm64", intel: "x64"

  version "4.0.17.2952"
  sha256 arm:   "889108ed099e8f537c7386b75f556dfc927c34f8ff1d2198f07c9bb542560f82",
         intel: "24bde8272ded1bef0163ad42ca841f378a9d1a2c9d626cab747cf1249f364eeb"

  url "https://github.com/Sonarr/Sonarr/releases/download/v#{version}/Sonarr.main.#{version}.osx-#{arch}-app.zip",
      verified: "github.com/Sonarr/Sonarr/"
  name "Sonarr"
  desc "PVR for Usenet and BitTorrent users"
  homepage "https://sonarr.tv/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Sonarr updates itself via its built-in updater; Homebrew only installs it.
  auto_updates true
  depends_on macos: :big_sur

  app "Sonarr.app"

  zap trash: "~/.config/Sonarr"
end
