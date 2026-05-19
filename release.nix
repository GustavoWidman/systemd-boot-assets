let
  systemdVersion = "260.1";
  releaseTag = "systemd-v${systemdVersion}";
  baseUrl = "https://github.com/GustavoWidman/systemd-boot-assets/releases/download/${releaseTag}";
in {
  inherit systemdVersion releaseTag;
  bootstrap = false;

  assets = {
    bundle = {
      file = "systemd-boot-bundle.tar.gz";
      url = "${baseUrl}/systemd-boot-bundle.tar.gz";
      hash = "sha256-2ZAyZ+N81kUht83rNw1HT66rNQSpsEVPaY0Q04rFqr8=";
    };

    x64 = {
      file = "systemd-bootx64.efi";
      url = "${baseUrl}/systemd-bootx64.efi";
      hash = "sha256-7RtF84N0cmoV0PPK6h9OVfg+6lu8ZSuIu2SvbP+XNVE=";
    };

    aa64 = {
      file = "systemd-bootaa64.efi";
      url = "${baseUrl}/systemd-bootaa64.efi";
      hash = "sha256-n2haZZPNHBrV2MnK8pXc0R1uBBNFpvXmZMEtJ9GMyvY=";
    };

    manifest = {
      file = "manifest.json";
      url = "${baseUrl}/manifest.json";
      hash = "sha256-Mw/kc3+CkxH5VBjnlKtZW7hcOR7sZEJjeAAKwm1P44U=";
    };

    checksums = {
      file = "SHA256SUMS";
      url = "${baseUrl}/SHA256SUMS";
      hash = "sha256-h5COOXY8at0vJEn3X5Vqqju2Y7iSSRrtzKVrO4AkErc=";
    };
  };
}
