_: {
  flake.nixosModules.geonosis = {lib, ...}: {
    networking = {
      interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
      interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;
    };
  };
}
