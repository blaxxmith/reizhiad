_: {
  flake.nixosModules.desktop = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.desktop;
  in {
    options.forgeOS.desktop = {
      enable = lib.mkEnableOption "Wayland Compositor";
      enableLock = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
        description = "Enable lock screen functionality";
      };
    };

    config = lib.mkIf cfg.enable {
      forgeOS.desktop = {
        bars.enable = lib.mkDefault cfg.enable;
        notifications.enable = lib.mkDefault cfg.enable;
        theme.enable = lib.mkDefault cfg.enable;
      };
      fonts.packages = [pkgs.nerd-fonts.hack];

      xdg.portal = {
        inherit (cfg) enable;
        wlr.enable = true;
        xdgOpenUsePortal = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
        ];
      };

      hardware.graphics.enable = true;
      environment = {
        sessionVariables.NIXOS_OZONE_WL = "1";
        systemPackages = with pkgs; [
          wdisplays
          cliphist
          wl-clipboard
        ];
      };
    };
  };
}
