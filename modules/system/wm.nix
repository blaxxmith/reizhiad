_: {
  flake.nixosModules.system = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.system.wm;
  in {
    options.forgeOS.system.wm.enable = lib.mkEnableOption "Graphical environment";

    config = lib.mkIf cfg.enable {
      environment.sessionVariables = {NIXOS_OZONE_WL = "1";};

      fonts.packages = [pkgs.nerd-fonts.hack];

      programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        xwayland.enable = true;
      };

      xdg.portal = {
        enable = lib.mkForce false;
        wlr.enable = true;
        xdgOpenUsePortal = true;
      };

      hardware = {
        graphics.enable = true;
        nvidia.modesetting.enable = true;
      };

      services.netbird.ui.enable = true;
    };
  };
}
