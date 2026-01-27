class Librechat < Formula
  desc "Enhanced ChatGPT clone with multi-provider support"
  homepage "https://librechat.ai/"
  url "https://github.com/danny-avila/LibreChat/archive/refs/tags/v0.8.2-rc3.tar.gz"
  version "0.8.2-rc3"
  sha256 "b807468c139f225e22a81d23034055e88837969a027caf761f36d5f8ba543ade"
  license "MIT"

  depends_on "node@20"
  depends_on "mongodb/brew/mongodb-community" => :recommended

  def install
    # Build with node@20
    ENV.prepend_path "PATH", Formula["node@20"].opt_bin

    # Install dependencies (matching Dockerfile)
    system "npm", "ci", "--no-audit"

    # Build frontend with increased memory for React build
    ENV["NODE_OPTIONS"] = "--max-old-space-size=6144"
    system "npm", "run", "frontend"

    # Cleanup dev dependencies (matching Dockerfile)
    system "npm", "prune", "--production"
    system "npm", "cache", "clean", "--force"

    # Remove unnecessary files
    rm_rf ".git"
    rm_rf ".github"
    rm_rf "e2e"
    rm_rf ".husky"

    # Install to libexec
    libexec.install Dir["*"]
    libexec.install ".env.example"

    # Create wrapper script using Node's --env-file flag
    (bin/"librechat").write <<~EOS
      #!/bin/bash
      export NODE_ENV=production
      export HOST=${HOST:-0.0.0.0}
      export PORT=${PORT:-3080}
      cd "#{libexec}"
      exec "#{Formula["node@20"].opt_bin}/node" --env-file="#{var}/lib/librechat/.env" api/server/index.js "$@"
    EOS
  end

  def post_install
    # Create data directory
    (var/"lib/librechat").mkpath

    # Copy example .env if not exists
    env_file = var/"lib/librechat/.env"
    unless env_file.exist?
      cp libexec/".env.example", env_file
      ohai "Created #{env_file}"
      ohai "Edit this file to configure API keys and MongoDB URI"
    end
  end

  def caveats
    <<~EOS
      LibreChat installed!

      Setup:
        1. Edit config: #{var}/lib/librechat/.env
           - Set MONGO_URI (default: mongodb://localhost:27017/LibreChat)
           - Add API keys (OPENAI_API_KEY, ANTHROPIC_API_KEY, etc.)

        2. Start MongoDB:
           brew services start mongodb-community

        3. Start LibreChat:
           brew services start librechat

        4. Open http://localhost:3080

      Files:
        Config: #{var}/lib/librechat/.env
        Logs:   #{var}/log/librechat.log
    EOS
  end

  service do
    run [opt_bin/"librechat"]
    keep_alive true
    working_dir libexec
    environment_variables \
      PATH: std_service_path_env,
      NODE_ENV: "production",
      HOST: "0.0.0.0",
      PORT: "3080"
    log_path var/"log/librechat.log"
    error_log_path var/"log/librechat.log"
  end

  test do
    assert_predicate libexec/"api/server/index.js", :exist?
  end
end
