_: {
  flake.nixvimModules.default = _: {
    colorschemes = {
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
