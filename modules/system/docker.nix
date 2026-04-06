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
      dns = lib.mkEnableOption "Enable /forge Docker DNS";
      expose = lib.mkEnableOption "Expose Docker on the network";
      dnsServer = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "DNS server to use for Docker DNS";
      };
      externalIp = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "External IP to use for Docker";
      };
    };

    config = lib.mkIf cfg.enable {
      virtualisation.docker = {
        enable = true;
        daemon.settings = {
          ipv6 = false;
          dns = lib.mkIf cfg.dns [cfg.dnsServer];
          hosts = lib.mkIf cfg.expose [
            # "unix:///var/run/docker.sock"
            "tcp://${cfg.externalIp}:2375"
          ];
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
