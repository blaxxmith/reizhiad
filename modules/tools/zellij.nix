_: {
  flake.homeModules.tools = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.tools.zellij;
  in {
    options.forgeOS.tools.zellij = {
      enable = lib.mkEnableOption "Zellij terminal multiplexer";
      remote = lib.mkEnableOption "Zellij server configuration (for remote usage)";
    };

    config = lib.mkIf cfg.enable {
      programs.zsh.shellAliases = {
        z = "zellij";
        zc = "zellij attach --create";
      };
      home.packages = lib.mkIf (!cfg.remote) [
        (pkgs.writeShellScriptBin "za" ''
          sessions=$(${pkgs.zellij}/bin/zellij ls | sed "s/\x1B\[[0-9;]*[mGK]//g" | awk '{print $1}')
          selected_session=$(echo "$sessions" | ${pkgs.skim}/bin/sk --reverse --height 5 --tac)
          if [ -n "$selected_session" ]; then
            if [ -n "$ZELLIJ_SESSION_NAME" ]; then
              ${pkgs.zellij}/bin/zellij delete-session "$ZELLIJ_SESSION_NAME" --force
            fi
            ${pkgs.zellij}/bin/zellij attach "$selected_session"
          fi
        '')
        (pkgs.writeShellScriptBin "zd" ''
          sessions=$(${pkgs.zellij}/bin/zellij ls | sed "s/\x1B\[[0-9;]*[mGK]//g" | awk '{print $1}')
          selected_session=$(echo "$sessions" | ${pkgs.skim}/bin/sk --reverse --height 5 --tac)
          if [ -n "$selected_session" ]; then
            ${pkgs.zellij}/bin/zellij delete-session "$selected_session" --force
          fi
        '')
      ];

      programs.zellij = {
        enable = true;
        enableZshIntegration = cfg.remote;
        package = pkgs.zellij;

        settings = lib.mkMerge [
          (lib.mkIf cfg.remote {
            session_name = "main";
            attach_to_session = true;
          })
          {
            pane_frames = false;
            theme = "night-owl";
            simplified_ui = true;
            default_layout = "compact";
            show_startup_tips = false;
            show_release_notes = false;
            mouse_mode = true;

            keybinds.normal = {
              "bind \"Ctrl 1\"".GoToTab._args = [1];
              "bind \"Ctrl 2\"".GoToTab._args = [2];
              "bind \"Ctrl 3\"".GoToTab._args = [3];
              "bind \"Ctrl 4\"".GoToTab._args = [4];
              "bind \"Ctrl 5\"".GoToTab._args = [5];
              "bind \"Ctrl 6\"".GoToTab._args = [6];
              "bind \"Ctrl 7\"".GoToTab._args = [7];
              "bind \"Ctrl 8\"".GoToTab._args = [8];
              "bind \"Ctrl 9\"".GoToTab._args = [9];
            };
          }
        ];
      };
    };
  };
}
