{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.mustafar = inputs.nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    modules = [
      inputs.nixos-hardware.nixosModules.raspberry-pi-4
      self.nixosModules.mustafar
    ];
  };

  flake.nixosModules.mustafar = {pkgs, ...}: {
    boot = {
      supportedFilesystems = ["nfs"];
      kernelModules = [
        "bcm2835-v4l2"
        "v4l2_mem2mem"
        "bcm2835_codec"
      ];
    };

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-label/NIXOS_SD";
        fsType = "ext4";
        options = ["noatime"];
      };
    };

    hardware.raspberry-pi."4".fkms-3d.enable = true;

    networking = {
      hostName = "mustafar";
      firewall = {
        enable = true;
        allowedTCPPorts = [22 80 443 6443];
        allowedUDPPorts = [8472];
      };
    };

    time.timeZone = "Europe/Paris";
    i18n.defaultLocale = "en_US.UTF-8";

    users = {
      mutableUsers = false;
      users = {
        sysadmin = {
          isNormalUser = true;
          description = "Administrator User";
          extraGroups = ["wheel"];
          initialPassword = "M@ster123456";
          openssh.authorizedKeys.keys = [
            "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAID5B3B+eQbF2aqqQZQPKVHR2BdQNYnmJ0wLXkrqtSJYGAAAABHNzaDo= sysadmin@geonosis.forge"
          ];
        };
        nixos = {
          isNormalUser = true;
          createHome = false;
          description = "Backup Admin User";
          extraGroups = ["wheel"];
          initialPassword = "M@ster123456";
          openssh.authorizedKeys.keys = [
            "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAID5B3B+eQbF2aqqQZQPKVHR2BdQNYnmJ0wLXkrqtSJYGAAAABHNzaDo= sysadmin@geonosis.forge"
          ];
        };
      };
    };

    security.sudo.extraRules = [
      {
        users = ["nixos"];
        commands = [
          {
            command = "ALL";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];

    environment = {
      variables.KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
      systemPackages = with pkgs; [
        kubectl
        btop
        nfs-utils
        zellij
        wget
      ];
    };

    services = {
      openssh.enable = true;
      netbird.enable = true;
      k3s = {
        enable = true;
        role = "server";
        clusterInit = true;
        extraFlags = [
          "--node-name=mustafar"
          "--write-kubeconfig-mode=0644"
        ];
      };
    };

    system.stateVersion = "26.05";
  };
}
