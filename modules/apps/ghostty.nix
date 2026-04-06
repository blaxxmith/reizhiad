_: {
  flake.homeModules.apps = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.apps.ghostty;
  in {
    options.forgeOS.apps.ghostty.enable = lib.mkEnableOption "Ghostty Terminal";

    config = lib.mkIf cfg.enable {
      programs.ghostty = {
        enable = true;
        enableZshIntegration = true;
        clearDefaultKeybinds = true;
        systemd.enable = true;
        settings = {
          font-family = "Hack Nerd Font";
          font-size = 9;
          theme = "alacritty";
          cursor-style = "underline";
          cursor-style-blink = true;
          window-padding-x = 3;
          window-padding-y = 3;
          window-decoration = "none";
          shell-integration-features = "no-cursor";
          keybind = [
            "ctrl+shift+v=paste_from_clipboard"
            "ctrl+shift+c=copy_to_clipboard"
          ];
        };
        themes = {
          alacritty = {
            background = "#181818";
            foreground = "#d8d8d8";
            background-opacity = 0.91;
            palette = [
              "0=#181818"
              "1=#ac4242"
              "2=#90a959"
              "3=#f4bf75"
              "4=#6a9fb5"
              "5=#aa759f"
              "6=#75b5aa"
              "7=#d8d8d8"
              "8=#6b6b6b"
              "9=#c55555"
              "10=#aac474"
              "11=#feca88"
              "12=#82b8c8"
              "13=#c28cb8"
              "14=#93d3c3"
              "15=#f8f8f8"
            ];
          };
        };
      };
    };
  };
}
