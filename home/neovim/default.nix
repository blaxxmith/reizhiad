{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.forgeOS.tools.nvim;
in {
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./keymapping.nix
    ./lsp.nix
    ./opencode.nix
    ./options.nix
    ./theme.nix
    ./plugins/lightline.nix
    ./plugins/telescope.nix
    ./plugins/neo-tree.nix
    ./plugins/treesitter.nix
  ];

  options.forgeOS.tools.nvim = {
    enable = lib.mkEnableOption "NeoVIM configuration";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "vimPlugins.copilot-vim"
      ];
    programs.nixvim = {
      enable = true;

      defaultEditor = true;
      enableMan = true;
      viAlias = false;

      plugins = {
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            sources = [
              {name = "nvim_lsp";}
              {name = "path";}
              {name = "buffer";}
            ];
          };
        };
        gitgutter = {
          enable = true;
          settings = {
            sign_added = "|";
            sign_modified = "|";
            sign_modified_removed = "±";
            sign_removed = "-";
            sign_removed_firstLine = "ø";
          };
        };
        web-devicons.enable = true;
        rainbow-delimiters.enable = true;
        fugitive.enable = true;
        copilot-vim = {
          enable = true;
          package = pkgs.vimPlugins.copilot-vim;
        };
        conform-nvim = {
          enable = true;
          settings = {
            format_on_save = {
              timeout_ms = 1000;
              lsp_format = "fallback";
            };
            formatters_by_ft = {
              nix = ["alejandra"];
              cpp = ["clang-format"];
              c = ["clang-format"];
              rust = ["rustfmt"];
            };
          };
        };
      };
    };
  };
}
