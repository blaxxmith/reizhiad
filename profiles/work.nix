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
        inherit owner mode format;
        sopsFile = ../secrets/work/alpes-si.crt.sops;
      };
      multi-crt = {
        inherit owner mode format;
        sopsFile = ../secrets/work/multi.crt.sops;
      };
      tavel-crt = {
        inherit owner mode format;
        sopsFile = ../secrets/work/tavel.crt.sops;
      };
      telex-crt = {
        inherit owner mode format;
        sopsFile = ../secrets/work/telex.crt.sops;
      };
      vigan-crt = {
        inherit owner mode format;
        sopsFile = ../secrets/work/vigan.crt.sops;
      };
      backdooris-wg = {
        inherit owner mode format;
        sopsFile = ../secrets/work/backdooris.wg.sops;
      };
      work-ssh-config = {
        inherit owner mode format;
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
      (builtins.readFile config.sops.secrets.alpes-si-crt.path)
      (builtins.readFile config.sops.secrets.multi-crt.path)
      (builtins.readFile config.sops.secrets.tavel-crt.path)
      (builtins.readFile config.sops.secrets.telex-crt.path)
      (builtins.readFile config.sops.secrets.vigan-crt.path)
    ];

    networking = {
      hosts = {
        # Multi
        "10.102.0.61" = ["gestionnaire.si-dr.fr"];
        "10.101.0.51" = ["portal.si-dr.fr"];
        "10.101.0.61" = ["signal.si-dr.fr" "signal1.si-dr.fr" "signal2.si-dr.fr" "turn1.si-dr.fr" "turn2.si-dr.fr"];
        # "10.100.4.81" = ["influx.si-dr.fr" "monitoring.si-dr.fr"];
        "10.100.55.81" = ["influx.si-dr.fr" "monitoring.si-dr.fr" "metrics.si-dr.fr"];

        # Tavel
        # "10.100.0.51" = ["portal.si-dr.fr" "signal.si-dr.fr" "signal1.si-dr.fr" "signal2.si-dr.fr" "turn1.si-dr.fr" "turn2.si-dr.fr"];

        "127.0.0.1" = ["local.si-dr.fr" "office.si-dr.fr"];
      };
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
              "github.com" = {
                remote = "git@github.com";
                gitConfig = "github-gitconfig";
                sshConfig = "github-ssh";
              };
              "drakkar.cartesian-lab.fr" = {
                remote = "git@drakkar.cartesian-lab.fr";
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
