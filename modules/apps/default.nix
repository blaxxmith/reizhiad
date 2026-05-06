{self, ...}: {
  flake.nixosModules.apps = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.apps;
  in {
    imports = [
      self.nixosModules.zen
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
          obsidian.tui = lib.mkDefault true;
        };

        environment.systemPackages = with pkgs; [
          tdf
        ];
      })

      (lib.mkIf (cfg.enable && cfg.enableGUIApps) {
        forgeOS.apps = {
          firefox.enable = lib.mkDefault true;
          alacritty.enable = lib.mkDefault false;
          kitty.enable = lib.mkDefault false;
          chromium.enable = lib.mkDefault true;
          vscode.enable = lib.mkDefault false;
          ghostty.enable = lib.mkDefault true;
          obsidian.enable = lib.mkDefault true;
        };

        services.netbird.ui.enable = true;

        environment.systemPackages = with pkgs; [
          feh
          tor-browser
        ];
      })
    ];
  };
}
