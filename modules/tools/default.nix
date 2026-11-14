{self, ...}: {
  flake.nixosModules.tools = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.tools;
  in {
    options.forgeOS.tools = {
      enable = lib.mkEnableOption "Tools and Utilities module";
      enableExtendedToolset = lib.mkEnableOption "extended set of tools and utilities. Otherswise, only a minimal set of tools will be enabled.";
    };

    config = lib.mkMerge [
      (lib.mkIf cfg.enable {
        home-manager.sharedModules = [self.homeModules.tools];

        forgeOS.tools = {
          git.enable = true;
        };
      })

      (lib.mkIf (cfg.enable && cfg.enableExtendedToolset) {
        forgeOS.tools = {
          ssh.enable = lib.mkDefault true;
        };
      })
    ];
  };
}
