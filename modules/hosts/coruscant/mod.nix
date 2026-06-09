{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.coruscant = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [coruscant laptop profiles system];
  };

  flake.nixosModules.coruscant = _: {
    forgeOS = {
      desktop = {
        niri.enable = true;
        primaryScreen = {
          mode = {
            width = 2880;
            height = 1800;
            refresh = 120.000;
          };
          position = {
            x = 1670;
            y = 1940;
          };
          scale = 1.4;
        };
      };
      profiles.work.enable = true;

      system = {
        name = "coruscant";
        version = "25.11";
      };
    };
  };
}
