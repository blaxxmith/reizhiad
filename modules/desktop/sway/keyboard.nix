_: {
  flake.nixosModules.desktop = {
    config,
    pkgs,
    lib,
    ...
  }: let
    modifier = "Mod4";
    km = config.forgeOS.desktop.keymap;
  in {
    options.forgeOS.desktop.keymap = lib.mkOption {
      type = lib.types.enum ["thinkpad" "mac"];
      description = "Keymap to use.";
      default = "thinkpad";
    };

    config.home-manager.sharedModules = [
      {
        wayland.windowManager.sway = {
          extraConfig = ''
            bindgesture swipe:right workspace prev
            bindgesture swipe:left workspace next
          '';

          config = {
            inherit modifier;

            input = {
              "type:keyboard" = {
                xkb_layout = "us";
                xkb_options = "caps:escape";
              };
              "type:touchpad".natural_scroll = "enabled";
            };

            keybindings =
              {
                "${modifier}+Return" = "exec ${pkgs.ghostty}/bin/ghostty +new-window";
                "${modifier}+Shift+r" = "reload";
                "${modifier}+f" = "fullscreen toggle";
                "${modifier}+n" = "exec ${pkgs.ghostty}/bin/ghostty --font-size=12 --command=yazi";
                # Focus next window
                "${modifier}+l" = "focus right";
                "${modifier}+h" = "focus left";
                "${modifier}+j" = "focus down";
                "${modifier}+k" = "focus up";
                "${modifier}+Right" = "focus right";
                "${modifier}+Left" = "focus left";
                "${modifier}+Down" = "focus down";
                "${modifier}+Up" = "focus up";
                # Swap windows
                "${modifier}+Shift+l" = "move right";
                "${modifier}+Shift+h" = "move left";
                "${modifier}+Shift+j" = "move down";
                "${modifier}+Shift+k" = "move up";
                "${modifier}+Shift+Right" = "move right";
                "${modifier}+Shift+Left" = "move left";
                "${modifier}+Shift+Down" = "move down";
                "${modifier}+Shift+Up" = "move up";
                # Focus the selected workspace
                "${modifier}+1" = "workspace number 1";
                "${modifier}+2" = "workspace number 2";
                "${modifier}+3" = "workspace number 3";
                "${modifier}+4" = "workspace number 4";
                "${modifier}+5" = "workspace number 5";
                "${modifier}+6" = "workspace number 6";
                "${modifier}+7" = "workspace number 7";
                "${modifier}+8" = "workspace number 8";
                "${modifier}+9" = "workspace number 9";
                "${modifier}+0" = "workspace number 10";
                # Move container to selected workspace
                "${modifier}+Shift+1" = "move container to workspace number 1";
                "${modifier}+Shift+2" = "move container to workspace number 2";
                "${modifier}+Shift+3" = "move container to workspace number 3";
                "${modifier}+Shift+4" = "move container to workspace number 4";
                "${modifier}+Shift+5" = "move container to workspace number 5";
                "${modifier}+Shift+6" = "move container to workspace number 6";
                "${modifier}+Shift+7" = "move container to workspace number 7";
                "${modifier}+Shift+8" = "move container to workspace number 8";
                "${modifier}+Shift+9" = "move container to workspace number 9";
                "${modifier}+Shift+0" = "move container to workspace number 10";
              }
              // (
                if (km == "mac")
                then {
                  "${modifier}+q" = "kill";
                }
                else {
                  "${modifier}+Shift+q" = "kill";
                }
              );
          };
        };
      }
    ];
  };
}
