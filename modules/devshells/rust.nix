_: {
  perSystem = {pkgs, ...}: {
    devShells.rust = pkgs.mkShell {
      name = "rust";
      packages = with pkgs; [
        bacon
        rustc
        cargo
        clippy
        rustfmt
        cargo-info
        cargo-tarpaulin
        gcc
      ];
    };
  };
}
