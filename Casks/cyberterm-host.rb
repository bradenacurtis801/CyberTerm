cask "cyberterm-host" do
  version "0.3.0"
  sha256 "f8355dbc2dc08d22d8f2d39c5e15a327b96d9ca78b15c574e82b43d8da1cfd63"

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
