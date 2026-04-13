_: {
  flake.nixosModules.work-profile = {
    config,
    pkgs,
    ...
  }: let
    user = "pex";
  in {
    forgeOS.profiles.work = {
      inherit user;
      extraPackages = with pkgs; [
        signal-desktop
        glab
      ];
      extraSSHConfig = [config.sops.secrets.ssh-config-work.path];
      extraGitAccounts = {
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
}
