_: {
  flake.nixosModules.system = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.system;
  in {
    options.forgeOS.system.name = lib.mkOption {
      type = lib.types.str;
      description = "";
      default = "urzhiataer";
    };

    config = {
      networking = {
        hostName = cfg.name;
        domain = "forge";
        enableIPv6 = false;
        networkmanager.enable = lib.mkDefault true;
        firewall.enable = true;
      };

      services.netbird.enable = lib.mkDefault true;
    };
  };
}
