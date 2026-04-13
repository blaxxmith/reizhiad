_: {
  flake.nixosModules.neovim = {config, ...}: {
    home-manager.sharedModules = [
      {
        programs.nixvim.colorschemes = {
          catppuccin = {
            enable = false;
            settings.flavour = "mocha";
          };

          nightfox.enable = false;
          everforest = {
            enable = true;
            settings.background = "hard";
          };
        };
      }
    ];
  };
}
