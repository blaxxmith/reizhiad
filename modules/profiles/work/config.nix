{self, ...}: {
  flake.nixosModules.work-profile = {
    config,
    pkgs,
    ...
  }: let
    user = "pex";
  in {
    # imports = [self.nixosModules.profiles];

    security.pki.certificateFiles = [
      (builtins.readFile config.sops.secrets.crt-alpes.path)
      (builtins.readFile config.sops.secrets.crt-multi.path)
      (builtins.readFile config.sops.secrets.crt-tavel.path)
      (builtins.readFile config.sops.secrets.crt-telex.path)
      (builtins.readFile config.sops.secrets.crt-vigan.path)
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
        # backdooris.configFile = config.sops.secrets.wg-backdooris.path;
      };
    };

    forgeOS = {
      profile = {
        inherit user;
        extraPackages = with pkgs; [
          signal-desktop
          glab
        ];
      };
      apps.zen.enable = true;
      tools = {
        ssh.extraFiles = [config.sops.secrets.ssh-config-work.path];
        nvim.opencode = true;
        git.extraAccounts = {
          "github.com" = {
            remote = "git@github.com";
            gitConfig = config.sops.secrets.gitconfig-github-work.path;
            sshConfig = config.sops.secrets.ssh-github-work.path;
          };
          "drakkar.cartesian-lab.fr" = {
            remote = "git@drakkar.cartesian-lab.fr";
            gitConfig = config.sops.secrets.gitconfig-work.path;
            sshConfig = config.sops.secrets.ssh-gitlab-work.path;
          };
        };
      };
    };
  };
}
