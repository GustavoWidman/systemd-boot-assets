let
  systemdVersion = "261.3";
  releaseTag = "systemd-v261.3";
  baseUrl = "https://github.com/GustavoWidman/systemd-boot-assets/releases/download/${releaseTag}";
in {
  inherit systemdVersion releaseTag;
  bootstrap = false;

  assets = {
    bundle = {
      file = "systemd-boot-bundle.tar.gz";
      url = "${baseUrl}/systemd-boot-bundle.tar.gz";
      hash = "sha256-ivVSNf+WGKuM6ILyV7CXgZ5MsnieUFRPEXw2h+SL4TA=";
    };

    x64 = {
      file = "systemd-bootx64.efi";
      url = "${baseUrl}/systemd-bootx64.efi";
      hash = "sha256-kbzPSiQpmQqvReA9hWpo97ACgUOC17VQkG+Poc5vKhk=";
    };

    aa64 = {
      file = "systemd-bootaa64.efi";
      url = "${baseUrl}/systemd-bootaa64.efi";
      hash = "sha256-XnN0i0CkZQMg9ICO++zL2D3R/dkK2Pk7/1tr3eI6kcU=";
    };

    manifest = {
      file = "manifest.json";
      url = "${baseUrl}/manifest.json";
      hash = "sha256-eskSNr6+e1pJZN1j1OCbeNrvEjW8XZuWqzT2tFZS8do=";
    };

    checksums = {
      file = "SHA256SUMS";
      url = "${baseUrl}/SHA256SUMS";
      hash = "sha256-Z1Qow4jgQfvvqoU3PXBrq7GsOcTw6y8+TRWPkIR9GoU=";
    };
  };
}
