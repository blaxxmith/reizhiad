_: {
  flake.homeModules.tools = {
    config,
    lib,
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
      programs = lib.mkMerge [
        (lib.mkIf cfg.addAlias {zsh.shellAliases.fzf = "sk";})

        {
          skim = {
            enable = true;
            enableZshIntegration = true;
            defaultOptions = ["--ansi" "--height 10" "--reverse"];
            historyWidgetOptions = ["--ansi" "--height 10" "--prompt h>"];
          };
        }
      ];
    };
  };
}
