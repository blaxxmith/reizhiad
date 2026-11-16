_: {
  flake.homeModules.browser = {
    config,
    lib,
    ...
  }: let
    cfg = config.govelTY.browser;
  in {
    options.govelTY.browser.firefox.enable = lib.mkEnableOption "Firefox Browser";

    config = lib.mkIf cfg.firefox.enable {
      programs.firefox = {
        enable = cfg.firefox.enable;
        configPath = ".config/firefox";
        profiles.default = {
          id = 0;
          isDefault = true;
          name = "Default";

          bookmarks = {};

          containersForce = true;
          inherit (cfg) search containers;

          settings =
            cfg.privacy
            // {
              "browser.startup.homepage" = "about:home";
              "browser.startup.page" = "3";

              # Disable irritating first-run stuff
              "browser.disableResetPrompt" = true;
              "browser.download.panel.shown" = true;
              "browser.feeds.showFirstRunUI" = false;
              "browser.messaging-system.whatsNewPanel.enabled" = false;
              "browser.rights.3.shown" = true;
              "browser.shell.checkDefaultBrowser" = false;
              "browser.shell.defaultBrowserCheckCount" = 1;
              "browser.startup.homepage_override.mstone" = "ignore";
              "browser.uitour.enabled" = false;
              "startup.homepage_override_url" = "";
              "trailhead.firstrun.didSeeAboutWelcome" = true;
              "browser.bookmarks.restore_default_bookmarks" = false;
              "browser.bookmarks.addedImportButton" = true;
              "browser.tabs.groups.smart.userEnabled" = false;
              "browser.urlbar.suggest.trending" = false;
              "extensions.formautofill.addresses.enabled" = false;
              "extensions.formautofill.creditCards.enabled" = false;
              "browser.download.useDownloadDir" = false;

              "browser.newtabpage.activity-stream.feeds.topsites" = true;
              "browser.newtabpage.activity-stream.feeds.topsitesRows" = 2;
              "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
              "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
              "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
              "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
              "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
              "browser.newtabpage.blocked" = lib.genAttrs [
                "26UbzFJ7qT9/4DhodHKA1Q=="
                "4gPpjkxgZzXPVtuEoAL9Ig=="
                "eV8/WsSLxHadrTL1gAxhug=="
                "gLv0ja2RYVgxKdp0I5qwvA=="
                "K00ILysCaEq8+bEqV/3nuw=="
                "T9nJot5PurhJSy8n038xGA=="
              ] (_: 1);
              # "browser.newtabpage.pinned" = builtins.toJSON [
              #   {
              #     url = "https://github.com";
              #     baseDomain = "github.com";
              #     label = "GitHub";
              #   }
              #   {
              #     url = "https://search.nixos.org";
              #     baseDomain = "search.nixos.org";
              #     label = "NixPkgs";
              #   }
              #   {
              #     url = "https://nix-community.github.io/home-manager/options.xhtml";
              #     label = "HM Index";
              #     baseDomain = "nix-community.github.io";
              #   }
              # ];

              "browser.tabs.inTitlebar" = 0;
              "browser.toolbars.bookmarks.visibility" = "never";
              "sidebar.verticalTabs" = false;
              "sidebar.revamp" = false;
              "browser.uiCustomization.state" = builtins.toJSON {
                placements = {
                  unified-extensions-area = [];
                  widget-overflow-fixed-list = ["edit-controls" "zoom-controls" "developer-button" "preferences-button"];
                  nav-bar = ["back-button" "forward-button" "stop-reload-button" "vertical-spacer" "urlbar-container" "downloads-button" "78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action" "vpn_proton_ch-browser-action" "unified-extensions-button"];
                  toolbar-menubar = ["menubar-items"];
                  TabsToolbar = ["screenshot-button" "tabbrowser-tabs"];
                  vertical-tabs = [];
                  PersonalToolbar = ["personal-bookmarks"];
                };
                # seen = ["save-to-pocket-button" "developer-button" "ublock0_raymondhill_net-browser-action" "_testpilot-containers-browser-action" "screenshot-button"];
                dirtyAreaCache = ["nav-bar" "PersonalToolbar" "toolbar-menubar" "TabsToolbar" "widget-overflow-fixed-list" "vertical-tabs"];
                currentVersion = 23;
                newElementCount = 10;
              };
            };
        };
      };
    };
  };
}
