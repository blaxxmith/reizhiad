{self, ...}: {
  flake.homeModules.main = {
    config,
    lib,
    vars,
    ...
  }: let
    hd = config.home.homeDirectory;
  in {
    imports = with self.homeModules; [apps desktop neovim shell tools];

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
      forgeOS = {
        apps = {
          enable = lib.mkDefault true;
          enableTUIApps = lib.mkDefault true;
          # TEMPORARY
          enableGUIApps = lib.mkDefault true;
        };

        shell.enable = lib.mkDefault true;
        tools = {
          nvim.enable = lib.mkDefault true;
          enable = lib.mkDefault true;
          enableEssentialTools = lib.mkDefault true;
          # TEMPORARY
          enableExtendedTools = lib.mkDefault true;
          oxydize = lib.mkDefault true;
        };

        # TEMPORARY
        desktop.enable = lib.mkDefault false;
      };

      xdg.userDirs = {
        createDirectories = false;
        documents = "${hd}/documents";
        download = "${hd}/downloads";
      };

      programs.home-manager.enable = true;
      home.stateVersion = "24.05";
    };
  };
}
