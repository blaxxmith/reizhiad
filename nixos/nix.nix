{
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      download-buffer-size = 536870912; # 512 MiB
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };
}
