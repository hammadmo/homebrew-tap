cask "hachibu" do
  version "0.3"
  sha256 "e2bfeeca4ccf76d6d92f8e6f052f3a6659cdab9c97f5aa8243c17b6114271609"

  url "https://github.com/hammadmo/hachibu/releases/download/v#{version}/Hachibu-#{version}.zip"
  name "Hachibu"
  desc "Menu bar app that keeps a MacBook battery at a chosen charge limit"
  homepage "https://github.com/hammadmo/hachibu"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :golden_gate

  app "Hachibu.app"

  uninstall launchctl: "app.hachibu.mac.helper",
            quit:      "app.hachibu.mac"

  zap trash: [
    "~/Library/Application Support/Hachibu",
    "~/Library/Preferences/app.hachibu.mac.plist",
  ]

  caveats <<~EOS
    Limits below 80%, sailing, heat protection, and calibration need Hachibu's
    helper. Install it from Settings > Helper and allow it once in
    System Settings > General > Login Items.

    Before uninstalling, click "Remove Helper…" in Settings > Helper. That moves
    a limit macOS does not offer by itself up to one it does. The charge limit
    is a macOS setting and stays as it is after Hachibu is gone.
  EOS
end
