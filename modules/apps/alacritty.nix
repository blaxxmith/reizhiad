{...}: {
  flake.homeModules.apps = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.apps.alacritty;
  in {
    options.forgeOS.apps.alacritty.enable = lib.mkEnableOption "Alacritty Terminal";

    config = lib.mkIf cfg.enable {
      programs.alacritty = {
        enable = true;
        settings = {
          window = {
            decorations = "buttonless";
            dynamic_title = true;
            opacity = 0.91;
            startup_mode = "Windowed";
            dimensions = {
              columns = 150;
              lines = 50;
            };
            padding = {
              x = 3;
              y = 3;
            };
          };
          cursor = {
            blink_interval = 750;
            style = {
              blinking = "Always";
              shape = "Underline";
            };
          };
          font = {
            size = 9;
            normal.family = "Hack Nerd Font";
          };
          keyboard.bindings = [
            {
              key = "F";
              mods = "Control|Shift";
              action = "ReceiveChar";
            }
          ];
        };
      };
    };
  };
}
