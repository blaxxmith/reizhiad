{inputs, ...}: {
  imports = [inputs.treefmt.flakeModule];

  perSystem = _: {
    treefmt.config = {
      projectRootFile = "flake.nix";
      flakeCheck = true;
      programs = {
        alejandra.enable = true;
        deadnix.enable = true;
        statix.enable = true;
        prettier.enable = true;
      };
    };
  };
}
