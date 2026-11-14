_: {
  flake.nixosModules.desktop = _: {
    home-manager.sharedModules = [
      {
        programs.noctalia.settings.widget = {
          active_window.title_scroll = "on_hover";
          cpu.visualization = "none";
          network = {
            show_vpn_label = true;
            vpn_status = "both";
          };
          notifications.hide_when_no_unread = true;
          privacy = {
            active_color = "error";
            hide_inactive = true;
          };
          ram.visualization = "none";
          sysmon = {
            stat = "disk_free";
            visualization = "none";
          };
          taskbar.only_active_workspace = true;
          temp.visualization = "none";
          workspaces = {
            anchor = true;
            hide_when_empty = true;
            label_source = "name";
            max_label_chars = 6;
            style = "focus_hint";
          };
        };
      }
    ];
  };
}
