cask "hachibu" do
  version "0.4.1"
  sha256 "c98b09bd99c5aea656946f31de3e93355f4ac1e2e614976eb7ac86ab390adefd"

  url "https://github.com/hammadmo/hachibu/releases/download/v#{version}/Hachibu-#{version}.zip"
  name "Hachibu"
  desc "Menu bar app that keeps a MacBook battery at a chosen charge limit"
  homepage "https://github.com/hammadmo/hachibu"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :golden_gate

  app "Hachibu.app"

  # The helper is left alone here: this also runs on an upgrade, and taking
  # the helper out of launchd then leaves Hachibu unable to reach it.
  uninstall quit: "app.hachibu.mac"

  zap launchctl: "app.hachibu.mac.helper",
      trash:     [
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
