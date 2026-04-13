_: {
  flake.nixosModules.personal-profile = {
    config,
    pkgs,
    ...
  }: let
    user = config.forgeOS.profile.user;
  in {
    users.users."${user}" = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Personal Account";
      extraGroups = ["networkmanager" "docker" "wheel"];
      password = "f2tvi1rd&2crdtfdlt";
    };
  };
}
