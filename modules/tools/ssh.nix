{...}: {
  flake.homeModules.tools = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.tools.ssh;
    sshPath = config.home.homeDirectory + "/.ssh";
  in {
    options.forgeOS.tools.ssh = {
      enable = lib.mkEnableOption "Secure Shell Access";
      extraFiles = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "SOPS IDs to extra SSH config files to include";
        default = [];
      };
    };

    config = lib.mkIf cfg.enable {
      programs.ssh = {
        enable = true;
        package = null;
        enableDefaultConfig = false;
        includes = cfg.extraFiles;
        matchBlocks = lib.mkMerge [
          {
            "*" = {
              controlMaster = "auto";
              controlPath = "${sshPath}/sockets/%r@%h-%p";
              controlPersist = "3600";
              serverAliveInterval = 60;
            };
          }
        ];
      };
    };
  };
}
