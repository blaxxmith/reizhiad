_: {
  flake.nixosModules.desktop = _: {
    home-manager.sharedModules = [
      {
        programs.noctalia.settings.shell.session = let
          action = shortcut: name: extra:
            {
              action = name;
              countdown_seconds = 0.0;
              enabled = true;
              shortcut = toString shortcut;
              variant = "default";
            }
            // extra;
        in {
          grid = true;
          actions = [
            (action 1 "lock" {command = "swaylock";})
            (action 2 "logout" {})
            (action 3 "lock_and_suspend" {})
            (action 4 "reboot" {})
            (action 5 "shutdown" {variant = "destructive";})
          ];
        };
      }
    ];
  };
}
