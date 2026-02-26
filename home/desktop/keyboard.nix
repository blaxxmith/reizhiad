{
  config,
  pkgs,
  ...
}: let
  modifier = "Mod4";
  km = config.forgeOS.desktop.keymap;
in {
  wayland.windowManager.sway.extraConfig = ''
    bindgesture swipe:right workspace prev
    bindgesture swipe:left workspace next
  '';
  wayland.windowManager.sway.config = {
    modifier = modifier;

    input = {
      "type:keyboard" = {
        xkb_layout = "us";
        xkb_options = "caps:escape";
      };
      "type:touchpad" = {
        natural_scroll = "enabled";
      };
    };

    keybindings =
      {
        # General
        "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${modifier}+Shift+r" = "reload";
        "${modifier}+Escape" = "exec ${pkgs.swaylock}/bin/swaylock";
        "${modifier}+f" = "fullscreen toggle global";
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 10%-";
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 10%+";
        "Shift+XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl -d 'tpacpi::kbd_backlight' set 0";
        "Shift+XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl -d 'tpacpi::kbd_backlight' set 2";
        "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer --increase 5";
        "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer --decrease 5";
        "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer --toggle-mute";
        "${modifier}+v" = "exec ${pkgs.cliphist}/bin/cliphist list | ${pkgs.rofi}/bin/rofi -dmenu -display-columns 2 | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy";
        "${modifier}+r" = "mode resize";
        "${modifier}+Shift+e" = "mode menu";
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
          "${modifier}+space" = "exec ${pkgs.rofi}/bin/rofi -show drun -show-icons";
          "${modifier}+q" = "kill";
        }
        else {
          "Mod1+space" = "exec ${pkgs.rofi}/bin/rofi -show drun -show-icons";
          "${modifier}+Shift+q" = "kill";
        }
      );

    modes.menu = {
      "Escape" = "mode default";
      "Return" = "mode default";
      "${modifier}+Shift+e" = "mode default";

      "e" = "exit";
      "l" = "exec ${pkgs.swaylock}/bin/swaylock";
      "r" = "exec ${pkgs.systemd}/bin/systemctl reboot";
      "s" = "exec ${pkgs.systemd}/bin/systemctl poweroff";
      "h" = "exec ${pkgs.systemd}/bin/systemctl hibernate";
    };
  };
}
