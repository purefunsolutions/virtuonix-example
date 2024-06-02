# SPDX-FileCopyrightText: 2024 Mika Tammi / Pure Fun Solutions
#
# SPDX-License-Identifier: MIT
#
# Packages to be exported from the flake
{
  perSystem = {lib, ...}: {
    packages = let
      qcow2System = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [../modules/qcow-efi.nix];
      };
      virtuonix-example-qcow2 = qcow2System.config.system.build.qcow-efi;
      default = virtuonix-example-qcow2;
    in {
      inherit default virtuonix-example-qcow2;
    };
  };
}
