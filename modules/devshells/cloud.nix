_: {
  perSystem = {pkgs, ...}: {
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
