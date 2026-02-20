{
  lib,
  vars,
  ...
}: {
  imports = [
    ./apps
    ./desktop
    ./neovim
    ./shell
    ./tools
  ];

  options.forgeOS = {
    desktop = {
      keymap = lib.mkOption {
        type = lib.types.str;
        description = "Keymap to use. DO NOT EDIT DIRECTLY";
        default = vars.keymap;
        readOnly = true;
      };
      primaryScreen = {
        mode = lib.mkOption {
          type = lib.types.str;
          description = "Primary screen mode to use. do not edit directly";
          default = vars.screenMode;
          readOnly = true;
        };
        scale = lib.mkOption {
          type = lib.types.str;
          description = "Primary screen scale to use. do not edit directly";
          default = vars.screenScale;
          readOnly = true;
        };
        position = lib.mkOption {
          type = lib.types.str;
          description = "Primary screen position to use. do not edit directly";
          default = vars.screenPos;
          readOnly = true;
        };
      };
    };
  };

  config = {
    forgeOS.apps.enable = lib.mkDefault true;
    forgeOS.apps.enableTUIApps = lib.mkDefault true;

    nixpkgs.config.allowUnfree = true;
    programs.home-manager.enable = true;

    nvim.enable = lib.mkDefault true;
    forgeOS.shell.enable = lib.mkDefault true;
    forgeOS.tools.enable = lib.mkDefault true;
    forgeOS.tools.enableEssentialTools = lib.mkDefault true;

    # TEMPORARY
    forgeOS.tools.enableExtendedTools = lib.mkDefault true;
    forgeOS.tools.oxydize = lib.mkDefault true;
    forgeOS.apps.enableGUIApps = lib.mkDefault true;
    forgeOS.desktop.enable = lib.mkDefault false;

    home = {
      stateVersion = "24.05";
      file = {
        ".config/nixpkgs/config.nix".text = ''
          {
            allowUnfree = true;
            allowBroken = false;
          }
        '';
      };
    };
  };
}
