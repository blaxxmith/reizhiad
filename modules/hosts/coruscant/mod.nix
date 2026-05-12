{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.coruscant = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [coruscant laptop profiles system];
  };

  flake.nixosModules.coruscant = {lib, ...}: {
    forgeOS = {
      desktop = {
        niri.enable = true;
        primaryScreen = {
          mode = "1920x1200@60.002Hz";
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
