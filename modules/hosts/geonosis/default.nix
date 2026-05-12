{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.geonosis = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [geonosis laptop profiles system];
  };

  flake.nixosModules.geonosis = {pkgs, ...}: {
    virtualisation.libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [virtiofsd];
    };
    users.groups.libvirtd.members = ["eagle"];
    programs.virt-manager.enable = true;

    environment.systemPackages = with pkgs; [qemu_kvm libvirt];

    forgeOS = {
      boot.plymouth.theme = "darth_vader";
      desktop = {
        niri.enable = true;
        primaryScreen = {
          mode = "1920x1200@60.002Hz";
          position = "1440,1778";
        };
      };
      profiles = {
        personal.enable = true;
        work.enable = true;
      };
      system.version = "24.05";
    };
  };
}
