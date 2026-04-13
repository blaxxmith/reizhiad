_: {
  flake.nixosModules.neovim = {pkgs, ...}: {
    home-manager.sharedModules = [
      {
        programs.nixvim.plugins.lsp = {
          enable = true;
          servers = {
            nixd.enable = true;
            clangd.enable = true;
            bashls.enable = true;
            markdown_oxide.enable = true;
            cmake.enable = true;
            rust_analyzer = {
              enable = true;
              installCargo = false;
              installRustc = false;
            };
            ts_ls.enable = true;
            terraformls.enable = true;
            metals.enable = true;
          };
        };
      }
    ];

    environment.systemPackages = with pkgs; [
      nixd
      alejandra
    ];
  };
}
