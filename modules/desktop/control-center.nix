_: {
  flake.nixosModules.desktop = _: {
    home-manager.sharedModules = [
      {
        wayland.windowManager.sway.config.keybindings = let
          noctaliaShell = "noctalia-shell ipc call";
        in {
          "Mod4+XF86NotificationCenter" = "exec ${noctaliaShell} controlCenter toggle";
        };

        programs.noctalia-shell.settings = {
          calendar.cards = [
            {
              enabled = true;
              id = "calendar-header-card";
            }
            {
              enabled = true;
              id = "calendar-month-card";
            }
            {
              enabled = false;
              id = "weather-card";
            }
          ];
          controlCenter = {
            cards = [
              {
                enabled = true;
                id = "profile-card";
              }
              {
                enabled = true;
                id = "shortcuts-card";
              }
              {
                enabled = true;
                id = "audio-card";
              }
              {
                enabled = true;
                id = "brightness-card";
              }
              {
                enabled = false;
                id = "weather-card";
              }
              {
                enabled = false;
                id = "media-sysmon-card";
              }
            ];
            diskPath = "/";
            position = "close_to_bar_button";
            shortcuts = {
              left = [
                {id = "Network";}
                {id = "Bluetooth";}
                {id = "WallpaperSelector";}
                {id = "NoctaliaPerformance";}
              ];
              right = [
                {id = "Notifications";}
                {id = "PowerProfile";}
                {id = "KeepAwake";}
                {id = "NightLight";}
              ];
            };
          };
          location = {
            analogClockInCalendar = true;
            autoLocate = false;
            firstDayOfWeek = 0;
            showCalendarEvents = true;
            showCalendarWeather = false;
            showWeekNumberInCalendar = true;
            use12hourFormat = false;
            weatherEnabled = false;
          };
        };
      }
    ];
  };
}
