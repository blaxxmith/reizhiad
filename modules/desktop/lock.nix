_: {
  flake.nixosModules.desktop = {
    config,
    lib,
    pkgs,
    ...
  }: let
    enabledProfiles = lib.filterAttrs (_: profile: profile.enable) config.forgeOS.profiles;
    lockCommand = "${pkgs.swaylock}/bin/swaylock";
  in {
    home-manager.users =
      lib.mapAttrs' (
        _: profile:
          lib.nameValuePair profile.user {
            wayland.windowManager.sway.config.keybindings = {
              "Mod4+Escape" = "exec ${lockCommand}";
            };

            programs.swaylock = {
              enable = true;
              settings = {
                image = "/home/${profile.user}/.assets/wallpaper.png";
                indicator-idle-visible = true;
                ignore-empty-password = true;
                daemonize = true;
              };
            };

            programs.noctalia-shell.settings.idle.enabled = false;

            services.swayidle = {
              enable = true;
              events = {
                lock = lockCommand;
                before-sleep = lockCommand;
              };
              timeouts = [
                {
                  timeout = 600;
                  command = lockCommand;
                }
                {
                  timeout = 1200;
                  command = "systemctl suspend";
                }
              ];
            };
          }
      )
      enabledProfiles;
  };
}
