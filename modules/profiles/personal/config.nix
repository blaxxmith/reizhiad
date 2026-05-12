_: {
  flake.nixosModules.personal-profile = {
    config,
    pkgs,
    ...
  }: let
    user = "eagle";
  in {
    forgeOS.profiles.personal = {
      inherit user;
      extraSSHConfig = [config.sops.secrets.ssh-config-lab.path];
      extraGitAccounts = {
        "github.com" = {
          remote = "git@github.com";
          gitConfig = config.sops.secrets.gitconfig-github-perso.path;
          sshConfig = config.sops.secrets.ssh-github-perso.path;
        };
        "git.forge.epita.fr" = {
          remote = "xavier.de-place@git.forge.epita.fr";
          gitConfig = config.sops.secrets.gitconfig-school.path;
          sshConfig = config.sops.secrets.ssh-intra-forge-school.path;
        };
        "gitlab.epita.fr" = {
          remote = "git@gitlab.cri.epita.fr";
          gitConfig = config.sops.secrets.gitconfig-school.path;
          sshConfig = config.sops.secrets.ssh-gitlab-cri-school.path;
        };
      };
      extraPackages = with pkgs; [
        anytype
      ];
    };
  };
}
