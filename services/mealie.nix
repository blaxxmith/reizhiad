{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.forgeOS.services.mealie;
in {
  options.forgeOS.services.mealie = {
    enable = lib.mkEnableOption "Mealie, a self-hosted recipe manager and meal planner";

    net = {
      port = lib.mkOption {
        type = lib.types.int;
        default = 9000;
        description = "Port for Mealie to listen on.";
      };
      addr = lib.mkOption {
        type = lib.types.str;
        default = "0.0.0.0";
        description = "Address for Mealie to bind to.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.mealie = {
      enable = true;
      package = pkgs.mealie;
      listenAddress = cfg.net.addr;
      inherit (cfg.net) port;
      database.createLocally = true;
    };
  };
}
