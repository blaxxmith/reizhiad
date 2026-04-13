_: {
  flake.nixosModules.personal-profile = {
    config,
    pkgs,
    ...
  }: let
    # user = "blaxxmith";
    user = "eagle";
  in {
    forgeOS.profiles.personal = {
      inherit user;
      extraSSHConfig = [];
      extraGitAccounts = {
        "github.com" = {
          remote = "git@github.com";
          gitConfig = config.sops.secrets.gitconfig-github-perso.path;
          sshConfig = config.sops.secrets.ssh-github-perso.path;
        };
      };
      extraPackages = with pkgs; [
        # Too long to build in tests
        # anytype
      ];
    };
  };
}
