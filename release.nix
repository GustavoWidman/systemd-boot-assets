let
  systemdVersion = "260.2";
  releaseTag = "systemd-v260.2";
  baseUrl = "https://github.com/GustavoWidman/systemd-boot-assets/releases/download/${releaseTag}";
in {
  inherit systemdVersion releaseTag;
  bootstrap = false;

  assets = {
    bundle = {
      file = "systemd-boot-bundle.tar.gz";
      url = "${baseUrl}/systemd-boot-bundle.tar.gz";
      hash = "sha256-UA/hFyM+RSG9iNHFClWJDqExSh+lW3rX+8++UUuWwC4=";
    };

    x64 = {
      file = "systemd-bootx64.efi";
      url = "${baseUrl}/systemd-bootx64.efi";
      hash = "sha256-PGiJw191owI59YnfiCW1/GqwBCD9C7j/o6IwMmeswmk=";
    };

    aa64 = {
      file = "systemd-bootaa64.efi";
      url = "${baseUrl}/systemd-bootaa64.efi";
      hash = "sha256-2WShp5hhwWnsmzEHxBDJkGgL+KxoTaEnbXjGz0XhykQ=";
    };

    manifest = {
      file = "manifest.json";
      url = "${baseUrl}/manifest.json";
      hash = "sha256-de9kemr2eVsE63/AWX1KjpPVhQx5Jr3tXNlDY6rKhII=";
    };

    checksums = {
      file = "SHA256SUMS";
      url = "${baseUrl}/SHA256SUMS";
      hash = "sha256-SCNXlm5RDpp1jyqfM/bgBioLapicQzL+Xu933aRQ15w=";
    };
  };
}
