_: {
  flake.nixosModules.desktop = {
    config,
    lib,
    pkgs,
    ...
  }: let
    enabledProfiles = lib.filterAttrs (_: profile: profile.enable) config.forgeOS.profiles;
  in {
    options.forgeOS.desktop.primaryScreen = {
      mode = {
        width = lib.mkOption {
          type = lib.types.number;
          description = "Primary screen mode to use (Width)";
          example = 1920;
        };
        height = lib.mkOption {
          type = lib.types.number;
          description = "Primary screen mode to use (Height)";
          example = 1080;
        };
        refresh = lib.mkOption {
          type = lib.types.number;
          description = "Primary screen mode to use (Refresh Rate)";
          example = 60.000;
        };
      };
      scale = lib.mkOption {
        type = lib.types.number;
        description = "Primary screen scale to use";
        default = 1.00;
        example = 1.50;
      };
      position = {
        x = lib.mkOption {
          type = lib.types.number;
          description = "Primary screen position to use (X)";
          default = 0;
          example = 1111;
        };
        y = lib.mkOption {
          type = lib.types.number;
          description = "Primary screen position to use (Y)";
          default = 0;
          example = 2222;
        };
      };
    };

    config.home-manager.users = lib.mapAttrs' (_: profile:
      lib.nameValuePair profile.user {
        programs.noctalia.settings.wallpaper.enabled = false;
        programs.niri.settings.spawn-at-startup = [
          {argv = ["${pkgs.swaybg}/bin/swaybg" "-i" "/home/${profile.user}/.assets/wallpaper.png" "-m" "fill"];}
        ];
      })
    enabledProfiles;
  };
}
