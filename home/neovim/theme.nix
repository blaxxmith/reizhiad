{
  programs.nixvim.colorschemes = {
    catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };

    nightfox.enable = false;
    everforest = {
      enable = false;
      settings.background = "hard";
    };
  };
}
