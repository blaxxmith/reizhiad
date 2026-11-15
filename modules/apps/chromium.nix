_: {
  flake.homeModules.apps = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.govelTY.apps.chromium;
  in {
    options.govelTY.apps.chromium.enable = lib.mkEnableOption "Chromium Browser";

    config = lib.mkIf cfg.enable {
      programs.chromium = {
        enable = true;
        package = pkgs.chromium;
        extensions = [
          "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
          "gcknhkkoolaabfmlnjonogaaifnjlfnp" # FoxyProxy
          "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
        ];
      };
    };
  };
}
