_: {
  flake.nixosModules.desktop = {config, ...}: let
    cfg = config.forgeOS.desktop.primaryScreen;
  in {
    home-manager.sharedModules = [
      {
        programs.niri.settings.outputs = {
          "eDP-1" = {
            inherit (cfg) mode position scale;
            enable = true;
            variable-refresh-rate = true; # "on-demand"
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
      }
    ];
  };
}
