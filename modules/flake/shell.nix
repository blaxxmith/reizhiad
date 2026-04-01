{...}: {
  perSystem = {
    self',
    pkgs,
    ...
  }: {
    devShells = {
      default = self'.devShells.nix;

      nix = pkgs.mkShell {
        name = "nix";
        packages = with pkgs; [sbctl sops age ssh-to-age];
      };
    };
  };
}
