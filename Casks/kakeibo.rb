cask "kakeibo" do
  version "0.3.6"
  sha256 "c1c9ee65715a5422ba30e5cc9b635407098c33bd403d29cec5260364bd778d7c"

  url "https://github.com/hammadmo/kakeibo/releases/download/v#{version}/Kakeibo-#{version}.zip"
  name "Kakeibo"
  desc "Menu bar ledger of Claude usage: plan limits, tokens, cost, and projects"
  homepage "https://github.com/hammadmo/kakeibo"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Kakeibo.app"
  # The app binary is also the `kakeibo` command line tool.
  binary "#{appdir}/Kakeibo.app/Contents/MacOS/Kakeibo", target: "kakeibo"

  uninstall quit: "app.kakeibo.mac"

  zap trash: [
    "~/Library/Application Support/Kakeibo",
    "~/Library/Preferences/app.kakeibo.mac.plist",
  ]

  caveats <<~EOS
    Kakeibo reads your Claude plan limits with Claude Code's login. Sign in
    with `claude`, then /login. The first time, macOS asks whether Kakeibo may
    use the "Claude Code-credentials" Keychain item: click Always Allow.

    To ask Kakeibo from Claude Code, register its MCP server:
      claude mcp add --scope user kakeibo -- #{appdir}/Kakeibo.app/Contents/MacOS/Kakeibo mcp
  EOS
end
