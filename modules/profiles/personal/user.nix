_: {
  flake.nixosModules.personal-profile = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.profiles.personal;
  in
    lib.mkIf cfg.enable {
      users.users."${cfg.user}" = {
        isNormalUser = true;
        shell = pkgs.zsh;
        home = "/home/${cfg.user}";
        description = "Blaxxmith";
        extraGroups = ["networkmanager" "docker" "wheel"];
        hashedPasswordFile = config.sops.secrets.session-password-perso.path;
      };
    };
}
