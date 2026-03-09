{
  config,
  lib,
  ...
}: let
  cfg = config.forgeOS.desktop.theme;
  wallpaper = "${config.home.homeDirectory}/.assets/wallpaper.png";
in {
  options.forgeOS.desktop.theme = {
    enable = lib.mkEnableOption "Theme Configuration";
    wallpaper = lib.mkOption {
      type = lib.types.path;
      default = ../../.assets/wallpaper.png;
      description = "Path to the wallpaper image.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.file.".config/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
    '';

    home.file.".config/gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
    '';

    home.file.".assets/wallpaper.png".source = cfg.wallpaper;

    programs.swaylock.settings.image = "${wallpaper}";

    wayland.windowManager.sway.config = {
      startup = [
        {
          command = "swaymsg output '*' bg ${wallpaper} fill";
          always = true;
        }
      ];
      colors = {
        background = "#000000";
        focused = {
          border = "#ff4d00";
          childBorder = "#ff4d00";
          background = "#ff4d00";
          indicator = "#ff4d00";
          text = "#000000";
        };
        unfocused = {
          border = "#595959";
          childBorder = "#595959";
          background = "#595959";
          indicator = "#595959";
          text = "#ffffff";
        };
        urgent = {
          border = "#ff0000";
          childBorder = "#ff0000";
          background = "#ff0000";
          indicator = "#ff0000";
          text = "#000000";
        };
      };
      gaps = {
        inner = 3;
        outer = 3;
        top = 0;
      };
      window = {
        border = 1;
        titlebar = false;
      };
    };
  };
}
