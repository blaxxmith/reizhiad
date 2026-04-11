_: {
  flake.nixosModules.desktop = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.desktop;
  in {
    options.forgeOS.desktop.primaryScreen = {
      mode = lib.mkOption {
        type = lib.types.str;
        description = "Primary screen mode to use. do not edit directly";
        example = "1920x1080@60.000Hz";
      };
      scale = lib.mkOption {
        type = lib.types.str;
        description = "Primary screen scale to use. do not edit directly";
        default = "1.00";
        example = "1.50";
      };
      position = lib.mkOption {
        type = lib.types.str;
        description = "Primary screen position to use. do not edit directly";
        default = "0,0";
        example = "1111,2222";
      };
    };

    config.home-manager.users."${config.forgeOS.profile.user}" = {
      wayland.windowManager.sway.config.output = {
        "eDP-1" = with cfg.primaryScreen; {inherit mode scale position;};
        "DP-4" = {
          mode = "2560x1440@59.951Hz";
          position = "0,0";
          transform = "270";
        };
        "DP-3" = {
          mode = "2560x1440@59.951Hz";
          position = "1440,338";
        };
        "HDMI-A-1" = {
          mode = "2560x1440@59.951Hz";
          position = "4000,338";
        };
      };
    };
  };
}
