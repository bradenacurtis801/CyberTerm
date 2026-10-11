class CybertermAgent < Formula
  desc "CyberTerm host daemon: lets the CyberTerm app approve and follow your coding agents"
  homepage "https://github.com/bradenacurtis801/CyberTerm"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.2.0/cyberterm-agent-aarch64-apple-darwin.tar.xz"
      sha256 "4638eebf8f1429d9cecfa803913d5ec9879c057c4944134a4b8827c2524d268b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.2.0/cyberterm-agent-x86_64-apple-darwin.tar.xz"
      sha256 "c3663149070413ce15f7cee87eda33ebfc899059cb7889c547ef660305ea453a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.2.0/cyberterm-agent-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d58e2df7f148f40b3ef97584b12f4dcf7e128e86727b6cb1ffa7985dadabb29a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.2.0/cyberterm-agent-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "70f0bb1b92f83d97ad07754380e4a2d00e68efddc3f61774d52a3f2abf972112"
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
