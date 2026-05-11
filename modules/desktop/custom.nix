_: {
  flake.nixosModules.desktop = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.desktop;
    enabledProfiles = lib.filterAttrs (_: profile: profile.enable) config.forgeOS.profiles;
  in {
    options.forgeOS.desktop.primaryScreen = {
      mode = lib.mkOption {
        type = lib.types.str;
        description = "Primary screen mode to use";
        example = "1920x1080@60.000Hz";
      };
      scale = lib.mkOption {
        type = lib.types.str;
        description = "Primary screen scale to use";
        default = "1.00";
        example = "1.50";
      };
      position = lib.mkOption {
        type = lib.types.str;
        description = "Primary screen position to use";
        default = "0,0";
        example = "1111,2222";
      };
    };

    config.home-manager.users = lib.mapAttrs' (_: profile:
      lib.nameValuePair profile.user {
        wayland.windowManager.sway.config = {
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
          startup = [
            {
              command = "swaymsg output '*' bg /home/${profile.user}/.assets/wallpaper.png fill";
              always = true;
            }
          ];
        };

        programs.noctalia-shell.settings.wallpaper.enabled = false;
        programs.niri.settings.spawn-at-startup = [
          {argv = ["${pkgs.swaybg}/bin/swaybg" "-i" "/home/${profile.user}/.assets/wallpaper.png" "-m" "fill"];}
        ];
      })
    enabledProfiles;
  };
}
