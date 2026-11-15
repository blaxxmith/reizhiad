{self, ...}: {
  flake.nixosModules.apps = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.apps;
  in {
    options.forgeOS.apps.enable = lib.mkEnableOption "Applications module";

    config = lib.mkIf cfg.enable {
      home-manager.sharedModules = [self.homeModules.apps];
    };
  };
}
