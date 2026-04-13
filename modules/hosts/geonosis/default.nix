{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.geonosis = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules;
      [geonosis laptop profiles system]
      ++ [inputs.lzbt.nixosModules.lanzaboote];
  };

  flake.nixosModules.geonosis = {
    lib,
    pkgs,
    ...
  }: {
    boot = {
      loader.systemd-boot.enable = lib.mkForce false;
      bootspec.enable = true;
      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
      plymouth = {
        enable = true;
        theme = "darth_vader";
        themePackages = with pkgs; [
          (adi1090x-plymouth-themes.override {
            selected_themes = ["darth_vader"];
          })
        ];
      };

      consoleLogLevel = 3;
      initrd.verbose = false;
    };

    # virtualisation.libvirtd.enable = true;
    # virtualisation.spiceUSBRedirection.enable = true;
    # users.groups.libvirtd.members = ["eagle"];
    # programs.virt-manager.enable = true;

    forgeOS = {
      desktop.primaryScreen = {
        mode = "1920x1200@60.002Hz";
        position = "1440,1778";
      };
      system.yubikey = {
        enable = true;
        waylandEnable = false;
      };
      profiles = {
        personal.enable = true;
        work.enable = true;
      };
      # apps.zen = {
      #   enable = true;
      #   personal = true;
      # };
      # tools = {
      #   ssh.extraFiles = [config.sops.secrets.work-ssh-config.path];
      #   # nvim.opencode = true;
      #   git.extraAccounts = {
      #     "github.com" = {
      #       remote = "git@github.com";
      #       gitConfig = "github-gitconfig";
      #       sshConfig = "github-ssh";
      #     };
      #   };
      # };
    };

    system.stateVersion = "24.05";
  };
}
