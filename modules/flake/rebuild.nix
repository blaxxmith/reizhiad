_: {
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    apps.default = self'.apps.rebuild;
    apps.rebuild = {
      type = "app";
      meta.description = "Rebuild the current host system";
      program = "${pkgs.writeShellApplication {
        name = "rebuild-system";
        text = ''
          echo "Rebuilding the system for the current host..."

          NH_FLAKE=./ ${pkgs.nh}/bin/nh os switch --quiet --diff always --impure --accept-flake-config
        '';
      }}/bin/rebuild-system";
    };
  };
}
