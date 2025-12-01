class Flood < Formula
  desc "Modern web UI for various torrent clients"
  homepage "https://github.com/jesec/flood"
  version "4.11.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/jesec/flood/releases/download/v#{version}/flood-macos-x64"
      sha256 "7fc6814cb475b4f98120e773278378cc889aa1922c05cc2050d056befc5d723e"
    elsif Hardware::CPU.arm?
      url "https://github.com/jesec/flood/releases/download/v#{version}/flood-macos-arm64"
      sha256 "a790ff3d7feff29d32059ea918de8f0d357162407eff2f86228754f765f0f0a2"
    end
  end

  def install
    if Hardware::CPU.intel?
      bin.install "flood-macos-x64" => "flood"
    elsif Hardware::CPU.arm?
      bin.install "flood-macos-arm64" => "flood"
    end
  end

  service do
    run [opt_bin/"flood"]
    keep_alive true
    log_path var/"log/flood.log"
    error_log_path var/"log/flood.log"
  end

  test do
    system "#{bin}/flood", "--version"
  end
end
