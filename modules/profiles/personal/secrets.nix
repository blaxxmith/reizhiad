_: {
  flake.nixosModules.personal-profile = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.profiles.personal;
  in
    lib.mkIf cfg.enable {
      sops.secrets = let
        mode = "0400";
        owner = config.forgeOS.profiles.personal.user;
      in {
        gitconfig-github-perso = {
          inherit owner mode;
          sopsFile = ../../../.secrets/github.gitconfig.sops;
        };
        ssh-github-perso = {
          inherit owner mode;
          sopsFile = ../../../.secrets/github.ssh.sops;
        };
      };
    };
}
