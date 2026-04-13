{self, ...}: {
  flake.nixosModules.personal-profile = {
    config,
    pkgs,
    ...
  }: let
    # user = "blaxxmith";
    user = "eagle";
  in {
    forgeOS = {
      profile = {
        inherit user;
        extraPackages = with pkgs; [
          # anytype
        ];
      };
      tools = {
        ssh.extraFiles = [];
        nvim.opencode = true;
        git.extraAccounts = {
          "github.com" = {
            remote = "git@github.com";
            gitConfig = config.sops.secrets.gitconfig-github-perso.path;
            sshConfig = config.sops.secrets.ssh-github-perso.path;
          };
        };
      };
      apps.zen.enable = true;
    };
  };
}
