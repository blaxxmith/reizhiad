_: {
  flake.nixvimModules.plugins = {
    plugins.gitgutter = {
      enable = true;
      settings = {
        sign_added = "|";
        sign_modified = "|";
        sign_modified_removed = "±";
        sign_removed = "-";
        sign_removed_firstLine = "ø";
      };
    };
  };
}
