class CybertermAgent < Formula
  desc "CyberTerm host daemon: lets the CyberTerm app approve and follow your coding agents"
  homepage "https://github.com/bradenacurtis801/CyberTerm"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.4.1/cyberterm-agent-aarch64-apple-darwin.tar.xz"
      sha256 "8c5731ad4f9333afd10912f3ee1f5f96c9283fd9c1f41fc6b0304059a5eadfc4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.4.1/cyberterm-agent-x86_64-apple-darwin.tar.xz"
      sha256 "1841d24ebb0ebbf677b3dc3a3282200e3961b5aec0601dc5b857b92f791fd460"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.4.1/cyberterm-agent-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e0115b547b4ac7c244eedea8c20c531e3571a08334ff34281f3e8ea2cd628263"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.4.1/cyberterm-agent-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d6f97261bb19ad5b10ab55d50e0912faae87a43b1ca3c2ef65922b24534fe301"
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
