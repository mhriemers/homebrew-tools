class Overseerr < Formula
  desc "Request management and media discovery tool for the Plex ecosystem"
  homepage "https://overseerr.dev/"
  url "https://github.com/sct/overseerr/archive/refs/tags/v1.34.0.tar.gz"
  version "1.34.0"
  sha256 "c5af2fcd1e7da842b8f0d97f7dbfc2d9461c86bf6bfaac879c8842af359f6102"
  license "MIT"

  depends_on "yarn" => :build
  depends_on "node@20"

  def install
    system "yarn", "install", "--frozen-lockfile"
    system "yarn", "build"
    system "yarn", "install", "--production", "--ignore-scripts", "--prefer-offline"

    rm_rf "src"
    rm_rf "server"
    rm_rf ".next/cache"

    libexec.install Dir["*"], ".next"
  end

  def post_install
    (var/"lib/overseerr/config").mkpath
  end

  service do
    run [Formula["node@20"].opt_bin/"node", libexec/"dist/index.js"]
    keep_alive true
    working_dir libexec
    environment_variables \
      PATH: std_service_path_env,
      NODE_ENV: "production",
      PORT: "5055",
      CONFIG_DIRECTORY: var/"lib/overseerr/config"
      
    log_path var/"log/overseerr.log"
    error_log_path var/"log/overseerr.log"
  end

  test do
    assert_path_exists libexec/"dist/index.js"
  end
end
