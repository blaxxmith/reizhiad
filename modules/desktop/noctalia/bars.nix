_: {
  flake.nixosModules.desktop = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.desktop.bars;
  in {
    options.forgeOS.desktop.bars.enable = lib.mkEnableOption "Sway Bars";

    config = lib.mkIf cfg.enable {
      home-manager.sharedModules = [
        {
          wayland.windowManager.sway.config.bars = lib.mkForce [];

          programs.noctalia-shell.settings.bar = {
            barType = "floating";
            position = "top";
            monitors = [];
            displayMode = "always_visible"; # "auto_hide";
            autoHideDelay = 500;
            autoShowDelay = 150;
            backgroundOpacity = 0;
            capsuleColorKey = "none";
            capsuleOpacity = 1;
            contentPadding = 0;
            density = "default";
            enableExclusionZoneInset = true;
            fontScale = 1;
            frameRadius = 12;
            frameThickness = 8;
            hideOnOverview = false;
            marginHorizontal = 0;
            marginVertical = 0;
            middleClickAction = "none";
            middleClickCommand = "";
            middleClickFollowMouse = false;
            mouseWheelAction = "none";
            mouseWheelWrap = true;
            outerCorners = true;
            reverseScroll = false;
            rightClickAction = "controlCenter";
            rightClickCommand = "";
            rightClickFollowMouse = true;
            showCapsule = true;
            showOnWorkspaceSwitch = true;
            showOutline = false;
            useSeparateOpacity = true;
            widgetSpacing = 6;
            widgets = {
              left = [
                {
                  id = "Clock";
                  formatHorizontal = "HH:mm:ss";
                  formatVertical = "HH mm ss";
                  tooltipFormat = "ddd dd MMM - HH:mm";
                }
                {
                  id = "Network";
                  displayMode = "alwaysShow";
                  iconColor = "secondary";
                }
              ];
              center = [
                {
                  id = "Workspace";
                  characterCount = 6;
                  colorizeIcons = false;
                  emptyColor = "none";
                  enableScrollWheel = true;
                  focusedColor = "error";
                  followFocusedScreen = false;
                  fontWeight = "bold";
                  groupedBorderOpacity = 0.5;
                  hideUnoccupied = true;
                  iconScale = 0.7;
                  labelMode = "name";
                  occupiedColor = "none";
                  pillSize = 0.6;
                  showApplications = true;
                  showApplicationsHover = true;
                  showBadge = true;
                  showLabelsOnlyWhenOccupied = true;
                  unfocusedIconsOpacity = 1;
                }
              ];
              right = [
                {
                  compactMode = false;
                  id = "SystemMonitor";
                  showCpuCores = false;
                  showCpuFreq = false;
                  showCpuTemp = true;
                  showCpuUsage = true;
                  showDiskAvailable = true;
                  showDiskUsage = true;
                  showDiskUsageAsPercent = false;
                  showGpuTemp = false;
                  showLoadAverage = false;
                  showMemoryAsPercent = true;
                  showMemoryUsage = true;
                  showNetworkStats = false;
                  showSwapUsage = false;
                  textColor = "none";
                  useMonospaceFont = true;
                  usePadding = true;
                  iconColor = "secondary";
                }
                {
                  id = "Volume";
                  displayMode = "alwaysShow";
                  iconColor = "secondary";
                }
                {
                  id = "Battery";
                  displayMode = "icon-always";
                  hideIfNotDetected = false;
                  hideIfIdle = false;
                  showNoctaliaPerformance = true;
                  showPowerProfiles = true;
                }
                {
                  id = "NotificationHistory";
                  hideWhenZero = true;
                  hideWhenZeroUnread = false;
                  showUnreadBadge = true;
                  iconColor = "primary";
                  unreadBadgeColor = "error";
                }
              ];
            };
          };
        }
      ];
    };
  };
}
