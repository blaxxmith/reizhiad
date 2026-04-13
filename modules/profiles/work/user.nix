_: {
  flake.nixosMdodules.work-profile = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.profiles.work;
  in
    lib.mkIf cfg.enable {
      users.users = let
        inherit (config.forgeOS.profiles.work) user;
      in {
        "${user}" = {
          isNormalUser = true;
          shell = pkgs.zsh;
          description = "Work Account";
          extraGroups = ["networkmanager" "docker" "wheel"];
          hashedPasswordFile = config.sops.secrets.session-password-work.path;
        };
      };
    };
}
