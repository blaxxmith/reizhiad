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
          mode = "2880x1800@120.000Hz";
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
