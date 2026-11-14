_: {
  flake.nixosModules.desktop = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.desktop.bars;
  in {
    options.forgeOS.desktop.bars.enable = lib.mkEnableOption "Noctalia Bars";

    config = lib.mkIf cfg.enable {
      home-manager.sharedModules = [
        {
          programs.noctalia.settings.bar.widgets = {
            start = ["clock" "network"];
            center = ["workspaces" "privacy"];
            end = ["group:g1" "volume" "battery" "notifications"];
            background_opacity = 0.0;
            capsule = true;
            font_family = "JetBrains Mono";
            font_weight = 400;
            margin_ends = 3;
            padding = 0;
            capsule_group = [
              {
                id = "g1";
                enabled = true;
                accordion = false;
                accordion_direction = "end";
                fill = "surface_container";
                members = ["cpu" "temp" "ram" "sysmon"];
                opacity = 1.0;
                padding = 6.0;
                widget_spacing = 10;
              }
            ];
          };
        }
      ];
    };
  };
}
