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
                  active.color = "#83C092"; #"#ff4d00";
                  inactive.color = "#7A8478"; #"#595959";
                  urgent.color = "#E67E80"; #"#ff0000";
                };

                tab-indicator = {
                  gap = 3;
                  width = 2;
                  position = "top";
                  hide-when-single-tab = true;
                  gaps-between-tabs = 3;
                };

                always-center-single-column = false;
                center-focused-column = "on-overflow";
                default-column-width.proportion = 0.5;
                preset-column-widths = [
                  {proportion = 0.25;}
                  {proportion = 0.5;}
                  {proportion = 1.0;}
                ];
              };

              environment = {
                DISPLAY = null;
              };

              cursor.size = 8;

              input = {
                keyboard.xkb = {
                  layout = "us";
                  options = "caps:escape";
                };
                touchpad.natural-scroll = true;
              };

              outputs = {
                "eDP-1" = {
                  enable = true;
                  mode = {
                    width = 1920;
                    height = 1200;
                    refresh = 60.002;
                  };
                  position = {
                    x = 0;
                    y = 0;
                  };
                  scale = 1;
                  focus-at-startup = true;
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
