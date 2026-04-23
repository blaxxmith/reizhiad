_: {
  perSystem = {pkgs, ...}: {
    apps.deploy-mustafar = {
      type = "app";
      meta.description = "Deploy the current host system to mustafar.forge";
      program = "${pkgs.writeShellApplication {
        name = "deploy-mustafar";
        text = ''
          echo "Rebuilding the system for the current host..."

          NH_ELEVATION_STRATEGY="passwordless" \
          NH_FLAKE=./ ${pkgs.nh}/bin/nh os switch -H mustafar \
            --target-host nixos@mustafar.forge --build-host nixos@mustafar.forge --accept-flake-config
        '';
      }}/bin/deploy-mustafar";
    };
  };
}
