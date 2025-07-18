cask "skyfonts" do
  version "5.9.5.8"
  sha256 "65a914edce60c0110d4ad4ff371389059ff6ab77b6e0a4b7135c9f3097d8565d"

  url "https://cdn1.skyfonts.com/client/Monotype_SkyFonts_Mac64_#{version}.dmg"
  name "SkyFonts"
  desc "Font manager"
  homepage "https://skyfonts.com/"

  livecheck do
    url "https://api.skyfonts.com/api/SkyFontsAppCast?osid=3"
    regex(%r{href=.*?/Monotype_SkyFonts_Mac64_(\d+(?:\.\d+)*)\.dmg}i)
  end

  no_autobump! because: :requires_manual_review

  installer manual: "Install SkyFonts.app"

  uninstall launchctl: "com.mti.Monotype-SkyFontsHelper",
            quit:      [
              "com.mti.Monotype-SkyFonts",
              "com.mti.Monotype-SkyFontsHelper",
            ],
            delete:    [
              "/Applications/Skyfonts",
              "~/Library/Fonts/skyfonts-google",
            ]

  zap trash: [
    "~/Library/Application Support/com.mti.Monotype-SkyFonts",
    "~/Library/Application Support/sf",
    "~/Library/Caches/com.mti.Monotype-SkyFonts",
    "~/Library/HTTPStorages/com.mti.Monotype-SkyFonts.binarycookies",
    "~/Library/HTTPStorages/com.mti.Monotype-SkyFonts.plist",
    "~/Library/Preferences/com.mti.Monotype-SkyFonts.plist",
  ]
end
