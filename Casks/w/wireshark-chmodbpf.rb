cask "wireshark-chmodbpf" do
  arch arm: "Arm", intel: "Intel"

  version "4.4.7"
  sha256 arm:   "af1189f35774c2cf86578c4c143a79824c43070c59f7b01acff27469a40a847a",
         intel: "dd735fa58a7390e242717a9badcc2168ff9c41ec559a4897b193d5b46f3b2788"

  url "https://www.wireshark.org/download/osx/Wireshark%20#{version}%20#{arch}%2064.dmg"
  name "Wireshark-ChmodBPF"
  desc "Network protocol analyzer"
  homepage "https://www.wireshark.org/"

  livecheck do
    cask "wireshark-app"
  end

  conflicts_with cask: "wireshark-app"
  depends_on macos: ">= :sierra"

  pkg "Install ChmodBPF.pkg"

  uninstall early_script: {
              executable:   "/usr/sbin/installer",
              args:         ["-pkg", "#{staged_path}/Uninstall ChmodBPF.pkg", "-target", "/"],
              sudo:         true,
              must_succeed: false,
            },
            pkgutil:      "org.wireshark.ChmodBPF.pkg"

  # No zap stanza required

  caveats do
    reboot
    <<~EOS
      This cask will install only the ChmodBPF package from the current Wireshark
      stable install package.
      An access_bpf group will be created and its members allowed access to BPF
      devices at boot to allow unprivileged packet captures.
      This cask is not required if installing the Wireshark cask. It is meant to
      support Wireshark installed from Homebrew or other cases where unprivileged
      access to macOS packet capture devices is desired without installing the binary
      distribution of Wireshark.
      The user account used to install this cask will be added to the access_bpf
      group automatically.
    EOS
  end
end
