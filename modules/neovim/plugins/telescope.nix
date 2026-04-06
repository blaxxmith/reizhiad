_: {
  flake.homeModules.neovim = {pkgs, ...}: {
    programs.nixvim = {
      plugins.telescope = {
        enable = true;

        settings = {
          defaults = {
            layout_strategy = "flex";
            layout_config = {
              flex.flip_columns = 120;
              horizontal = {
                preview_width = 0.6;
                prompt_position = "top";
              };
              vertical = {
                preview_height = 0.5;
                prompt_position = "top";
              };
            };
            sorting_strategy = "ascending";
            winblend = 0;
            path_display = ["truncate"];
          };

          pickers = {
            fd = {
              layout_strategy = "flex";
              layout_config = {
                horizontal = {
                  preview_width = 0.6;
                  prompt_position = "top";
                };
                vertical = {
                  preview_height = 0.5;
                  prompt_position = "top";
                };
              };
              sorting_strategy = "ascending";
            };

            # Recherche dans le contenu des fichiers (live_grep)
            live_grep = {
              layout_strategy = "flex";
              layout_config = {
                horizontal = {
                  preview_width = 0.6;
                  prompt_position = "top";
                };
              };
              sorting_strategy = "ascending";
            };

            # Palette de commandes (command palette)
            builtin = {
              layout_strategy = "flex";
              layout_config = {
                horizontal = {
                  preview_width = 0.6;
                  prompt_position = "top";
                };
              };
              sorting_strategy = "ascending";
            };
          };

          # extensions = {
          #   fzf = {
          #     fuzzy = true;
          #     override_generic_sorter = true;
          #     override_file_sorter = true;
          #     case_mode = "smart_case";
          #   };
          # };
        };
      };

      # plugins.telescope.extensions.fzf-native.enable = true;

      extraPlugins = let
        telescope-cmdline = pkgs.vimUtils.buildVimPlugin {
          pname = "telescope-cmdline-nvim";
          version = "unstable-2024";
          src = pkgs.fetchFromGitHub {
            owner = "jonarrien";
            repo = "telescope-cmdline.nvim";
            rev = "7106ff7357d9d3cde3e71cd8fe8998d2f96a1bdd";
            hash = "sha256-xpgWxjng4X1LapjuJkhVM7gQbpiZ9pS6fTy+L2Y8IM8=";
          };
          doInstallCheck = false;
          doCheck = false;
        };
      in [telescope-cmdline];

      extraConfigLua = ''
        require("telescope").load_extension("cmdline")
        vim.keymap.set("n", ":", function()
          require("telescope").extensions.cmdline.cmdline({})
        end, { desc = "Telescope cmdline", noremap = true, nowait = true })
      '';

      keymaps = [
        {
          mode = ["n" "i" "v"];
          key = "<C-S-p>";
          action = "<cmd>Telescope builtin<CR>";
          options = {
            desc = "Telescope Command Palette";
            silent = true;
          };
        }
        {
          mode = ["n" "i" "v"];
          key = "<C-S-f>";
          action = "<cmd>Telescope fd<CR>";
          options = {
            desc = "Telescope: find files with fd";
            silent = true;
          };
        }
      ];
    };
  };
}
