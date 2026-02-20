{
  config,
  lib,
  ...
}: {
  networking = {
    hostName = "geonosis";

    interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
    interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

    hosts = {
      # Multi
      "10.102.0.61" = ["gestionnaire.si-dr.fr"];
      "10.101.0.51" = ["portal.si-dr.fr"];
      "10.101.0.61" = ["signal.si-dr.fr" "signal1.si-dr.fr" "signal2.si-dr.fr" "turn1.si-dr.fr" "turn2.si-dr.fr"];
      # "10.100.4.81" = ["influx.si-dr.fr" "monitoring.si-dr.fr"];
      "10.100.55.81" = ["influx.si-dr.fr" "monitoring.si-dr.fr" "metrics.si-dr.fr"];

      # Tavel
      # "10.100.0.51" = ["portal.si-dr.fr" "signal.si-dr.fr" "signal1.si-dr.fr" "signal2.si-dr.fr" "turn1.si-dr.fr" "turn2.si-dr.fr"];
    };

    firewall = {
      enable = true;
    };
  };
}
