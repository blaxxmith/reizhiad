{
  config,
  lib,
  ...
}: let
  cfg = config.forgeOS.tools.ssh;
  hd = config.home.homeDirectory;
in {
  options.forgeOS.tools.ssh = {
    enable = lib.mkEnableOption "Secure Shell Access";
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      package = null;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          controlMaster = "auto";
          controlPath = "${hd}/.ssh/sockets/%r@%h-%p";
          controlPersist = "3600";
          serverAliveInterval = 60;
        };
        "github.com" = {
          user = "git";
          identityFile = "${hd}/.ssh/github";
        };
      };
    };
  };
}
