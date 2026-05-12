_: {
  flake.nixosModules.system = _: {
    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      download-buffer-size = 536870912; # 512 MiB
      auto-optimise-store = true;
      warn-dirty = false;
      allowed-users = ["@wheel"];
      trusted-users = ["@wheel"];
    };

    nixpkgs.config = {
      allowUnfree = true;
      allowBroken = false;
    };

    programs.nh = {
      enable = true;
      flake = "/etc/nixos";
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 5d";
      };
    };
  };
}
