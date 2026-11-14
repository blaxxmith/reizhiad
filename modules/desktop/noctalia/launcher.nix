_: {
  flake.nixosModules.desktop = _: {
    home-manager.sharedModules = [
      {
        programs.noctalia.settings.shell.launcher = {
          categories = false;
          fetch_exchange_rates = false;
        };
      }
    ];
  };
}
