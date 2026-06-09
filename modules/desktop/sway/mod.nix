_: {
  flake.nixosModules.desktop = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.desktop.sway;
  in {
    options.forgeOS.desktop.sway.enable = lib.mkEnableOption "Sway - Wayland Window Manager";
    config = {
      programs.sway = {
        inherit (cfg) enable;
        wrapperFeatures.gtk = true;
        xwayland.enable = false;
        extraPackages = with pkgs;
          lib.mkForce [
            wdisplays
            cliphist
            wl-clipboard
          ];
      };

      home-manager.sharedModules = [
        {
          wayland.windowManager.sway = {
            inherit (cfg) enable;
            systemd.enable = true;
            wrapperFeatures.gtk = true;
            checkConfig = true;
            config.defaultWorkspace = "workspace number 1";
          };
        }
      ];
    };
  };
}
