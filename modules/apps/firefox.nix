_: {
  flake.nixosModules.apps = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.apps.firefox;
  in {
    options.forgeOS.apps.firefox = {
      enable = lib.mkEnableOption "Enable Firefox Browser";
    };

    config.home-manager.users."${config.forgeOS.profile.user}" = lib.mkIf cfg.enable {
      programs.firefox = {
        enable = true;
        profiles.default = {
          id = 0;
          isDefault = true;
          name = "Default";

          bookmarks = {};

          containersForce = true;
          containers = {
            work = {
              name = "Work";
              color = "yellow";
              icon = "briefcase";
              id = 1;
            };
            school = {
              name = "School";
              color = "blue";
              icon = "vacation";
              id = 2;
            };
            forge = {
              name = "Forge";
              color = "green";
              icon = "tree";
              id = 3;
            };
            personal = {
              name = "Personal";
              color = "red";
              icon = "fingerprint";
              id = 4;
            };
          };

          # extensions = {
          #   packages = with pkgs.nur.repos.rycee.firefox-addons; [
          #     ublock-origin
          #     proton-vpn
          #     proton-pass
          #     privacy-badger
          #     foxyproxy
          #   ];
          # };

          settings = {
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
            "browser.newtabpage.pinned" = builtins.toJSON [
              {
                url = "https://github.com";
                baseDomain = "github.com";
                label = "GitHub";
              }
              {
                url = "https://search.nixos.org";
                baseDomain = "search.nixos.org";
                label = "NixPkgs";
              }
              {
                url = "https://nix-community.github.io/home-manager/options.xhtml";
                label = "HM Index";
                baseDomain = "nix-community.github.io";
              }
            ];

            # Disable some telemetry
            "app.shield.optoutstudies.enabled" = false;
            "browser.discovery.enabled" = false;
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.newtabpage.activity-stream.telemetry" = false;
            "browser.ping-centre.telemetry" = false;
            "datareporting.healthreport.service.enabled" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;
            "datareporting.sessions.current.clean" = true;
            "devtools.onboarding.telemetry.logged" = false;
            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.bhrPing.enabled" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.firstShutdownPing.enabled" = false;
            "toolkit.telemetry.hybridContent.enabled" = false;
            "toolkit.telemetry.newProfilePing.enabled" = false;
            "toolkit.telemetry.prompted" = 2;
            "toolkit.telemetry.rejected" = true;
            "toolkit.telemetry.reportingpolicy.firstRun" = false;
            "toolkit.telemetry.server" = "";
            "toolkit.telemetry.shutdownPingSender.enabled" = false;
            "toolkit.telemetry.unified" = false;
            "toolkit.telemetry.unifiedIsOptIn" = false;
            "toolkit.telemetry.updatePing.enabled" = false;

            "identity.fxaccounts.enabled" = false;
            "signon.rememberSignons" = false;
            "privacy.trackingprotection.enabled" = true;
            "dom.security.https_only_mode" = true;
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
