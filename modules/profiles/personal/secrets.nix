_: {
  flake.nixosModules.personal-profile = {config, ...}: let
    owner = config.forgeOS.profile.user;
    mode = "0400";
  in {
    sops.secrets = {
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
