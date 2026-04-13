{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.profiles = {lib, ...}: {
    imports = [
      inputs.sops.nixosModules.sops
      inputs.hm.nixosModules.home-manager
      self.nixosModules.home
      self.nixosModules.work-profile
      self.nixosModules.personal-profile
    ];

    options.forgeOS.profiles = lib.mkOption {
      description = "ForgeOS user profiles";
      default = {};
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "this profile";
          user = lib.mkOption {
            type = lib.types.str;
            description = "Username of the profile user";
            example = "eagle";
          };
          extraSSHConfig = lib.mkOption {
            type = lib.types.listOf lib.types.path;
            description = "Extra SSH config files to include in the profile (SOPS encrypted)";
            default = [];
          };
          extraPackages = lib.mkOption {
            type = lib.types.listOf lib.types.package;
            description = "Extra packages to install in the profile";
            default = [];
          };
          extraGitAccounts = lib.mkOption {
            description = "Extra GIT accounts to add";
            default = {};
            type = lib.types.attrsOf (lib.types.submodule ({name, ...}: {
              options = {
                name = lib.mkOption {
                  type = lib.types.str;
                  default = name;
                  description = "Name of the Git Account. Must be the FQDN for the SSH Config";
                };
                remote = lib.mkOption {
                  type = lib.types.str;
                  description = "Git IncludeIf pattern of the Account";
                };
                gitConfig = lib.mkOption {
                  type = lib.types.str;
                  description = "Path of the GIT Config for this remote, stored as a SOPS secret";
                };
                sshConfig = lib.mkOption {
                  type = lib.types.str;
                  description = "Path of the SSH Config for this remote, stored as a SOPS secret";
                };
              };
            }));
          };
        };
      });
    };

    config = {
      sops = {
        age.keyFile = "/root/.sops/keys.txt";
        defaultSopsFormat = "binary";
      };

      home-manager = {
        useGlobalPkgs = true;
        backupFileExtension = "forgeos.bak";
      };
    };
  };
}
