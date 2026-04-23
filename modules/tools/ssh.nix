_: {
  flake.nixosModules.tools = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.tools.ssh;
    enabledProfiles = lib.filterAttrs (_: profile: profile.enable) config.forgeOS.profiles;
  in {
    options.forgeOS.tools.ssh.enable = lib.mkEnableOption "Secure Shell Access (client)";

    config = lib.mkIf cfg.enable {
      home-manager.users = lib.mapAttrs' (_: profile:
        lib.nameValuePair profile.user {
          home.packages = [
            (pkgs.writeShellApplication {
              name = "sk-ssh";
              text = ''
                host=$(rg -e "^Host " ${lib.concatStringsSep " " profile.extraSSHConfig} | awk "{print \$2}" | \
                  sk --prompt="SSH > " --preview="ssh -G {} 2>/dev/null | rg --color=never -e '(^hostname|user |^port|identityfile|dynamic)'" --height=5);

                [[ -n "$host" ]] && ssh "$host"
              '';
            })
          ];

          programs.ssh = let
            sshPath = "/home/${profile.user}/.ssh";
          in {
            enable = true;
            package = null;
            enableDefaultConfig = false;
            includes = profile.extraSSHConfig;
            matchBlocks."*" = {
              controlMaster = "auto";
              controlPath = "${sshPath}/sockets/%r@%h-%p";
              controlPersist = "3600";
              serverAliveInterval = 60;
            };
          };
        })
      enabledProfiles;
    };
  };
}
