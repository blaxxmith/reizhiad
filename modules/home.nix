{self, ...}: {
  flake.nixosModules.home = {lib, ...}: {
    imports = with self.nixosModules; [apps desktop neovim shell tools];

    forgeOS = {
      shell.enable = lib.mkDefault true;
      apps = {
        enable = lib.mkDefault true;
        enableTUIApps = lib.mkDefault true;
      };
      tools = {
        enable = lib.mkDefault true;
        # TEMPORARY
        enableExtendedToolset = lib.mkDefault true;
        oxydize = lib.mkDefault true;
        nvim.enable = lib.mkDefault true;
      };
    };
  };

  flake.homeModules.main = {
    config,
    ...
  }: let
    hd = config.home.homeDirectory;
  in {
    config = {
      xdg.userDirs = {
        createDirectories = false;
        documents = "${hd}/documents";
        download = "${hd}/downloads";
      };

      programs.home-manager.enable = true;
      home.stateVersion = "24.05";
    };
  };
}
