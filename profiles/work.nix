{
  config,
  lib,
  pkgs,
  ...
}: let
  user = "pex";
  cfg = config.forgeOS.profiles.work;
in {
  options.forgeOS.profiles.work.enable = lib.mkEnableOption "Work Profile";

  config = lib.mkIf cfg.enable {
    sops.secrets = let
      mode = "0400";
      format = "binary";
      owner = user;
    in {
      work-gitconfig = {
        inherit owner mode format;
        sopsFile = ../secrets/work/gitconfig.sops;
      };
      glwork-ssh = {
        inherit owner mode format;
        sopsFile = ../secrets/work/gitlab.ssh.sops;
      };
      alpes-si-crt = {
        inherit mode format;
        sopsFile = ../secrets/work/alpes-si.crt.sops;
      };
      multi-crt = {
        inherit mode format;
        sopsFile = ../secrets/work/multi.crt.sops;
      };
      tavel-crt = {
        inherit mode format;
        sopsFile = ../secrets/work/tavel.crt.sops;
      };
      telex-crt = {
        inherit mode format;
        sopsFile = ../secrets/work/telex.crt.sops;
      };
      vigan-crt = {
        inherit mode format;
        sopsFile = ../secrets/work/vigan.crt.sops;
      };
      backdooris-wg = {
        inherit mode format;
        sopsFile = ../secrets/work/backdooris.wg.sops;
      };
      work-ssh-config = {
        inherit mode format;
        sopsFile = ../secrets/work/config.ssh.sops;
      };
    };

    users.users."${user}" = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Work Account";
      extraGroups = ["networkmanager" "docker" "wheel"];
    };

    security.pki.certificateFiles = [
      # config.sops.secrets.alpes-si-crt.path
      # config.sops.secrets.multi-crt.path
      # config.sops.secrets.tavel-crt.path
      # config.sops.secrets.telex-crt.path
      # config.sops.secrets.vigan-crt.path
    ];

    networking = {
      hostFiles = [];
      wg-quick.interfaces = {
        # backdooris.configFile = config.sops.secrets.backdooris-wg.path;
      };
    };

    home-manager = {
      users."${user}" = {
        imports = [./../home];

        home = {
          username = user;
          homeDirectory = "/home/${user}";
        };

        forgeOS = {
          desktop.enable = true;
          shell.enable = true;
          tools = {
            ssh.extraFiles = [config.sops.secrets.work-ssh-config.path];
            enable = true;
            nvim.enable = true;
            enableExtendedTools = true;
            oxydize = true;
            git.extraAccounts = {
              "gitlab.alpes.si" = {
                remote = "git@gitlab.alpes.si";
                gitConfig = "work-gitconfig";
                sshConfig = "glwork-ssh";
              };
            };
          };
          apps = {
            zen.enable = true;
            enable = true;
            enableGUIApps = true;
            enableTUIApps = true;
          };
        };
      };
    };
  };
}
