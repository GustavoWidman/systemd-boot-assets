let
  systemdVersion = "261.2";
  releaseTag = "systemd-v261.2";
  baseUrl = "https://github.com/GustavoWidman/systemd-boot-assets/releases/download/${releaseTag}";
in {
  inherit systemdVersion releaseTag;
  bootstrap = false;

  assets = {
    bundle = {
      file = "systemd-boot-bundle.tar.gz";
      url = "${baseUrl}/systemd-boot-bundle.tar.gz";
      hash = "sha256-CjUG2WMuEAIQ7vMU0u9BNVwkvMGdK0akBc/j6fTKBiQ=";
    };

    x64 = {
      file = "systemd-bootx64.efi";
      url = "${baseUrl}/systemd-bootx64.efi";
      hash = "sha256-KlP+KSSc1QPaiVWOU4AjJ3KPNEsEGTcxzZ7Z4rh2wJg=";
    };

    aa64 = {
      file = "systemd-bootaa64.efi";
      url = "${baseUrl}/systemd-bootaa64.efi";
      hash = "sha256-7STn6LOF8l+d+IEsiZ7PWBpqqHNogntqSkH+TLb1E80=";
    };

    manifest = {
      file = "manifest.json";
      url = "${baseUrl}/manifest.json";
      hash = "sha256-MBoHVEcYWBLsAvWLuCZ38FR/WRkek2QPYcLTTJOnQcc=";
    };

    checksums = {
      file = "SHA256SUMS";
      url = "${baseUrl}/SHA256SUMS";
      hash = "sha256-VpzFXxXPeAwei/jBIWj9cD1Yv4k3tP9GYOfZaA2G42U=";
    };
  };
}
