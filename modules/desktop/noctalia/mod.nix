{inputs, ...}: {
  flake.nixosModules.desktop = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.noctalia.packages."${pkgs.stdenv.hostPlatform.system}".default
    ];

    home-manager.sharedModules = [
      inputs.noctalia.homeModules.default
      {
        wayland.windowManager.sway.config.startup = [
          {
            command = "noctalia-shell";
            always = true;
          }
          {
            command = "systemctl --user start xdg-desktop-portal-wlr.service";
            always = true;
          }
        ];

        programs.noctalia-shell = {
          enable = true;
          settings = {
            dock.enabled = false;
            desktopWidgets.enabled = false;
            hooks.enabled = false;
            general = {
              dimmerOpacity = 0;
              showScreenCorners = false;
              forceBlackScreenCorners = false;
              scaleRatio = 1;
              radiusRatio = 1;
              iRadiusRatio = 1;
              boxRadiusRatio = 1;
              screenRadiusRatio = 1;
              animationSpeed = 1;
              animationDisabled = true;
              enableShadows = false;
              enableBlurBehind = false;
              shadowDirection = "bottom_right";
              shadowOffsetX = 2;
              shadowOffsetY = 3;
              language = "";
              allowPanelsOnScreenWithoutBar = true;
              showChangelogOnStartup = false;
              telemetryEnabled = false;
              keybinds = {
                keyUp = ["Up"];
                keyDown = ["Down"];
                keyLeft = ["Left"];
                keyRight = ["Right"];
                keyEnter = ["Return" "Enter"];
                keyEscape = ["Esc"];
                keyRemove = ["Del"];
              };
              reverseScroll = false;
              smoothScrollEnabled = true;
            };
          };
        };
      }
    ];
  };
}
