{self, ...}: {
  flake.nixosModules.apps = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.apps;
  in {
    imports = [
      self.nixosModules.zen
    ];

    options.forgeOS.apps.enable = lib.mkEnableOption "Applications module";

    config = lib.mkIf cfg.enable {
      home-manager.sharedModules = [self.homeModules.apps];
    };
  };
}
