{...}: {
  flake.homeModules.neovim = {...}: {
    programs.nixvim = {
      keymaps = [
        {
          action = "()<Left>";
          key = "(";
          mode = ["i"];
          options.noremap = true;
        }
        {
          action = "{}<Left>";
          key = "{";
          mode = ["i"];
          options.noremap = true;
        }
        {
          action = "[]<Left>";
          key = "[";
          mode = ["i"];
          options.noremap = true;
        }
        {
          action = "{<CR>}<Esc>O";
          key = "{<CR>";
          mode = ["i"];
          options.noremap = true;
        }
        {
          action = "{<CR>};<Esc>O";
          key = "{;";
          mode = ["i"];
          options.noremap = true;
        }
      ];

      plugins.cmp.settings.mapping = {
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.close()";
        "<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
      };
    };
  };
}
