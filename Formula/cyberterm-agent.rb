class CybertermAgent < Formula
  desc "CyberTerm host daemon: lets the CyberTerm app approve and follow your coding agents"
  homepage "https://github.com/bradenacurtis801/CyberTerm"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bradenacurtis801/CyberTermAgent/releases/download/v0.1.0/cyberterm-agent-aarch64-apple-darwin.tar.xz"
      sha256 "156e962e31c89461643b55e9823eb54e933862a84ba5d122ec1d63c827e45cd0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bradenacurtis801/CyberTermAgent/releases/download/v0.1.0/cyberterm-agent-x86_64-apple-darwin.tar.xz"
      sha256 "9611f169e2669f6f7a35effb7e2e9845c05a9f2d06bb40b85fa77f09b9c532d5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bradenacurtis801/CyberTermAgent/releases/download/v0.1.0/cyberterm-agent-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c855b9fd3381aad358d4f65fd575cbd2c8f6636055acebe1b0b2b566c0b5b34f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bradenacurtis801/CyberTermAgent/releases/download/v0.1.0/cyberterm-agent-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6c14d9d5d58519f8fc509ab852a4d8c2bd6d12844dd89f98da0f67f988a2d1e3"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cyberterm-agent-hook", "cyberterm-agentd"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cyberterm-agent-hook", "cyberterm-agentd"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cyberterm-agent-hook", "cyberterm-agentd"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cyberterm-agent-hook", "cyberterm-agentd"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
