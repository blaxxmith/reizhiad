{...}: {
  flake.nixosModules.system = {lib, ...}: {
    networking = {
      # Domain for all hosts.
      domain = "forge";
      # Disable IPv6.
      enableIPv6 = false;
      # Enable NetworkManager.
      networkmanager.enable = lib.mkDefault true;
      # Enable the firewall.
      firewall.enable = true;
    };

    services.netbird.enable = false;
  };
}
