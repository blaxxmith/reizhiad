{inputs, ...}: {
  flake.nixosModules.desktop = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.noctalia.packages."${pkgs.stdenv.hostPlatform.system}".default
    ];

    home-manager.sharedModules = [
      inputs.noctalia.homeModules.default
      {
        programs.noctalia = {
          enable = true;
          systemd.enable = true;
          settings = {
            battery.warning_threshold = 20;
            idle.pre_action_fade_seconds = 5;

            dock = {
              enabled = false;
              active_monitor_only = true;
              background_opacity = 0.4;
              launcher_position = "start";
              magnification_scale = 1.75;
              position = "left";
              show_dots = true;
              smart_auto_hide = true;
            };

            desktop_widgets.enabled = false;

            plugins.source = [
              {
                enabled = false;
                kind = "git";
                name = "official";
              }
              {
                enabled = false;
                kind = "git";
                name = "community";
              }
            ];

            shell = {
              font_family = "JetBrains Mono";
              launch_apps_as_systemd_services = true;
              offline_mode = true;
              panel_anchor_bar = "widgets";
              password_style = "random";
              polkit_agent = true;
              screen_time_enabled = true;
              settings_window_translucent = true;
              screenshot.directory = "/home/pex/Pictures/Screenshots";
            };
          };
        };
      }
    ];
  };
}
