_: {
  flake.nixosModules.work-profile = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.profiles.work;
    user = "pex";
  in
    lib.mkIf cfg.enable {
      users.users."${user}" = {
        isNormalUser = true;
        shell = pkgs.zsh;
        home = "/home/${user}";
        description = "Work Account";
        extraGroups = ["networkmanager" "docker" "wheel"];
        hashedPasswordFile = config.sops.secrets.session-password-work.path;
      };
    };
}
