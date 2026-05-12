_: {
  flake.nixosModules.desktop = _: {
    home-manager.sharedModules = [
      {
        wayland.windowManager.sway.config.keybindings = let
          noctaliaShell = "noctalia-shell ipc call";
        in {
          "Mod1+space" = "exec ${noctaliaShell} launcher toggle";
          "Mod1+Control+v" = "exec ${noctaliaShell} launcher clipboard";
        };

        programs.noctalia-shell.settings.appLauncher = {
          autoPasteClipboard = false;
          clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
          clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
          clipboardWrapText = true;
          customLaunchPrefix = "";
          customLaunchPrefixEnabled = false;
          density = "compact";
          enableClipPreview = true;
          enableClipboardChips = true;
          enableClipboardHistory = true;
          enableClipboardSmartIcons = true;
          enableSessionSearch = true;
          enableSettingsSearch = true;
          enableWindowsSearch = true;
          iconMode = "tabler";
          ignoreMouseInput = false;
          overviewLayer = false;
          position = "center";
          screenshotAnnotationTool = "";
          showCategories = false;
          showIconBackground = false;
          sortByMostUsed = true;
          terminalCommand = "ghostty -e";
          viewMode = "list";
        };
      }
    ];
  };
}
