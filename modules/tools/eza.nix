_: {
  flake.homeModules.tools = {
    config,
    lib,
    ...
  }: let
    cfg = config.govelTY.tools.eza;
  in {
    options.govelTY.tools.eza = {
      enable = lib.mkEnableOption "`eza`, a modern replacement for `ls`.";
      addAlias = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Replace `ls` command with `eza`.";
      };
    };

    config = lib.mkIf cfg.enable {
      programs = lib.mkMerge [
        (lib.mkIf cfg.addAlias {
          zsh.shellAliases = {
            ls = "eza";
            la = "eza --almost-all";
            l = "eza --long --almost-all --octal-permissions --header --group";
            ll = "eza --long --header --octal-permissions --group";
            tree = "eza --tree";
          };
        })
        {
          eza = {
            enable = true;
            git = true;
            icons = "always";
            colors = "always";
            enableZshIntegration = true;
            extraOptions = ["--sort=type"];
          };
        }
      ];
    };
  };
}
