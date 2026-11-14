_: {
  flake.nixosModules.desktop = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.desktop.notifications;
  in {
    options.forgeOS.desktop.notifications.enable = lib.mkEnableOption "Notifications Daemon";

    config = lib.mkIf cfg.enable {
      home-manager.sharedModules = [
        {
          programs.noctalia.settings.notification = {
            background_opacity = 1.0;
            border = false;
            history_retention_hours = 6;
          };
        }
      ];
    };
  };
}
