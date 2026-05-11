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

      programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        xwayland.enable = true;
        extraPackages = with pkgs;
          lib.mkForce [
            wdisplays
            cliphist
            wl-clipboard
          ];
      };

      xdg.portal = {
        inherit (cfg) enable;
        wlr.enable = true;
        xdgOpenUsePortal = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-gnome
        ];
      };

      hardware.graphics.enable = true;

      home-manager.sharedModules = [
        {
          wayland.windowManager.sway = {
            enable = true;
            systemd.enable = true;
            wrapperFeatures.gtk = true;
            checkConfig = true;
            config.defaultWorkspace = "workspace number 1";
          };
        }
      ];

      environment.sessionVariables.NIXOS_OZONE_WL = "1";
    };
  };
}
