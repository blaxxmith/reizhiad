_: {
  flake.nixosModules.system = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.system.yubikey;
  in {
    options.forgeOS.system.yubikey = {
      enable = lib.mkEnableOption "Yubikey passwordless for PAM";
      waylandEnable = lib.mkEnableOption "Yubikey passwordless for Wayland";
    };

    config = lib.mkIf cfg.enable {
      security.pam = {
        u2f = {
          enable = true;
          settings.cue = true;
          control = "sufficient";
        };
        services = {
          login.u2fAuth = false;
          sudo.u2fAuth = true;
          swaylock.u2fAuth = false;
        };
      };
    };
  };
}
