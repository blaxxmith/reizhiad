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
        # primaryScreen = {
        #   mode = "1920x1200@60.002Hz";
        #   position = "1440,1778";
        # };
      };
      profiles.work.enable = true;
    };

    system.stateVersion = "26.11";
  };
}
