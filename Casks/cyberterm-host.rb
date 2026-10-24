cask "cyberterm-host" do
  version "0.5.0"
  sha256 "cb2d7a609e047ed8f516ed3b238cf683f1e52aa74b7b35313fdd4331d084850d"

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
