_: {
  flake.nixosModules.desktop = _: {
    home-manager.sharedModules = [
      {
        programs.niri.settings = {
          workspaces = {
            "01/TRM" = {};
            "02/BWR" = {};
            "03" = {};
            "04" = {};
            "05" = {};
            "06" = {};
            "07" = {};
            "08" = {};
            "09/PUB" = {};
            "10/SYS" = {};
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
