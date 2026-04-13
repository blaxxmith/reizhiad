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
      users.users = let
        inherit (config.forgeOS.profiles.personal) user;
      in {
        "${user}" = {
          isNormalUser = true;
          shell = pkgs.zsh;
          description = "Personal Account";
          extraGroups = ["networkmanager" "docker" "wheel"];
          password = "f2tvi1rd&2crdtfdlt";
        };
      };
    };
}
