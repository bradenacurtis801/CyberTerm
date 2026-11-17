class CybertermAgent < Formula
  desc "CyberTerm host daemon: lets the CyberTerm app approve and follow your coding agents"
  homepage "https://github.com/bradenacurtis801/CyberTerm"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.9.0/cyberterm-agent-aarch64-apple-darwin.tar.xz"
      sha256 "b1ae1aa9ab9bb797d88fa0a76585821f04a7a76f4deeafa3c9f99bf6c668ec1b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.9.0/cyberterm-agent-x86_64-apple-darwin.tar.xz"
      sha256 "434f159bd01e74452961daa9c18dc3de0fa19ad71776dbb7a34873161b34092e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.9.0/cyberterm-agent-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b4e0a51a023109906e154b4815da64af44b35a9569dd9be1a4794c0ccda2ea69"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.9.0/cyberterm-agent-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ef9819aa100b24de9c4a2e0efd5b4ce67f9eb1c17d1ace89cdb7415531216f1c"
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
