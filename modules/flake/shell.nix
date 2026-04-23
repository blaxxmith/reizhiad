_: {
  perSystem = {
    self',
    pkgs,
    ...
  }: {
    devShells = {
      default = self'.devShells.system;

      system = pkgs.mkShellNoCC {
        name = "nix";
        packages = with pkgs; [
          sbctl
          sops
          age
          ssh-to-age
          deadnix
          statix
          vulnix
          nh
        ];

        NH_OS_FLAKE = "./";
      };
    };
  };
}
