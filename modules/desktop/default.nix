_: {
  flake.homeModules.desktop = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.desktop;
  in {
    options.forgeOS.desktop = {
      enable = lib.mkEnableOption "Wayland Compositor";
      enableLock = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
        description = "Enable lock screen functionality";
      };
    };

    config = lib.mkIf cfg.enable {
      forgeOS.desktop = {
        bars.enable = lib.mkDefault cfg.enable;
        notifications.enable = lib.mkDefault cfg.enable;
        theme.enable = lib.mkDefault cfg.enable;
      };

      wayland.windowManager.sway = {
        enable = true;
        systemd.enable = true;
        wrapperFeatures.gtk = true;
        checkConfig = true;
        config = {
          defaultWorkspace = "workspace number 1";
          output = {
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

      programs = {
        swaylock.enable = cfg.enableLock;
        rofi = {
          enable = true;
          theme = "Monokai";
        };
      };

      home.packages = with pkgs; [
        brightnessctl
        wdisplays
        cliphist
        wl-clipboard
      ];
    };
  };
}
