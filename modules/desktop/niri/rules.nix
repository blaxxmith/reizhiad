_: {
  flake.nixosModules.desktop = _: {
    home-manager.sharedModules = [
      {
        programs.niri.settings = {
          workspaces = {
            "01/TRM".open-on-output = "DP-8";
            "02/BWR".open-on-output = "DP-9";
            "03".open-on-output = "DP-8";
            "04".open-on-output = "DP-9";
            "05" = {};
            "06" = {};
            "07" = {};
            "08" = {};
            "09/PUB" = {};
            "10/SYS".open-on-output = "eDP-1";
          };

          window-rules = [
            {
              # Do not display backgounds on windows. Fix Ghostty
              draw-border-with-background = false;
            }
            {
              matches = [{is-window-cast-target = true;}];
              border = {
                enable = true;
                width = 2;
                active.color = "#e69875";
                inactive.color = "#493b40";
              };
              shadow = {
                enable = true;
                color = "#493B4070";
              };
            }
          ];
        };
      }
    ];
  };
}
