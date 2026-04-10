_: {
  flake.homeModules.tools = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.tools.bat;
  in {
    options.forgeOS.tools.bat = {
      enable = lib.mkEnableOption "`bat`, a `cat(1)` clone with wings.";
      addAlias = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Replace `cat` command with `bat`.";
      };
      man = lib.mkEnableOption "MAN pager integration for `bat`.";
    };

    config = lib.mkIf cfg.enable {
      home.sessionVariables.MANPAGER = lib.mkIf cfg.man "bat -plman";

      programs = lib.mkMerge [
        (lib.mkIf cfg.addAlias {
          zsh.shellAliases.cat = "bat";
        })

        {
          bat = {
            enable = true;
            config = {
              theme = "Dracula";
              italic-text = "always";
            };
          };
        }
      ];
    };
  };
}
