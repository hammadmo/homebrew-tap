cask "hachibu" do
  version "0.2"
  sha256 "ce4535f7f363decb0db2a39bfd329f78e2f8ba6f9aeb0be8a58d36b9f2ea9924"

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
