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

              gestures.hot-corners.enable = false;
            };
          };
        }
      ];
    };
  };
}
