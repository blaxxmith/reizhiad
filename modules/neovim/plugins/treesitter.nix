_: {
  flake.nixosModules.neovim = {
    config,
    pkgs,
    ...
  }: {
    home-manager.users."${config.forgeOS.profile.user}".programs.nixvim.plugins.treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
        folding.enable = true;
      };

      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        c
        cpp
        nix
        nginx
        fortran
        rust
        python
        cmake
        comment
        dockerfile
        go
        gitcommit
        gitignore
        git-config
        git-rebase
        gitattributes
        gomod
        gosum
        hcl
        helm
        http
        ini
        java
        javascript
        just
        json5
        jinja-inline
        lua
        make
        mermaid
        markdown
        markdown-inline
        pem
        prisma
        promql
        properties
        solidity
        ssh-config
        toml
        terraform
        typescript
        vim
        xml
        yaml
        zig
      ];
    };
  };
}
