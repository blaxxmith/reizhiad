_: {
  flake.nixosModules.desktop = {
    lib,
    pkgs,
    ...
  }: {
    programs.sway = {
      enable = false;
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
          enable = false;
          systemd.enable = true;
          wrapperFeatures.gtk = true;
          checkConfig = true;
          config.defaultWorkspace = "workspace number 1";
        };
      }
    ];
  };
}
