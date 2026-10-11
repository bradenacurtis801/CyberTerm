cask "cyberterm-host" do
  version "0.2.0"
  sha256 "909cdb82dc11a5c95c9729e8c4a77dea5662273a8707e17bcaa8148d966b5ec6"

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
