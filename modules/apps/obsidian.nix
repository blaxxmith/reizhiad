_: {
  flake.nixosModules.apps = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.apps.obsidian;
  in {
    options.forgeOS.apps.obsidian.enable = lib.mkEnableOption "Obsidian for note-taking and knowledge management";

    config = lib.mkIf cfg.enable {
      environment.systemPackages = [pkgs.obsidian];

      home-manager.sharedModules = [
        {
          programs.obsidian = {
            enable = true;
            cli.enable = true;
            defaultSettings = {
              app = {
                showLineNumber = false;
                livePreview = false;
                alwaysUpdateLinks = true;
                newLinkFormat = "absolute";
                promptDelete = false;
                trashOption = "local";
                newFileLocation = "current";
                attachmentFolderPath = "assets";
                spellcheck = true;
                vimMode = true;
                showInlineTitle = false;
                pdfExportSettings = {
                  pageSize = "A4";
                  landscape = false;
                  margin = "0";
                  downscalePercent = 100;
                };
                userIgnoreFilters = null;
                showUnsupportedFiles = true;
                showFrontmatter = false;
                propertiesInDocument = "visible";
              };
              appearance = {
                accentColor = "#ec3737";
                baseFontSize = 12;
                nativeMenus = false;
                theme = "system";
                showViewHeader = true;
                showRibbon = true;
                cssTheme = "";
              };

              corePlugins = [
                {audio-recorder.enable = false;}
                {bases.enable = false;}
                {bookmark.enable = true;}
                {canvas.enable = true;}
                {command-palette.enable = true;}
                {daily-notes.enable = false;}
                {editor-status.enable = true;}
                {file-explorer.enable = true;}
                {file-recovery.enable = true;}
                {footnotes.enable = true;}
                {global-search.enable = true;}
                {graph.enable = true;}
                {markdown-import.enable = false;}
                {note-composer.enable = true;}
                {outgoing-link.enable = true;}
                {outline.enable = true;}
                {page-preview.enable = true;}
                {properties.enable = true;}
                {publish.enable = false;}
                {random-note.enable = false;}
                {slash-command.enable = false;}
                {slides.enable = true;}
                {switcher.enable = true;}
                {sync.enable = false;}
                {tag-pane.enable = true;}
                {templates.enable = true;}
                {webviewer.enable = false;}
                {word-count.enable = true;}
                {workspace.enable = false;}
                {zk-prefixer.enable = false;}
              ];

              hotkeys = {
                "app:go-forward" = [
                  {
                    modifiers = ["Mod"];
                    key = "]";
                  }
                ];
                "app:go-back" = [
                  {
                    modifiers = ["Mod"];
                    key = "[";
                  }
                ];
                "command-palette:open" = [
                  {
                    modifiers = ["Mod" "Shift"];
                    key = "P";
                  }
                ];
                "workspace:export-pdf" = [
                  {
                    modifiers = ["Mod"];
                    key = "P";
                  }
                ];
                "graph:open-local" = [
                  {
                    modifiers = ["Mod" "Shift"];
                    key = "G";
                  }
                ];
                "app:delete-file" = [
                  {
                    modifiers = ["Mod" "Shift"];
                    key = "Backspace";
                  }
                ];
                "window:zoom-in" = [
                  {
                    modifiers = ["Mod"];
                    key = "=";
                  }
                ];
                "window:zoom-out" = [
                  {
                    modifiers = ["Mod"];
                    key = "-";
                  }
                ];
                "editor:toggle-source" = [
                  {
                    modifiers = ["Mod"];
                    key = "R";
                  }
                ];
                "file-explorer:move-file" = [
                  {
                    modifiers = ["Mod" "Shift"];
                    key = "M";
                  }
                ];
                "app:reload" = [
                  {
                    modifiers = ["Mod" "Shift"];
                    key = "R";
                  }
                ];
              };
            };
          };
        }
      ];
    };
  };
}
