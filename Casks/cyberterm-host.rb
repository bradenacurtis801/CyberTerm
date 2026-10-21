cask "cyberterm-host" do
  version "0.4.1"
  sha256 "bcaacf9ad4f3efaa45d3d572bf320ee5b48bd2929ccb3a356b30ce55f136f36c"

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
