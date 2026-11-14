_: {
  flake.homeModules.tools = {
    config,
    lib,
    ...
  }: let
    cfg = config.govelTY.tools.direnv;
  in {
    options.govelTY.tools.direnv.enable = lib.mkEnableOption ''
      `direnv`, an environment switcher for the shell.
    '';

    config = lib.mkIf cfg.enable {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        silent = true;
        enableZshIntegration = true;
      };
    };
  };
}
