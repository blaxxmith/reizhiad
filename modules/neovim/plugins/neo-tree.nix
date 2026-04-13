_: {
  flake.nixosModules.neovim = {config, ...}: {
    home-manager.sharedModules = [
      {
        programs.nixvim = {
          plugins.neo-tree = {
            enable = true;
            settings = {
              close_if_last_window = true;
              filesystem = {
                filtered_items = {
                  visible = true;
                  hide_dotfiles = false;
                  hide_gitignored = true;
                  never_show = ["node_modules" ".git" ".direnv" "__pycache__" ".envrc"];
                };
                follow_current_file.enabled = true;
              };
              window = {
                width = 30;
                auto_expand_width = false;
              };
            };
          };
          keymaps = [
            {
              mode = "n";
              key = "<C-l>";
              action = "<cmd>Neotree toggle<CR>";
              options = {
                desc = "Neo-tree: Toggle file explorer";
                silent = true;
                noremap = true;
              };
            }
          ];
        };
      }
    ];
  };
}
