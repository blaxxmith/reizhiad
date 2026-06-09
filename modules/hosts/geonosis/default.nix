{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.geonosis = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [geonosis laptop profiles system];
  };

  flake.nixosModules.geonosis = _: {
    # virtualisation.libvirtd = {
    #   enable = true;
    #   qemu.vhostUserPackages = with pkgs; [virtiofsd];
    # };
    # users.groups.libvirtd.members = ["eagle"];
    # programs.virt-manager.enable = true;

    # environment.systemPackages = with pkgs; [qemu_kvm libvirt];

    forgeOS = {
      boot = {
        enableSecureBoot = true;
        plymouth.theme = "darth_vader";
      };
      desktop = {
        niri.enable = true;
        primaryScreen = {
          mode = {
            width = 1920;
            height = 1200;
            refresh = 60.002;
          };
        };
      };
      profiles.personal.enable = true;
      system = {
        name = "geonosis";
        version = "24.05";
      };
    };
  };
}
