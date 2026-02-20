{
  config,
  lib,
  ...
}: let
  cfg = config.forgeOS.apps.yazi;
in {
  options.forgeOS.apps.yazi.enable = lib.mkEnableOption "Yazi TUI File Manager";

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      shellWrapperName = "yy";
    };
  };
}
