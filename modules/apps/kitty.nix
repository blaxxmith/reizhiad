_: {
  flake.homeModules.apps = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.apps.kitty;
  in {
    options.forgeOS.apps.kitty.enable = lib.mkEnableOption "Kitty Terminal";

    config = lib.mkIf cfg.enable {
      programs.kitty = {
        enable = true;
        enableGitIntegration = true;
        shellIntegration = {
          enableZshIntegration = true;
          mode = "no-cursor";
        };
        font = {
          name = "Hack Nerd Font";
          size = 24;
        };
        settings = {
          cursor_shape = "underline";
          cursor_blink_interval = -1;
          cursor_underline_thickness = 1.0;
          enable_audio_bell = false;
          modify_font = "cell_height 105%";
          foreground = "#d8d8d8";
          background = "#181818";
          background_opacity = 1; # 0.91
          color0 = "#181818";
          color1 = "#ac4242";
          color2 = "#90a959";
          color3 = "#f4bf75";
          color4 = "#6a9fb5";
          color5 = "#aa759f";
          color6 = "#75b5aa";
          color7 = "#d8d8d8";
          color8 = "#6b6b6b";
          color9 = "#c55555";
          color10 = "#aac474";
          color11 = "#feca88";
          color12 = "#82b8c8";
          color13 = "#c28cb8";
          color14 = "#93d3c3";
          color15 = "#f8f8f8";
        };
      };
    };
  };
}
