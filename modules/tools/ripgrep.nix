_: {
  flake.homeModules.tools = {
    config,
    lib,
    ...
  }: let
    cfg = config.govelTY.tools.ripgrep;
  in {
    options.govelTY.tools.ripgrep = {
      enable = lib.mkEnableOption "`ripgrep`, a search tool alternative to `grep`.";
      addAlias = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Replace `grep` command with `rg`.";
      };
    };

    config = lib.mkIf cfg.enable {
      programs = lib.mkMerge [
        (lib.mkIf cfg.addAlias {
          zsh.shellAliases.grep = "rg";
        })

        {
          ripgrep = {
            enable = true;
            arguments = [
              "--hidden"
              "--glob"
              "!.git/*"
              "--glob"
              "!.direnv/*"
            ];
          };
        }
      ];
    };
  };
}
