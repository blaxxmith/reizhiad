_: {
  flake.nixosModules.neovim = _: {
    home-manager.sharedModules = [
      {
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
            };
          };

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
              key = "<C-S-o>";
              action = "<cmd>Telescope fd<CR>";
              options = {
                desc = "Telescope: find files with fd";
                silent = true;
              };
            }
            {
              mode = ["n" "i" "v"];
              key = "<C-S-f>";
              action = "<cmd>Telescope live_grep<CR>";
              options = {
                desc = "Telescope: find in files with live grep";
                silent = true;
              };
            }
          ];
        };
      }
    ];
  };
}
