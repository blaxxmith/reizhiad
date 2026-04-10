{self, ...}: {
  flake.homeModules.apps = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.apps;
  in {
    imports = [
      self.homeModules.zen
    ];

    options.forgeOS.apps = {
      enable = lib.mkEnableOption "Applications module";
      enableTUIApps = lib.mkEnableOption "Terminal User Interface Applications";
      enableGUIApps = lib.mkEnableOption "Graphical User Interface Applications";
    };

    config = lib.mkMerge [
      (lib.mkIf (cfg.enable && cfg.enableTUIApps) {
        forgeOS.apps = {
          # Breaking Update
          iamb.enable = lib.mkDefault false;
          yazi.enable = lib.mkDefault true;
        };
      })

      (lib.mkIf (cfg.enable && cfg.enableGUIApps) {
        forgeOS.apps = {
          firefox.enable = lib.mkDefault true;
          alacritty.enable = lib.mkDefault true;
          kitty.enable = lib.mkDefault true;
          chromium.enable = lib.mkDefault true;
          vscode.enable = lib.mkDefault false;
          ghostty.enable = lib.mkDefault true;
        };

        home.packages = with pkgs; [
          signal-desktop
          obsidian
          feh
          jetbrains.pycharm
          tor-browser
          # anytype
        ];
      })
    ];
  };
}
