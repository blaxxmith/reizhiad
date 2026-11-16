{self, ...}: {
  flake.homeModules.apps = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.govelTY.apps;
  in {
    imports = [
      self.homeModules.browser
    ];

    options.govelTY.apps = {
      enable = lib.mkEnableOption "Applications module";
      enableTUIApps = lib.mkEnableOption "Terminal User Interface Applications";
      enableGUIApps = lib.mkEnableOption "Graphical User Interface Applications";
    };

    config = lib.mkMerge [
      (lib.mkIf (cfg.enable && cfg.enableTUIApps) {
        govelTY.apps = {
          iamb.enable = lib.mkDefault true;
          yazi.enable = lib.mkDefault true;
          obsidian.tui = lib.mkDefault true;
        };

        home.packages = with pkgs; [
          tdf
        ];
      })

      (lib.mkIf (cfg.enable && cfg.enableGUIApps) {
        govelTY.apps = {
          alacritty.enable = lib.mkDefault false;
          kitty.enable = lib.mkDefault false;
          chromium.enable = lib.mkDefault true;
          vscode.enable = lib.mkDefault false;
          ghostty.enable = lib.mkDefault true;
          obsidian.enable = lib.mkDefault true;
        };

        home.packages = with pkgs; [
          tor-browser
          signal-desktop
        ];
      })
    ];
  };
}
