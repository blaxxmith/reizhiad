_: {
  flake.nixosModules.apps = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.apps.chromium;
  in {
    options.forgeOS.apps.chromium.enable = lib.mkEnableOption "Chromium Browser";

    config.home-manager.users."${config.forgeOS.profile.user}".programs.chromium = lib.mkIf cfg.enable {
      enable = true;
      package = pkgs.chromium;
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
        "gcknhkkoolaabfmlnjonogaaifnjlfnp" # FoxyProxy
        "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
      ];
    };
  };
}
