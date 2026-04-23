_: {
  flake.nixosModules.desktop = _: {
    home-manager.sharedModules = [
      {
        wayland.windowManager.sway.config.keybindings = {
          "Mod4+Escape" = "exec noctalia-shell ipc call lockScreen lock";
        };

        programs.noctalia-shell.settings = {
          idle = {
            enabled = true;
            fadeDuration = 5;
            lockTimeout = 600;
            screenOffTimeout = 720;
            suspendTimeout = 1200;
          };

          general = {
            compactLockScreen = true;
            lockScreenAnimations = true;
            enableLockScreenCountdown = true;
            lockScreenCountdownDuration = 10000;
            passwordChars = false;
            lockScreenMonitors = ["eDP-1"];
            lockScreenBlur = 0.5;
            lockScreenTint = 0;
            autoStartAuth = false;
            allowPasswordWithFprintd = false;
            clockStyle = "custom";
            clockFormat = "HH:mm ";
            lockOnSuspend = true;
            showSessionButtonsOnLockScreen = false;
            showHibernateOnLockScreen = false;
            enableLockScreenMediaControls = false;
          };
        };
      }
    ];
  };
}
