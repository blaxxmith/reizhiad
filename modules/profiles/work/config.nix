_: {
  flake.nixosModules.work-profile = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.profiles.work;
  in
    lib.mkIf cfg.enable {
      security.pki.certificateFiles = [
        # Main
        # (builtins.readFile config.sops.secrets.crt-alpes.path)
        # (builtins.readFile config.sops.secrets.crt-axis.path)
        # (builtins.readFile config.sops.secrets.crt-carl.path)
        # (builtins.readFile config.sops.secrets.crt-vox.path)
        # (builtins.readFile config.sops.secrets.crt-sis.path)

        # Extra
        # (builtins.readFile config.sops.secrets.crt-multi.path)
        # (builtins.readFile config.sops.secrets.crt-tavel.path)
        # (builtins.readFile config.sops.secrets.crt-telex.path)
        # (builtins.readFile config.sops.secrets.crt-vigan.path)
      ];

      services.netbird.enable = false;

      networking = {
        hosts = {
          # Multi
          "10.102.0.61" = ["gestionnaire.si-dr.fr"];
          "10.101.0.51" = ["portal.si-dr.fr"];
          "10.101.0.61" = ["signal.si-dr.fr" "signal1.si-dr.fr" "signal2.si-dr.fr" "turn1.si-dr.fr" "turn2.si-dr.fr"];
          # "10.100.4.81" = ["influx.si-dr.fr" "monitoring.si-dr.fr"];
          "10.100.55.81" = ["influx.si-dr.fr" "monitoring.si-dr.fr" "metrics.si-dr.fr"];

          # Tavel
          # "10.100.0.51" = ["portal.si-dr.fr" "signal.si-dr.fr" "signal1.si-dr.fr" "signal2.si-dr.fr" "turn1.si-dr.fr" "turn2.si-dr.fr"];

          "127.0.0.1" = ["local.si-dr.fr" "office.si-dr.fr"];
        };
        wg-quick.interfaces = {
          # backdooris.configFile = config.sops.secrets.wg-backdooris.path;
        };
      };
    };
}
