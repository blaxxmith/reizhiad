_: {
  flake.nixvimModules.plugins = {
    plugins.conform-nvim = {
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
}
