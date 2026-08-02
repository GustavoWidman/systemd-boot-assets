let
  systemdVersion = "261.1";
  releaseTag = "systemd-v261.1";
  baseUrl = "https://github.com/GustavoWidman/systemd-boot-assets/releases/download/${releaseTag}";
in {
  inherit systemdVersion releaseTag;
  bootstrap = false;

  assets = {
    bundle = {
      file = "systemd-boot-bundle.tar.gz";
      url = "${baseUrl}/systemd-boot-bundle.tar.gz";
      hash = "sha256-+RG0Iuh1yoDIwDZhafeC2ZPI8WaHg94mnDVdTGSEgTo=";
    };

    x64 = {
      file = "systemd-bootx64.efi";
      url = "${baseUrl}/systemd-bootx64.efi";
      hash = "sha256-cbJ7KIVN7kZjaFpGsfbAd2HDc5kFgVZLDtK2EwWR4qI=";
    };

    aa64 = {
      file = "systemd-bootaa64.efi";
      url = "${baseUrl}/systemd-bootaa64.efi";
      hash = "sha256-abIeO8YXjsaJ1uJIQak71wetNgxIp8EkF4YTk3t0sdU=";
    };

    manifest = {
      file = "manifest.json";
      url = "${baseUrl}/manifest.json";
      hash = "sha256-tkG0fLAo8xTb76RQPp9qFCseJGhT8JTA5T0vgT5mrfw=";
    };

    checksums = {
      file = "SHA256SUMS";
      url = "${baseUrl}/SHA256SUMS";
      hash = "sha256-j+yPnMfjC7xTyNpJyptpublBK9+8WTGz3W4RO1GiIUY=";
    };
  };
}
