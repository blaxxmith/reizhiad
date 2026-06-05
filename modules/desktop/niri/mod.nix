{inputs, ...}: {
  flake.nixosModules.desktop = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.desktop.niri;
  in {
    options.forgeOS.desktop.niri = {
      enable = lib.mkEnableOption "Niri - Wayland System Tray";
    };

    config = lib.mkIf cfg.enable {
      nixpkgs.overlays = [inputs.niri.overlays.niri];

      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
        # TODO: Use Yazi instead
        useNautilus = true;
      };

      home-manager.sharedModules = [
        inputs.niri.homeModules.niri
        {
          programs.niri = {
            enable = true;
            package = pkgs.niri-unstable;
            settings = {
              prefer-no-csd = true;
              hotkey-overlay.skip-at-startup = true;

              spawn-at-startup = [{argv = ["noctalia-shell"];}];

              layout = {
                gaps = 3;

                border.enable = false;
                focus-ring = {
                  enable = true;
                  width = 1;
                  active.color = "#83C092";
                  inactive.color = "#7A8478";
                  urgent.color = "#E67E80";
                };

                tab-indicator = {
                  gap = 3;
                  width = 2;
                  position = "top";
                  hide-when-single-tab = true;
                  gaps-between-tabs = 3;
                };

                always-center-single-column = false;
                center-focused-column = "never"; # "on-overflow";
                default-column-width.proportion = 0.5;
                preset-column-widths = [
                  {proportion = 0.25;}
                  {proportion = 0.5;}
                  {proportion = 1.0;}
                ];
              };

              animations = {
                workspace-switch.enable = false;
              };

              cursor.size = 8;

              input = {
                keyboard.xkb = {
                  layout = "us";
                  options = "caps:escape";
                };
                touchpad.natural-scroll = true;
                focus-follows-mouse.enable = true;
              };

              outputs = {
                "eDP-1" = {
                  enable = true;
                  variable-refresh-rate = true; # "on-demand"
                  mode = {
                    width = 2880;
                    height = 1800;
                    refresh = 120.000;
                  };
                  position = {
                    x = 1670;
                    y = 1940;
                  };
                  scale = 1.4;
                  focus-at-startup = true;
                };
                "DP-8" = {
                  enable = true;
                  mode = {
                    width = 2560;
                    height = 1440;
                    refresh = 60.000;
                  };
                  position = {
                    x = 1440;
                    y = 500;
                  };
                  scale = 1.5;
                  focus-at-startup = false;
                };
                "DP-9" = {
                  enable = true;
                  mode = {
                    width = 2560;
                    height = 1440;
                    refresh = 60.000;
                  };
                  position = {
                    x = 0;
                    y = 0;
                  };
                  scale = 1.5;
                  transform.rotation = 90;
                  focus-at-startup = false;
                };
              };

              gestures.hot-corners.enable = false;
            };
          };
        }
      ];
    };
  };
}
