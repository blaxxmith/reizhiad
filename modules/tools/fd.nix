_: {
  flake.homeModules.tools = {
    config,
    lib,
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
      programs = lib.mkMerge [
        (lib.mkIf cfg.addAlias {zsh.shellAliases.find = "fd";})

        {
          fd = {
            enable = true;
            hidden = true;
          };
        }
      ];
    };
  };
}
