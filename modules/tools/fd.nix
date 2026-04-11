_: {
  flake.nixosModules.tools = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.tools.fd;
  in {
    options.forgeOS.tools.fd = {
      enable = lib.mkEnableOption "`fd`, a simple, fast and user-friendly alternative to `find`.";
      addAlias = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Replace `find` command with `fd`.";
      };
    };

    config = lib.mkIf cfg.enable {
      environment.systemPackages = [pkgs.fd];
      home-manager.sharedModules = [
        {
          programs = lib.mkMerge [
            (lib.mkIf cfg.addAlias {
              zsh.shellAliases.find = "fd";
            })

            {
              fd = {
                enable = true;
                hidden = true;
                ignores = [
                  ".git/"
                  ".direnv/"
                  "result"
                ];
              };
            }
          ];
        }
      ];
    };
  };
}
