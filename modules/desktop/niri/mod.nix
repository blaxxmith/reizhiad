{inputs, ...}: {
  flake.nixosModules.desktop = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.desktop.niri;
    noctalia = ["noctalia-shell" "ipc" "call"];
  in {
    options.forgeOS.desktop.niri = {
      enable = lib.mkEnableOption "Niri - Wayland System Tray";
    };

    config = lib.mkIf cfg.enable {
      nixpkgs.overlays = [inputs.niri.overlays.niri];

      environment.systemPackages = with pkgs; [fuzzel];

      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
        useNautilus = false;
      };

      home-manager.sharedModules = [
        inputs.niri.homeModules.niri
        {
          programs.niri = {
            enable = true;
            package = pkgs.niri-unstable;
            settings = {
              prefer-no-csd = true;
              hotkey-overlay.skip-at-startup = true;

              spawn-at-startup = [
                {argv = ["noctalia-shell"];}
              ];

              workspaces = {
              };

              layout = {
                gaps = 3;

                border.enable = false;
                focus-ring = {
                  enable = true;
                  width = 1;
                  active.color = "#83C092"; #"#ff4d00";
                  inactive.color = "#7A8478"; #"#595959";
                  urgent.color = "#E67E80"; #"#ff0000";
                };

                tab-indicator = {
                  gap = 3;
                  width = 2;
                  position = "top";
                  hide-when-single-tab = true;
                  gaps-between-tabs = 3;
                };

                always-center-single-column = false;
                center-focused-column = "on-overflow";
                default-column-width.proportion = 0.5;
                preset-column-widths = [
                  {proportion = 0.25;}
                  {proportion = 0.5;}
                  {proportion = 1.0;}
                ];
              };

              environment = {
                DISPLAY = null;
              };

              cursor.size = 8;

              input = {
                keyboard.xkb = {
                  layout = "us";
                  options = "caps:escape";
                };
                touchpad.natural-scroll = true;
              };

              outputs = {
                "eDP-1" = {
                  enable = true;
                  mode = {
                    width = 1920;
                    height = 1200;
                    refresh = 60.002;
                  };
                  position = {
                    x = 0;
                    y = 0;
                  };
                  scale = 1;
                  focus-at-startup = true;
                };
              };

              gestures.hot-corners.enable = false;

              binds = {
                # "Mod+Shift+E".action.quit = [];
                "Mod+Return" = {
                  action.spawn = ["${pkgs.ghostty}/bin/ghostty" "+new-window"];
                  hotkey-overlay.title = "Launch Terminal";
                };
                "Alt+Space" = {
                  action.spawn = ["noctalia-shell" "ipc" "call" "launcher" "toggle"];
                  hotkey-overlay.title = "Toggle App Launcher";
                };
                "Mod+Escape" = {
                  action.spawn = ["swaylock" "-fk"];
                  hotkey-overlay.title = "Lock Screen";
                };
                "Mod+N" = {
                  action.spawn = ["${pkgs.ghostty}/bin/ghostty" "--font-size=12" "--command=yazi"];
                  hotkey-overlay.title = "Launch File Explorer";
                };

                # Focus Windows
                "Mod+Left".action.focus-column-left = [];
                "Mod+Down".action.focus-window-down = [];
                "Mod+Up".action.focus-window-up = [];
                "Mod+Right".action.focus-column-right = [];
                "Mod+H".action.focus-column-left = [];
                "Mod+J".action.focus-window-down = [];
                "Mod+K".action.focus-window-up = [];
                "Mod+L".action.focus-column-right = [];

                "Mod+Shift+Left".action.move-column-left = [];
                "Mod+Shift+Down".action.move-window-down = [];
                "Mod+Shift+Up".action.move-window-up = [];
                "Mod+Shift+Right".action.move-column-right = [];
                "Mod+Shift+H".action.move-column-left = [];
                "Mod+Shift+J".action.move-window-down = [];
                "Mod+Shift+K".action.move-window-up = [];
                "Mod+Shift+L".action.move-column-right = [];

                "Mod+O".action.toggle-overview = [];
                "Mod+Shift+Q".action.close-window = [];
                "Mod+W".action.toggle-column-tabbed-display = [];

                "Mod+Shift+P".action.power-off-monitors = [];
                "Mod+F".action.maximize-column = [];
                "Mod+Shift+F".action.fullscreen-window = [];
                "Mod+BracketLeft".action.consume-or-expel-window-left = [];
                "Mod+BracketRight".action.consume-or-expel-window-right = [];
                "Mod+Shift+Slash".action.show-hotkey-overlay = [];

                "Mod+1".action.focus-workspace = "01/TRM";
                "Mod+2".action.focus-workspace = "02/BWR";
                "Mod+3".action.focus-workspace = "03";
                "Mod+4".action.focus-workspace = "04";
                "Mod+5".action.focus-workspace = "05";
                "Mod+6".action.focus-workspace = "06";
                "Mod+7".action.focus-workspace = "07";
                "Mod+8".action.focus-workspace = "08";
                "Mod+9".action.focus-workspace = "09/PUB";
                "Mod+0".action.focus-workspace = "10/SYS";

                "Mod+Shift+1".action.move-column-to-workspace = "01/TRM";
                "Mod+Shift+2".action.move-column-to-workspace = "02/BWR";
                "Mod+Shift+3".action.move-column-to-workspace = "03";
                "Mod+Shift+4".action.move-column-to-workspace = "04";
                "Mod+Shift+5".action.move-column-to-workspace = "05";
                "Mod+Shift+6".action.move-column-to-workspace = "06";
                "Mod+Shift+7".action.move-column-to-workspace = "07";
                "Mod+Shift+8".action.move-column-to-workspace = "08";
                "Mod+Shift+9".action.move-column-to-workspace = "09/PUB";
                "Mod+Shift+0".action.move-column-to-workspace = "10/SYS";

                "Alt+Ctrl+V".action.spawn = noctalia ++ ["launcher" "clipboard"];
                "Mod+Shift+E".action.spawn = noctalia ++ ["sessionMenu" "toggle"];
                "Mod+XF86NotificationCenter".action.spawn = noctalia ++ ["controlCenter" "toggle"];

                # Audio
                "XF86AudioRaiseVolume".action.spawn = noctalia ++ ["volume" "increase"];
                "XF86AudioLowerVolume".action.spawn = noctalia ++ ["volume" "decrease"];
                "XF86AudioMute".action.spawn = noctalia ++ ["volume" "muteOutput"];
                "XF86AudioMicMute".action.spawn = noctalia ++ ["volume" "muteInput"];

                # Brightness
                "XF86MonBrightnessUp".action.spawn = noctalia ++ ["brightness" "increase"];
                "XF86MonBrightnessDown".action.spawn = noctalia ++ ["brightness" "decrease"];

                # Notifications
                "XF86NotificationCenter".action.spawn = noctalia ++ ["notifications" "toggleHistory"];
                "XF86HangupPhone".action.spawn = noctalia ++ ["notifications" "toggleDND"];
              };
            };
          };
        }
      ];
    };
  };
}
