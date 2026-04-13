{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.profiles = {
    config,
    lib,
    ...
  }: let
    user = config.forgeOS.profile.user;
  in {
    imports = [
      inputs.sops.nixosModules.sops
      inputs.hm.nixosModules.home-manager
      self.nixosModules.home
      self.nixosModules.system
    ];

    options.forgeOS.profile = {
      user = lib.mkOption {
        type = lib.types.str;
        description = "Username of the profile user";
        default = "eagle";
      };
      extraPackages = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        description = "Extra packages to install in the profile";
        default = [];
      };
    };

    config = {
      sops = {
        age.keyFile = "/root/.sops/keys.txt";
        defaultSopsFormat = "binary";
      };

      home-manager = {
        useGlobalPkgs = true;
        backupFileExtension = "forgeos.bak";
        users."${user}".home = {
          username = user;
          homeDirectory = "/home/${user}";
        };
      };
    };
  };
}
