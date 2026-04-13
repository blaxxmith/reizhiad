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

    config.home-manager.sharedModules = lib.mkIf cfg.enable [
      {
        programs.chromium = {
          enable = true;
          package = pkgs.chromium;
          extensions = [
            "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
            "gcknhkkoolaabfmlnjonogaaifnjlfnp" # FoxyProxy
            "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
          ];
        };
      }
    ];
  };
}
