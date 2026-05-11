_: {
  flake.nixosModules.system = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.security;
    ybk = cfg.yubikey;
  in {
    options.forgeOS.security = {
      sudo = lib.mkOption {
        type = lib.types.enum ["sudo" "sudo-rs"];
        default = "sudo-rs";
        description = "The sudo implementation to use for the system.";
      };
      yubikey = {
        enable = lib.mkEnableOption "Yubikey passwordless authentication for login and sudo";
        enableForWayland = lib.mkEnableOption "Yubikey passwordless for Wayland sessions (swaylock)";
      };
    };

    config.security = {
      lockKernelModules = true;
      protectKernelImage = true;

      polkit.enable = true;
      sudo.enable = cfg.sudo == "sudo";
      sudo-rs = {
        enable = cfg.sudo == "sudo-rs";
        extraConfig = ''
          Defaults !pwfeedback
        '';
      };

      pam = {
        u2f = {
          inherit (ybk) enable;
          settings.cue = ybk.enable;
          control = "sufficient";
        };
        services = {
          login.u2fAuth = ybk.enable;
          sudo.u2fAuth = ybk.enable;
          swaylock.u2fAuth = ybk.enableForWayland;
        };
      };
    };
  };
}
