_: {
  flake.nixosModules.desktop = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.desktop.notifications;
  in {
    options.forgeOS.desktop.notifications.enable = lib.mkEnableOption "Dunst Notifications Daemon";

    config = lib.mkIf cfg.enable {
      home-manager.sharedModules = [
        {
          services.dunst = {
            enable = true;
            settings = {
              global = {
                follow = "keyboard";
                width = 370;
                origin = "top-center";
                offset = "(0, 20)";
                separator_height = 1;
                padding = 3;
                horizontal_padding = 3;
                frame_width = 1;
                sort = "update";
                idle_threshold = 120;
                alignment = "center";
                word_wrap = "yes";
                format = "<b>%s</b>: %b";
                markup = "full";
                min_icon_size = 32;
                max_icon_size = 32;
                icon_corner_radius = 4;
                corner_radius = 4;
                background = "#232323";
                # frame_color = "#44475a";
                # highlight = mkForce base03;
              };
            };
          };
        }
      ];
    };
  };
}
