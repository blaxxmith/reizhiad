{inputs, ...}: {
  flake.nixosModules.boot = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.boot;
  in {
    options.forgeOS.boot = {
      enableSecureBoot = lib.mkEnableOption "Secure Boot support";
      plymouth = {
        enable = lib.mkEnableOption "Plymouth boot splash screen";
        theme = lib.mkOption {
          type = lib.types.str;
          default = "darth_vader";
          description = "Plymouth theme to use for the boot splash screen.";
        };
      };
    };

    imports = [inputs.lzbt.nixosModules.lanzaboote];

    config.boot = {
      loader.systemd-boot.enable = lib.mkForce (!cfg.enableSecureBoot);

      bootspec.enable = cfg.enableSecureBoot;
      lanzaboote = {
        enable = cfg.enableSecureBoot;
        pkiBundle = "/var/lib/sbctl";
      };

      plymouth = {
        inherit (cfg.plymouth) enable;
        inherit (cfg.plymouth) theme;
        themePackages = with pkgs; [
          (adi1090x-plymouth-themes.override {
            selected_themes = [cfg.plymouth.theme];
          })
        ];
      };

      consoleLogLevel = 3;
      initrd.verbose = false;
    };
  };
}
