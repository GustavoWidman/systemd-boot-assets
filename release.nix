let
  systemdVersion = "261";
  releaseTag = "systemd-v261";
  baseUrl = "https://github.com/GustavoWidman/systemd-boot-assets/releases/download/${releaseTag}";
in {
  inherit systemdVersion releaseTag;
  bootstrap = false;

  assets = {
    bundle = {
      file = "systemd-boot-bundle.tar.gz";
      url = "${baseUrl}/systemd-boot-bundle.tar.gz";
      hash = "sha256-TbKB8tXdR/6Q0dvxk0+uKoSoEpnMM48u7s62w9+nKek=";
    };

    x64 = {
      file = "systemd-bootx64.efi";
      url = "${baseUrl}/systemd-bootx64.efi";
      hash = "sha256-Ji5u6KCRQxLMWZXU2Vpvy214d7gHo553fNpofVm33p0=";
    };

    aa64 = {
      file = "systemd-bootaa64.efi";
      url = "${baseUrl}/systemd-bootaa64.efi";
      hash = "sha256-ak9sC1R1iNZ6bm3Ywkr3/pqSQnyxr5HH09EA9wI4kcg=";
    };

    manifest = {
      file = "manifest.json";
      url = "${baseUrl}/manifest.json";
      hash = "sha256-6JOHxDWQ54JHYtrqWt2GFQ20blv+pCSpguw5eti/F0g=";
    };

    checksums = {
      file = "SHA256SUMS";
      url = "${baseUrl}/SHA256SUMS";
      hash = "sha256-ds2kTNR53Ijq0cylxUI/PGez1j6uzkHDNf6FU1wrzQk=";
    };
  };
}
