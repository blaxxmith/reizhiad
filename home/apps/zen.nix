{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.forgeOS.apps.zen;
in {
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  options.forgeOS.apps.zen = {
    enable = lib.mkEnableOption "Zen Browser BETA";
  };

  config.programs.zen-browser = {
    enable = cfg.enable;
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
    profiles.default = {
      id = 0;
      isDefault = true;
      name = "Default";

      bookmarks = {};

      mods = [
        "e74cb40a-f3b8-445a-9826-1b1b6e41b846" # Custom UI Fonts
      ];

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

      spacesForce = true;
      spaces = let
        containers = config.programs.zen-browser.profiles.default.containers;
      in {
        main = {
          id = "e7ffa4fd-5357-4790-a1a9-06ed3b79b75e";
          position = 1000;
        };
        pro = {
          id = "96c336b5-dbfd-41ef-b69b-85f281478bc9";
          container = containers.work.id;
          position = 2000;
        };
        sanctuaris = {
          id = "b559bf10-2d78-4e7b-99aa-82831a6487b9";
          container = containers.work.id;
          position = 3000;
        };
        perso = {
          id = "be5b02d2-a0c7-4221-ba79-32f7141962c1";
          container = containers.personal.id;
          position = 4000;
        };
        forge = {
          id = "900dbc0e-fead-4b3a-bebe-2c106f35c2a6";
          container = containers.forge.id;
          position = 5000;
        };
        school = {
          id = "11cc5917-29a9-41a3-b633-871e06401705";
          container = containers.school.id;
          position = 6000;
        };
      };

      search = {
        force = true;
        default = "google";
        privateDefault = "ddg";
        engines = let
          nixSnowflakeIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        in {
          "NixOS Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = nixSnowflakeIcon;
            definedAliases = ["pkgs"];
          };
          "NixOS Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = nixSnowflakeIcon;
            definedAliases = ["nop"];
          };
          "Home Manager Options" = {
            urls = [
              {
                template = "https://home-manager-options.extranix.com/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                  {
                    name = "release";
                    value = "master"; # unstable
                  }
                ];
              }
            ];
            icon = nixSnowflakeIcon;
            definedAliases = ["hm"];
          };
          "StartPage" = {
            urls = [
              {
                template = "https://www.startpage.com/sp/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["startpage" "sp" "pp"];
            icon = "https://www.startpage.com/sp/cdn/favicons/favicon-gradient.ico";
            updateInterval = 24 * 60 * 60 * 1000;
          };
        };
      };

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
        # "browser.startup.homepage" = "about:home";
        # "browser.startup.page" = "3";

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
  };
}
