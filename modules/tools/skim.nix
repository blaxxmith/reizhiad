_: {
  flake.nixosModules.tools = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.tools.skim;
  in {
    options.forgeOS.tools.skim = {
      enable = lib.mkEnableOption "`skim`, a fuzzy finder in Rust.";
      addAlias = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Replace `fzf` command with `sk`.";
      };
    };

    config = lib.mkIf cfg.enable {
      environment.systemPackages = [pkgs.skim];
      home-manager.sharedModules = [
        {
          programs = lib.mkMerge [
            (lib.mkIf cfg.addAlias {
              zsh.shellAliases.fzf = "sk";
            })

            {
              skim = {
                enable = true;
                enableZshIntegration = true;
                defaultOptions = ["--ansi" "--height 50" "--reverse" "--preview 'bat --color=always --line-range=:500 {}'"];
                historyWidgetOptions = ["--ansi" "--reverse" "--height 10" "--prompt h>"];
              };
            }
          ];
        }
      ];
    };
  };
}
