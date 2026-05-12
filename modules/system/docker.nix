_: {
  flake.nixosModules.docker = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.docker;
  in {
    options.docker = {
      enable = lib.mkEnableOption "Activate Docker on this system.";
    };

    config = lib.mkIf cfg.enable {
      virtualisation.docker = {
        enable = true;
        daemon.settings = {
          ipv6 = false;
          log-driver = "json-file";
          log-opts = {
            "max-size" = "10m";
            "max-file" = "3";
          };
        };
      };

      environment.systemPackages = [pkgs.docker];
    };
  };
}
