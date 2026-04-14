_: {
  flake.nixosModules.system = _: {
    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        download-buffer-size = 536870912; # 512 MiB
        auto-optimise-store = true;
        warn-dirty = false;
        allowed-users = ["@wheel"];
        extra-substituters = ["https://noctalia.cachix.org"];
        extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };

    nixpkgs.config = {
      allowUnfree = true;
      allowBroken = false;
    };
  };
}
