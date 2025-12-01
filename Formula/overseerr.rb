class Overseerr < Formula
  desc "Request management and media discovery tool for the Plex ecosystem"
  homepage "https://overseerr.dev/"
  version "1.34.0"
  url "https://github.com/sct/overseerr/archive/refs/tags/v#{version}.tar.gz"
  sha256 "c5af2fcd1e7da842b8f0d97f7dbfc2d9461c86bf6bfaac879c8842af359f6102"
  license "MIT"

  depends_on "yarn" => :build
  depends_on "node@20"

  def install
    system "yarn", "install", "--frozen-lockfile"
    system "yarn", "build"

    libexec.install Dir["*"]

    # Create wrapper script that supports --version flag
    (bin/"overseerr").write <<~EOS
      #!/bin/bash
      if [ "$1" = "--version" ]; then
        echo "Overseerr #{version}"
        exit 0
      fi
      export CONFIG_DIRECTORY="#{var}/lib/overseerr/config"
      export PORT="5055"
      exec "#{Formula["node@20"].opt_bin}/node" "#{libexec}/dist/index.js" "$@"
    EOS
    chmod 0755, bin/"overseerr"
  end

  service do
    run [opt_bin/"overseerr"]
    keep_alive true
    log_path var/"log/overseerr.log"
    error_log_path var/"log/overseerr.log"
  end

  test do
    assert_path_exists bin/"overseerr"
    assert_match "Overseerr #{version}", shell_output("#{bin}/overseerr --version")
  end
end
