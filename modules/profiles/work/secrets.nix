_: {
  flake.nixosModules.work-profile = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.profiles.work;
  in
    lib.mkIf cfg.enable {
      sops.secrets = let
        mode = "0400";
        owner = config.forgeOS.profiles.work.user;
      in {
        gitconfig-work = {
          inherit owner mode;
          sopsFile = ../../../.secrets/work/gitconfig.sops;
        };
        ssh-gitlab-work = {
          inherit owner mode;
          sopsFile = ../../../.secrets/work/gitlab.ssh.sops;
        };
        crt-alpes = {
          inherit owner mode;
          sopsFile = ../../../.secrets/work/alpes-si.crt.sops;
        };
        crt-multi = {
          inherit owner mode;
          sopsFile = ../../../.secrets/work/multi.crt.sops;
        };
        crt-tavel = {
          inherit owner mode;
          sopsFile = ../../../.secrets/work/tavel.crt.sops;
        };
        crt-telex = {
          inherit owner mode;
          sopsFile = ../../../.secrets/work/telex.crt.sops;
        };
        crt-vigan = {
          inherit owner mode;
          sopsFile = ../../../.secrets/work/vigan.crt.sops;
        };
        wg-backdooris = {
          inherit owner mode;
          sopsFile = ../../../.secrets/work/backdooris.wg.sops;
        };
        ssh-config-work = {
          inherit owner mode;
          sopsFile = ../../../.secrets/work/config.ssh.sops;
        };
        gitconfig-github-work = {
          inherit owner mode;
          sopsFile = ../../../.secrets/github.gitconfig.sops;
        };
        ssh-github-work = {
          inherit owner mode;
          sopsFile = ../../../.secrets/github.ssh.sops;
        };
        session-password-work = {
          inherit owner mode;
          sopsFile = ../../../.secrets/work/session.password.sops;
          neededForUsers = true;
        };
      };
    };
}
