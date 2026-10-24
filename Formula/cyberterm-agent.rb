class CybertermAgent < Formula
  desc "CyberTerm host daemon: lets the CyberTerm app approve and follow your coding agents"
  homepage "https://github.com/bradenacurtis801/CyberTerm"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.5.0/cyberterm-agent-aarch64-apple-darwin.tar.xz"
      sha256 "d8aae4b514ce5d03f23c418f2f875a45cd5369f00ab438d5d057927c6e149bdd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.5.0/cyberterm-agent-x86_64-apple-darwin.tar.xz"
      sha256 "143fc1a0cfd4b67ff7e634d7dd69138fa7c6b5d73dac7dc7053b2e89e8a0dea7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.5.0/cyberterm-agent-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cbc0b5684aa32fb67139fe4df82f5c7852b499bf5e1b0292eb58b5f1a2e1d342"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.5.0/cyberterm-agent-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "719b2dd51963d5e5c9644f9ffc242809426268afafbc923bcf630ce30350382f"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
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
      bin.install "cyberterm-agent-hook", "cyberterm-agentd", "cyberterm-pty-supervisor"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cyberterm-agent-hook", "cyberterm-agentd", "cyberterm-pty-supervisor"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cyberterm-agent-hook", "cyberterm-agentd", "cyberterm-pty-supervisor"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cyberterm-agent-hook", "cyberterm-agentd", "cyberterm-pty-supervisor"
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
