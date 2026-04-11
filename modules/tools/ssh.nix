_: {
  flake.nixosModules.tools = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.tools.ssh;
    sshPath = "/home/${config.forgeOS.profile.user}/.ssh";
    sshIncludes = config.home-manager.users."${config.forgeOS.profile.user}".programs.ssh.includes or [];
  in {
    options.forgeOS.tools.ssh = {
      enable = lib.mkEnableOption "Secure Shell Access";
      extraFiles = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "SSH config files to include";
        default = [];
      };
    };

    config.home-manager.users."${config.forgeOS.profile.user}" = lib.mkIf cfg.enable {
      home.packages = [
        (pkgs.writeShellApplication {
          name = "sk-ssh";
          text = ''
            host=$(rg -e "^Host " ${lib.concatStringsSep " " sshIncludes} | awk "{print \$2}" | \
              sk --prompt="SSH > " --preview="ssh -G {} 2>/dev/null | rg --color=never -e '(^hostname|user |^port|identityfile|dynamic)'" --height=5);

            [[ -n "$host" ]] && ssh "$host"
          '';
        })
      ];

      programs.ssh = {
        enable = true;
        package = null;
        enableDefaultConfig = false;
        includes = cfg.extraFiles;
        matchBlocks."*" = {
          controlMaster = "auto";
          controlPath = "${sshPath}/sockets/%r@%h-%p";
          controlPersist = "3600";
          serverAliveInterval = 60;
        };
      };
    };
  };
}
