_: {
  flake.nixosModules.zen = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.apps.zen;
  in {
    options.forgeOS.apps.zen.personal = lib.mkEnableOption "Zen Browser BETA - Personal Profile";

    config.home-manager.sharedModules = [
      {
        programs.zen-browser.profiles.personal = lib.mkIf cfg.personal {
          id = 1;
          name = "Personal";

          bookmarks = {};

          inherit (config.forgeOS.apps.zen.common) mods;

          settings = {
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

            # # Disable irritating first-run stuff
            # "browser.disableResetPrompt" = true;
            # "browser.download.panel.shown" = true;
            # "browser.feeds.showFirstRunUI" = false;
            # "browser.messaging-system.whatsNewPanel.enabled" = false;
            # "browser.rights.3.shown" = true;
            # "browser.shell.checkDefaultBrowser" = false;
            # "browser.shell.defaultBrowserCheckCount" = 1;
            # "browser.startup.homepage_override.mstone" = "ignore";
            # "browser.uitour.enabled" = false;
            # "startup.homepage_override_url" = "";
            # "trailhead.firstrun.didSeeAboutWelcome" = true;
            # "browser.bookmarks.restore_default_bookmarks" = false;
            # "browser.bookmarks.addedImportButton" = true;
            # "browser.tabs.groups.smart.userEnabled" = false;
            # "browser.urlbar.suggest.trending" = false;
            # "extensions.formautofill.addresses.enabled" = false;
            # "extensions.formautofill.creditCards.enabled" = false;
            # "browser.download.useDownloadDir" = false;

            # "browser.newtabpage.activity-stream.feeds.topsites" = true;
            # "browser.newtabpage.activity-stream.feeds.topsitesRows" = 2;
            # "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            # "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
            # "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
            # "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
            # "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
            # "browser.newtabpage.blocked" = lib.genAttrs [
            #   "26UbzFJ7qT9/4DhodHKA1Q=="
            #   "4gPpjkxgZzXPVtuEoAL9Ig=="
            #   "eV8/WsSLxHadrTL1gAxhug=="
            #   "gLv0ja2RYVgxKdp0I5qwvA=="
            #   "K00ILysCaEq8+bEqV/3nuw=="
            #   "T9nJot5PurhJSy8n038xGA=="
            # ] (_: 1);

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
          };
        };
      }
    ];
  };
}
