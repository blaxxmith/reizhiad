{self, ...}: {
  flake.nixosModules.home = {
    config,
    lib,
    ...
  }: let
    enabledProfiles = lib.filterAttrs (_: profile: profile.enable) config.forgeOS.profiles;
  in {
    imports = with self.nixosModules; [apps desktop neovim shell tools];

    forgeOS = {
      shell.enable = lib.mkDefault true;
      apps = {
        enable = lib.mkDefault true;
        enableTUIApps = lib.mkDefault true;
        zen.enable = lib.mkDefault true;
      };
      tools = {
        enable = lib.mkDefault true;
        nvim = {
          enable = lib.mkDefault true;
          opencode = lib.mkDefault true;
        };
      };
    };

    home-manager.users = lib.mapAttrs' (_: profile:
      lib.nameValuePair profile.user {
        home = {
          stateVersion = "24.05";
          packages = profile.extraPackages;
          homeDirectory = "/home/${profile.user}";
          username = profile.user;
        };

        programs.home-manager.enable = true;

        xdg.userDirs = let
          hd = "/home/${profile.user}";
        in {
          createDirectories = false;
          documents = "${hd}/documents";
          download = "${hd}/downloads";
        };
      })
    enabledProfiles;
  };
}
