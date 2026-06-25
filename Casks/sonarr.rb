cask "sonarr" do
  arch arm: "arm64", intel: "x64"

  version "4.0.18.2971"
  sha256 arm:   "6fdbeff4cc00df1ae934df226ef68dc86d1b67eb430e6a7967e3f5a9f70ddff9",
         intel: "66038bf0e431e15bbbb98072929e3365886a02c4a5f38d6e49931f02b29e2977"

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
