cask "tautulli" do
  version "2.17.1"
  sha256 "aca5a378b081c4fd4bf19b9ebc5153051828732cc0a8a19ef258de72d2d15aa6"

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
