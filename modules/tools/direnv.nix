_: {
  flake.nixosModules.tools = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.tools.direnv;
  in {
    options.forgeOS.tools.direnv = {
      enable = lib.mkEnableOption "`direnv`, an environment switcher for the shell.";
    };

    config = lib.mkIf cfg.enable {
      home-manager.sharedModules = [
        {
          programs.direnv = {
            enable = true;
            nix-direnv.enable = true;
            silent = true;
            enableZshIntegration = true;
          };
        }
      ];
    };
  };
}
