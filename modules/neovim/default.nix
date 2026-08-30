{inputs, ...}: {
  flake.nixvimModules.default = {
    nixpkgs.source = inputs.nixpkgs.outPath;

    enableMan = true;

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
      typst-preview.enable = true;
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
            typ = ["tinymist"];
          };
        };
      };
    };
  };
}
