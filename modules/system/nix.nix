_: {
  flake.nixosModules.system = _: {
    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        download-buffer-size = 536870912; # 512 MiB
        auto-optimise-store = true;
        warn-dirty = false;
        allowed-users = ["@wheel"];
        trusted-users = ["@wheel"];
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
