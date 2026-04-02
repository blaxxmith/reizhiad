{...}: {
  flake.homeModules.neovim = {...}: {
    programs.nixvim.plugins.lightline = {
      enable = true;
      settings = {
        colorscheme = "material";
        active = {
          left = [
            ["mode" "paste"]
            ["gitbranch" "readonly" "filename" "modified"]
          ];
          right = [
            ["lineinfo"]
            ["percent"]
            ["fileformat" "fileencoding" "filetype" "charvaluehex"]
          ];
        };
        component_function = {
          gitbranch = "FugitiveHead";
        };
        component = {
          charvaluehex = "0x%B";
        };
      };
    };
  };
}
