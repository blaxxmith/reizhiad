_: {
  flake.nixosModules.desktop = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.desktop.theme;
  in {
    options.forgeOS.desktop.theme = {
      enable = lib.mkEnableOption "Theme Configuration";
      wallpaper = lib.mkOption {
        type = lib.types.path;
        default = ../../.assets/wallpaper.png;
        description = "Path to the wallpaper image.";
      };
    };

    config.home-manager.sharedModules = lib.mkIf cfg.enable [
      {
        home.file = {
          ".config/gtk-4.0/settings.ini".text = ''
            [Settings]
            gtk-application-prefer-dark-theme=1
          '';
          ".config/gtk-3.0/settings.ini".text = ''
            [Settings]
            gtk-application-prefer-dark-theme=1
          '';

          ".assets/wallpaper.png".source = cfg.wallpaper;
        };

        programs.noctalia-shell = {
          colors = {
            mPrimary = "#A7C080";
            mOnPrimary = "#232A2E";
            mSecondary = "#D3C6AA";
            mOnSecondary = "#232A2E";
            mTertiary = "#9DA9A0";
            mOnTertiary = "#232A2E";
            mError = "#E67E80";
            mOnError = "#232A2E";
            mSurface = "#232A2E";
            mOnSurface = "#859289";
            mSurfaceVariant = "#2D353B";
            mOnSurfaceVariant = "#D3C6AA";
            mOutline = "#7A8478";
            mShadow = "#475258";
            mHover = "#A7C080";
            mOnHover = "#232A2E";
          };
          settings.ui = {
            fontDefault = "Hack Nerd Font";
            fontDefaultScale = 0.85;
            tooltipsEnabled = true;
            scrollbarAlwaysVisible = false;
            boxBorderEnabled = false;
            panelBackgroundOpacity = 0.93;
            panelsAttachedToBar = false;
            settingsPanelMode = "centered";
            settingsPanelSideBarCardStyle = true;
          };
        };

        wayland.windowManager.sway.config = {
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
      }
    ];
  };
}
