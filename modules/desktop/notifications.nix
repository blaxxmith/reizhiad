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
          programs.noctalia.settings.notifications = {
            backgroundOpacity = 1;
            clearDismissed = true;
            criticalUrgencyDuration = 15;
            density = "compact";
            enableBatteryToast = true;
            enableKeyboardLayoutToast = true;
            enableMarkdown = true;
            enableMediaToast = false;
            enabled = true;
            location = "top";
            lowUrgencyDuration = 3;
            normalUrgencyDuration = 8;
            overlayLayer = true;
            respectExpireTimeout = false;
            saveToHistory = {
              critical = true;
              low = true;
              normal = true;
            };
            sounds.enabled = false;
          };
        }
      ];
    };
  };
}
