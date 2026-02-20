{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.forgeOS.host;
  vars = {
    keymap = cfg.keymap;
    screenMode = cfg.screen.mode;
    screenPos = cfg.screen.position;
    screenScale = cfg.screen.scale;
  };
in {
  # imports = [
  #   ./work.nix
  # ];

  options.forgeOS.host = {
    keymap = lib.mkOption {
      type = lib.types.str;
      default = "linux";
      description = "Choose a `mac` or a `linux` keymap (and screen)";
      example = "mac";
    };
    screen = {
      scale = lib.mkOption {
        type = lib.types.str;
        description = "Set the scale of your primary screen";
        default = "1.00";
        example = "1.50";
      };
      mode = lib.mkOption {
        type = lib.types.str;
        description = "Sway mode of the primary screen";
        example = "1920x1080@60.000Hz";
      };

      position = lib.mkOption {
        type = lib.types.str;
        description = "Position of the primary screen";
        default = "0,0";
        example = "1111,2222";
      };
    };
  };

  config = {
    home-manager = {
      extraSpecialArgs = {inherit inputs vars;};
    };
  };
}
