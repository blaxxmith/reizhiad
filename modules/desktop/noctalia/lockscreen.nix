_: {
  flake.nixosModules.desktop = _: {
    home-manager.sharedModules = [
      {
        programs.noctalia.settings.lockscreen.enabled = false;
      }
    ];
  };
}
