{self, ...}: {
  flake.nixosModules.home = {
    config,
    lib,
    ...
  }: {
    imports = with self.nixosModules; [apps desktop neovim shell tools];

    forgeOS = {
      shell.enable = lib.mkDefault true;
      apps = {
        enable = lib.mkDefault true;
        enableTUIApps = lib.mkDefault true;
      };
      tools = {
        enable = lib.mkDefault true;
        nvim.enable = lib.mkDefault true;
      };
    };

    home-manager.users."${config.forgeOS.profile.user}" = let
      hd = "/home/${config.forgeOS.profile.user}";
    in {
      xdg.userDirs = {
        createDirectories = false;
        documents = "${hd}/documents";
        download = "${hd}/downloads";
      };

      programs.home-manager.enable = true;
      home = {
        stateVersion = "24.05";
        packages = config.forgeOS.profile.extraPackages;
      };
    };
  };
}
