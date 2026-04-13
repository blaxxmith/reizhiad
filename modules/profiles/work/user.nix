_: {
  flake.nixosMdodules.work-profile = {
    config,
    pkgs,
    ...
  }: let
    user = config.forgeOS.profile.user;
  in {
    users.users."${user}" = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Work Account";
      extraGroups = ["networkmanager" "docker" "wheel"];
      hashedPasswordFile = config.sops.secrets.session-password-work.path;
    };
  };
}
