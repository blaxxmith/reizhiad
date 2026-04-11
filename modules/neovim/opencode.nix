_: {
  flake.nixosModules.neovim = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.tools.nvim.opencode;
  in {
    options.forgeOS.tools.nvim.opencode = lib.mkEnableOption "OpenCode integration for NeoVIM";

    config = lib.mkIf cfg {
      environment.systemPackages = [pkgs.opencode];

      home-manager.users."${config.forgeOS.profile.user}".programs = {
        nixvim.plugins.opencode = {
          enable = true;
        };

        opencode = {
          enable = true;
          settings = {
            server = {
              port = 4096;
              hostname = "127.0.0.1";
            };
          };
          tui.theme = "everforest";
        };
      };
    };
  };
}
