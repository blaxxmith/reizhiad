{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.forgeOS.apps;
in {
  imports = [
    ./alacritty.nix
    ./chromium.nix
    ./firefox.nix
    ./iamb.nix
    ./kitty.nix
    ./vscode.nix
    ./yazi.nix
    ./zen.nix
  ];

  options.forgeOS.apps = {
    enable = lib.mkEnableOption "Applications module";
    enableTUIApps = lib.mkEnableOption "Terminal User Interface Applications";
    enableGUIApps = lib.mkEnableOption "Graphical User Interface Applications";
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.enable && cfg.enableTUIApps) {
      forgeOS.apps.iamb.enable = lib.mkDefault true;
      forgeOS.apps.yazi.enable = lib.mkDefault true;
    })

    (lib.mkIf (cfg.enable && cfg.enableGUIApps) {
      forgeOS.apps.firefox.enable = lib.mkDefault true;
      forgeOS.apps.alacritty.enable = lib.mkDefault true;
      forgeOS.apps.kitty.enable = lib.mkDefault true;
      forgeOS.apps.chromium.enable = lib.mkDefault true;
      forgeOS.apps.vscode.enable = lib.mkDefault false;

      home.packages = with pkgs; [
        signal-desktop
        obsidian
        feh
        jetbrains.pycharm
        tor-browser
        anytype
      ];
    })
  ];
}
