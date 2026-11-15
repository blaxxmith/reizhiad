_: {
  flake.homeModules.browser = {lib, ...}: {
    options.govelTY.browser.containers = lib.mkOption {
      description = "Containers for Tabs";
      default = {
        sandbox = {
          name = "Work";
          color = "yellow";
          icon = "briefcase";
          id = 1;
        };
        school = {
          name = "School";
          color = "blue";
          icon = "vacation";
          id = 2;
        };
        labs = {
          name = "Forge";
          color = "green";
          icon = "tree";
          id = 3;
        };
        personal = {
          name = "Personal";
          color = "red";
          icon = "fingerprint";
          id = 4;
        };
      };
    };
  };
}
