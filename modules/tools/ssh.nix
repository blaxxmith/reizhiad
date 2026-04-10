_: {
  flake.homeModules.tools = {
    config,
    lib,
    pkgs,
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
      home.packages = [
        (pkgs.writeShellApplication {
          name = "sk-ssh";
          text = ''
            host=$(
              {
                ssh -G dummy 2>/dev/null | awk "/^hostname /{print \$2}"
                rg -h "^Host " ~/.ssh/config /etc/ssh/ssh_config \
                  ~/.ssh/config.d/ /etc/ssh/ssh_config.d/ 2>/dev/null \
                  | awk "{print \$2}" | grep -v "[*?]"
                awk "{print \$1}" ~/.ssh/known_hosts 2>/dev/null \
                  | tr "," "\n" | cut -d"[" -f1 | grep -v "^|"
              } | sort -u | sk --prompt="SSH > " \
                  --preview="ssh -G {} 2>/dev/null" \
                  --preview-window=right:50%
            )
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
