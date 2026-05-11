_: {
  flake.nixosModules.desktop = {
    config,
    lib,
    pkgs,
    ...
  }: let
    enabledProfiles = lib.filterAttrs (_: profile: profile.enable) config.forgeOS.profiles;
    lockCommand = "${pkgs.swaylock}/bin/swaylock -fk";
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
              settings.image = "/home/${profile.user}/.assets/wallpaper.png";
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
                  timeout = 720;
                  command = "swaymsg 'output * dpms off'";
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
