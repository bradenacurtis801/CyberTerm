class CybertermAgent < Formula
  desc "CyberTerm host daemon: lets the CyberTerm app approve and follow your coding agents"
  homepage "https://github.com/bradenacurtis801/CyberTerm"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.1.1/cyberterm-agent-aarch64-apple-darwin.tar.xz"
      sha256 "23259682edcbe50f49e614569295be3c80e10b4e27e8c74f6e772e9def5ea950"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.1.1/cyberterm-agent-x86_64-apple-darwin.tar.xz"
      sha256 "40a923cfa45c6021b1e04f96014ce69fdf527e0f4618f8f28f45ac7a51612178"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.1.1/cyberterm-agent-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0385f54e8eb45878708b655da1c64b9d08fe9916343cab23ef92386477d628d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v0.1.1/cyberterm-agent-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "87f517d63ef04d1496a8ad7e98c320adb65115621b8cb7ff4ad068a845b6ccaa"
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
