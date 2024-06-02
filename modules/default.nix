# SPDX-FileCopyrightText: 2024 Mika Tammi / Pure Fun Solutions
#
# SPDX-License-Identifier: MIT
#
# NixOS Modules to be exported from the flake
_: {
  flake.nixosModules = {
    virtuonix-example-config.imports = [
      ./qcow2-efi.nix
    ];
  };
}
