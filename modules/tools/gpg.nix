_: {
  flake.homeModules.tools = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.govelTY.tools.gpg;
  in {
    options.govelTY.tools.gpg.enable = lib.mkEnableOption "Sign and encrypt with GPG";

    config = lib.mkIf cfg.enable {
      home.packages = with pkgs; [
        yubikey-manager
        yubikey-personalization
      ];

      programs.gpg.enable = true;

      services.gpg-agent = {
        enable = true;
        enableSshSupport = false;
        defaultCacheTtl = 600;
        maxCacheTtl = 7200;
        pinentry.package = pkgs.pinentry-gnome3;
      };
    };
  };
}
