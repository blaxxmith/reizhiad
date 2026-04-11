{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.geonosis = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules;
      [geonosis laptop profiles system home]
      ++ [
        inputs.lanzaboote.nixosModules.lanzaboote
      ];
  };

  flake.nixosModules.geonosis = {
    config,
    lib,
    pkgs,
    ...
  }: let
    user = "eagle";
  in {
    # Bootloader.
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

    # to move to work profile
    security.pki.certificateFiles = [
      #   /home/eagle/.nixnotsync/certs/telex.crt
      #   /home/eagle/.nixnotsync/certs/multi.crt
      #   /home/eagle/.nixnotsync/certs/tavel.crt
      /home/eagle/.nixnotsync/certs/vigan.crt
      #   /home/eagle/.nixnotsync/certs/alpes.si.crt
    ];

    # virtualisation.libvirtd.enable = true;
    # virtualisation.spiceUSBRedirection.enable = true;
    # users.groups.libvirtd.members = ["eagle"];
    # programs.virt-manager.enable = true;

    # to move to the users file
    users.users."${user}" = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "System Administrator";
      extraGroups = ["networkmanager" "wheel" "docker"];
    };

    # Add to right profile
    home-manager = {
      users."${user}" = {
        imports = [self.homeModules.main];

        home = {
          username = user;
          homeDirectory = "/home/${user}";
        };

        forgeOS = {
          desktop.enable = true;
          apps.zen = {
            enable = true;
            personal = true;
          };
          tools = {
            # nvim.enable = true;
            ssh = {
              enable = true;
              extraFiles = [config.sops.secrets.work-ssh-config.path];
            };
            # nvim.opencode = true;
            git.extraAccounts = {
              "github.com" = {
                remote = "git@github.com";
                gitConfig = "github-gitconfig";
                sshConfig = "github-ssh";
              };
              "git.forge.epita.fr" = {
                remote = "xavier.de-place@git.forge.epita.fr";
                gitConfig = "epita-gitconfig";
                sshConfig = "intra-ssh";
              };
              "gitlab.epita.fr" = {
                remote = "git@gitlab.cri.epita.fr";
                gitConfig = "epita-gitconfig";
                sshConfig = "glcri-ssh";
              };
              "drakkar.cartesian-lab.fr" = {
                remote = "git@drakkar.cartesian-lab.fr";
                gitConfig = "work-gitconfig";
                sshConfig = "glwork-ssh";
              };
            };
          };
        };
      };
    };

    forgeOS = {
      host.screen = {
        mode = "1920x1200@60.002Hz";
        position = "1440,1778";
      };
      system.yubikey = {
        enable = true;
        waylandEnable = false;
      };
      shell.enable = true;
    };

    system.stateVersion = "24.05";
  };
}
