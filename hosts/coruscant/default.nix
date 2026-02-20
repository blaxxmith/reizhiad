{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.apple-t2
    ./hardware.nix
    ../../nixos
    ../generix/laptop.nix
    ../../profiles/work.nix
    ../../profiles
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    plymouth = {
      enable = true;
      theme = "polaroid";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = ["polaroid" "darth_vader" "cuts"];
        })
      ];
    };
  };

  networking.hostName = "coruscant";
  fonts.packages = [pkgs.nerd-fonts.hack];

  forgeOS.host.keymap = "mac";
  forgeOS.host.screen = {
    scale = "1.50";
    mode = "2560x1600@60.001Hz";
  };

  hardware.apple.touchBar = {
    enable = true;
    package = pkgs.tiny-dfr;
    settings = {
      MediaLayerDefault = true;
      # MediaLayerKeys = [
      #   # {
      #   #   Time = "%H:%M";
      #   #   Action = "Time";
      #   #   Stretch = 2;
      #   # }
      #   {Stretch = 2;}
      #   {
      #     Icon = "brightness_low";
      #     Action = "BrightnessDown";
      #   }
      #   {
      #     Icon = "brightness_high";
      #     Action = "BrightnessUp";
      #   }
      #   {
      #     Icon = "volume_off";
      #     Action = "Mute";
      #   }
      #   {
      #     Icon = "volume_down";
      #     Action = "VolumeDown";
      #   }
      #   {
      #     Icon = "volume_up";
      #     Action = "VolumeUp";
      #   }
      #   {Stretch = 2;}
      #   {
      #     Icon = "play_pause";
      #     Action = "Battery";
      #     Stretch = 1;
      #   }
      # ];
    };
  };

  system.stateVersion = "25.11";
}
