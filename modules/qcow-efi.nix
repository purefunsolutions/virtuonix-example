# SPDX-FileCopyrightText: 2024 Mika Tammi / Pure Fun Solutions
#
# SPDX-License-Identifier: MIT
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    "${toString modulesPath}/profiles/qemu-guest.nix"
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/ESP";
    fsType = "vfat";
  };

  boot = {
    growPartition = true;
    kernelParams = map (c: "console=${c}") ["ttyS0" "ttyAMA0"];
    loader = {
      grub = {
        device = "nodev";
        efiSupport = true;
        efiInstallAsRemovable = true;
      };
      timeout = 0;
    };
  };

  system.build.qcow-efi = import "${toString modulesPath}/../lib/make-disk-image.nix" {
    inherit lib config pkgs;
    diskSize = "auto";
    format = "qcow2";
    partitionTableType = "efi";
  };
}
