_: {
  system = {
    primaryUser = "blaxxmith";

    defaults = {
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "Automatic";
        AppleShowAllFiles = true;
        NSDocumentSaveNewDocumentsToCloud = false;
      };
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
      controlcenter.BatteryShowPercentage = true;

      dock = {
        autohide = true;
        magnification = true;
        minimize-to-application = true;
        orientation = "left";
        show-recents = false;
        tilesize = 48;
        largesize = 96;
        wvous-tr-corner = 5;
        wvous-tl-corner = 10;
      };

      finder = {
        AppleShowAllFiles = true;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        ShowPathbar = true;
        ShowStatusBar = true;
      };

      hitoolbox.AppleFnUsageType = "Change Input Source";

      loginwindow = {
        GuestEnabled = false;
        LoginwindowText = "kamino.forge";
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };

  # fonts = {
  #   fontDir.enable = true;
  #   fonts = [
  #     (pkgs.nerdfonts.override { fonts = [ "Hack" ]; })
  #   ];
  # };
}
