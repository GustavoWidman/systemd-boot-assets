let
  systemdVersion = "260.1";
  releaseTag = "systemd-v${systemdVersion}";
  baseUrl = "https://github.com/GustavoWidman/systemd-boot-assets/releases/download/${releaseTag}";
  fakeHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
in {
  inherit systemdVersion releaseTag;
  bootstrap = true;

  assets = {
    bundle = {
      file = "systemd-boot-bundle.tar.gz";
      url = "${baseUrl}/systemd-boot-bundle.tar.gz";
      hash = fakeHash;
    };

    x64 = {
      file = "systemd-bootx64.efi";
      url = "${baseUrl}/systemd-bootx64.efi";
      hash = fakeHash;
    };

    aa64 = {
      file = "systemd-bootaa64.efi";
      url = "${baseUrl}/systemd-bootaa64.efi";
      hash = fakeHash;
    };

    manifest = {
      file = "manifest.json";
      url = "${baseUrl}/manifest.json";
      hash = fakeHash;
    };

    checksums = {
      file = "SHA256SUMS";
      url = "${baseUrl}/SHA256SUMS";
      hash = fakeHash;
    };
  };
}
