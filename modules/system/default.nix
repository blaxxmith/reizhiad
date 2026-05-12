{self, ...}: {
  flake.nixosModules.system = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.system;
  in {
    options.forgeOS.system.version = lib.mkOption {
      type = lib.types.str;
      default = "26.05";
      description = "The version of NixOS to use for the system configuration.";
    };

    imports = with self.nixosModules; [docker boot localization];

    config = {
      docker.enable = true;
      environment = {
        systemPackages = [pkgs.nfs-utils];
        defaultPackages = lib.mkForce [pkgs.rsync];
      };

      users.mutableUsers = false;

      documentation = {
        enable = true;
        man.enable = true;
      };

      environment.etc.issue.text = ''
             _________/\\/\\__________________________________________________/\\/\\____/\\/\\/\\/\\/\\____/\\/\\____/\\/\\_
            _______/\\/\\______/\\/\\/\\/\\____/\\/\\/\\____/\\/\\__/\\/\\____/\\/\\/\\____/\\/\\____/\\/\\____/\\/\\__/\\/\\__/\\/\\___
           _____/\\/\\______/\\/\\__/\\/\\__/\\/\\__/\\/\\__/\\/\\__/\\/\\__/\\/\\/\\/\\/\\__/\\/\\____/\\/\\/\\/\\/\\____/\\/\\/\\/\\_____
          ___/\\/\\__________/\\/\\/\\/\\__/\\/\\__/\\/\\____/\\/\\/\\____/\\/\\________/\\/\\____/\\/\\__/\\/\\____/\\/\\__/\\/\\___
         _/\\/\\________________/\\/\\____/\\/\\/\\________/\\________/\\/\\/\\/\\__/\\/\\/\\__/\\/\\____/\\/\\__/\\/\\____/\\/\\_
        _______________/\\/\\/\\/\\___________________________________________________________________________

        [32m<<< Welcome to \n (\l) >>>[0m

        <<< Current Version: \s \r >>>
        <<< Main IP: \4 >>>
        <<< Logged users: \U >>>

        [1;31m<<< Unauthorized access is prohibited and will be reported >>>[0m

      '';

      system.stateVersion = cfg.version;
    };
  };
}
