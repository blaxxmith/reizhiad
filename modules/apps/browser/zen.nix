{inputs, ...}: {
  flake.homeModules.browser = {
    config,
    lib,
    ...
  }: let
    cfg = config.govelTY.browser;
  in {
    imports = [inputs.zen-browser.homeModules.beta];

    options.govelTY.browser.zen = {
      enable = lib.mkEnableOption "Zen Browser BETA";
      mods = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "List of Zen Browser mods to enable for all profiles.";
        default = [
          "e74cb40a-f3b8-445a-9826-1b1b6e41b846" # Custom UI Fonts
        ];
      };
    };

    config = lib.mkIf cfg.zen.enable {
      programs.zen-browser = {
        inherit (cfg.zen) enable;
        inherit (cfg) policies;
        setAsDefaultBrowser = true;
        profiles.default = {
          id = 0;
          isDefault = true;
          name = "Default";

          inherit (cfg.zen) mods;

          containersForce = true;
          inherit (cfg) containers search;

          settings =
            cfg.privacy
            // {
              "zen.tabs.show-newtab-vertical" = true;
              "zen.theme.accent-color" = "#8aadf4";
              "zen.urlbar.behavior" = "float";
              "zen.view.compact.enable-at-startup" = true;
              "zen.view.compact.hide-toolbar" = false;
              "zen.view.compact.toolbar-flash-popup" = true;
              "zen.view.show-newtab-button-top" = true;
              "zen.view.window.scheme" = 0;
              "zen.welcome-screen.seen" = true;
              "zen.workspaces.continue-where-left-off" = true;

              "browser.tabs.inTitlebar" = 0;
              "browser.toolbars.bookmarks.visibility" = "never";
              "sidebar.verticalTabs" = false;
              "sidebar.revamp" = false;
            };
        };
      };
    };
  };
}
