_: {
  flake.nixosModules.desktop = _: {
    home-manager.sharedModules = [
      {
        wayland.windowManager.sway.config.keybindings = {
          "Mod4+Shift+e" = "exec noctalia-shell ipc call sessionMenu toggle";
        };

        programs.noctalia-shell.settings.sessionMenu = {
          countdownDuration = 5000;
          enableCountdown = true;
          largeButtonsLayout = "grid";
          largeButtonsStyle = true;
          position = "center";
          powerOptions = [
            {
              action = "lock";
              command = "";
              countdownEnabled = false;
              enabled = true;
              keybind = "L";
            }
            {
              action = "shutdown";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "P";
            }
            {
              action = "reboot";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "R";
            }
            {
              action = "suspend";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "S";
            }
            {
              action = "logout";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "E";
            }
            {
              action = "hibernate";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "H";
            }
            {
              action = "rebootToUefi";
              enabled = false;
            }
            {
              action = "userspaceReboot";
              enabled = false;
            }
          ];
          showHeader = true;
          showKeybinds = true;
        };
      }
    ];
  };
}
