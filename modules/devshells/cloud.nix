{inputs, ...}: {
  perSystem = {system, ...}: let
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    devShells.cloud = pkgs.mkShellNoCC {
      name = "cloud";
      packages = with pkgs; [
        terraform
        packer
        ansible
        kubectl
        kustomize
        kubernetes-helm
        k9s
      ];

      shellHooks = ''
        export NIXPKGS_ALLOW_UNFREE=1
      '';
    };
  };
}
