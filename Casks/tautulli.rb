cask "tautulli" do
  version "2.17.2"
  sha256 "3598217056e25b242b109a7eaa4fef42a89c009372ec071e15b95c0d8c14d846"

  url "https://github.com/Tautulli/Tautulli/releases/download/v#{version}/Tautulli-macos-v#{version}-universal.pkg",
      verified: "github.com/Tautulli/Tautulli/"
  name "Tautulli"
  desc "Monitoring and tracking tool for Plex Media Server"
  homepage "https://tautulli.com/"

  # The macOS build is a .pkg with no self-updater (the .app is a frozen
  # PyInstaller bundle), so Homebrew is the update mechanism. GitHub Actions
  # bumps version+sha256 from the latest GitHub release.
  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :big_sur

  pkg "Tautulli-macos-v#{version}-universal.pkg"

  uninstall quit:    "com.Tautulli.Tautulli",
            pkgutil: "com.Tautulli.Tautulli"

  zap trash: [
    "~/Library/Application Support/Tautulli",
    "~/Library/Logs/Tautulli",
  ]
end
