_: {
  flake.nixosModules.tools = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.tools.ripgrep;
  in {
    options.forgeOS.tools.ripgrep = {
      enable = lib.mkEnableOption "`ripgrep`, a search tool alternative to `grep`.";
      addAlias = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Replace `grep` command with `rg`.";
      };
    };

    config = lib.mkIf cfg.enable {
      environment.systemPackages = [pkgs.ripgrep];
      home-manager.sharedModules = [
        {
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
        }
      ];
    };
  };
}
