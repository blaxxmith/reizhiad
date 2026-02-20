{
  lib,
  pkgs,
  inputs,
  ...
}: let
  user = "eagle";
in {
  imports = [
    ./hardware.nix
    ./network.nix
    inputs.home-manager.nixosModules.default
    inputs.lanzaboote.nixosModules.lanzaboote
    ../../nixos
    ../generix/laptop.nix
    ../../profiles/work.nix
  ];

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
          selected_themes = ["darth_vader" "cuts"];
        })
      ];
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
  };

  boot.initrd.luks.devices."luks-67770c13-d64e-4676-8e53-aba49a68d96a".device = "/dev/disk/by-uuid/67770c13-d64e-4676-8e53-aba49a68d96a";

  # to move to work profile
  security.pki.certificateFiles = [
    /home/eagle/.nixnotsync/certs/telex.crt
    /home/eagle/.nixnotsync/certs/multi.crt
    /home/eagle/.nixnotsync/certs/tavel.crt
    /home/eagle/.nixnotsync/certs/vigan.crt
    /home/eagle/.nixnotsync/certs/alpes.si.crt
  ];

  virtualisation.libvirtd.enable = false;
  virtualisation.spiceUSBRedirection.enable = false;
  users.groups.libvirtd.members = ["eagle"];
  programs.virt-manager.enable = false;

  services.netbird = {
    enable = true;
    ui.enable = true;
  };

  # to move to the users file
  users.users."${user}" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "System Administrator";
    extraGroups = ["networkmanager" "wheel" "docker"];
  };

  # Variabilize the user name and add to template host file
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    # users."${user}" = import ./home.nix;
    users."${user}" = {
      imports = [./../../home];

      home = {
        username = user;
        homeDirectory = "/home/${user}";
      };

      # shelltools.enable = true;
      # gui.enable = true;
      forgeOS.desktop.enable = true;
      forgeOS.apps.zen.enable = true;
      nvim.enable = true;
      # iamb.enable = true;
    };
  };

  yubikey = {
    enable = true;
    waylandEnable = false;
  };

  # move this line to the home-manager config
  fonts.packages = [pkgs.nerd-fonts.hack];

  system.stateVersion = "24.05";

  # check if this line is mandatory
  programs.zsh.enable = true;
}
