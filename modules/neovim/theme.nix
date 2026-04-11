_: {
  flake.nixosModules.neovim = {config, ...}: {
    home-manager.users."${config.forgeOS.profile.user}".programs.nixvim.colorschemes = {
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
  };
}
