_: {
  flake.nixvimModules.default = {pkgs, ...}: {
    plugins.lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        clangd.enable = true;
        cmake.enable = true;
        markdown_oxide.enable = true;
        nixd.enable = true;
        terraformls.enable = true;
        tinymist.enable = true;

        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
      };
    };

    extraPackages = with pkgs; [nixd alejandra];
  };
}
