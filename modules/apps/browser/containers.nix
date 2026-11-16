_: {
  flake.homeModules.browser = {lib, ...}: {
    options.govelTY.browser.containers = lib.mkOption {
      description = "Containers for Tabs";
      default = {
        sandbox = {
          name = "sandbox";
          color = "toolbar";
          icon = "fence";
          id = 1;
        };
        school = {
          name = "school";
          color = "blue";
          icon = "dollar";
          id = 2;
        };
        labs = {
          name = "labs";
          color = "green";
          icon = "tree";
          id = 3;
        };
      };
    };
  };
}
