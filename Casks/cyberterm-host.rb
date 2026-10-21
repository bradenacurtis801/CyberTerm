cask "cyberterm-host" do
  version "0.4.0"
  sha256 "485cb6f7f8c3a6b93670da510bd163d66ae3690e592767d4cc1d318cdf9a4f26"

  url "https://github.com/bradenacurtis801/CyberTerm/releases/download/v#{version}/CyberTerm-Host-#{version}.dmg"
  name "CyberTerm Host"
  desc "Follow and approve your coding agents from your phone"
  homepage "https://github.com/bradenacurtis801/CyberTerm"

  app "CyberTerm Host.app"

  # It updates itself (Tauri's updater).
  auto_updates true

  uninstall quit: "com.cyberkvm.cyberterm-host"

  caveats <<~EOS
    CyberTerm Host sets up a background service. To remove it before
    uninstalling the app, run:
      "/Applications/CyberTerm Host.app/Contents/MacOS/cyberterm-agentd" uninstall
  EOS
end
