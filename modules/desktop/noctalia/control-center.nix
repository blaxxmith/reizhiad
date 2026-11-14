_: {
  flake.nixosModules.desktop = _: {
    home-manager.sharedModules = [
      {
        programs.noctalia.settings = {
          control_center = {
            hidden_tabs = ["media" "weather" "calendar"];
            sidebar_section = "none";
          };
          shell.panel = {
            control_center_position = "top_center";
            open_near_click_control_center = true;
            transparency_mode = "soft";
          };
          location.auto_locate = false;
        };
      }
    ];
  };
}
