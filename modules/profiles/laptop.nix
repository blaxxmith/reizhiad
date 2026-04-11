_: {
  flake.nixosModules.laptop = {
    lib,
    pkgs,
    ...
  }: {
    services = {
      libinput = {
        # Enable touchpad tap-to-click and natural scrolling
        enable = true;
        touchpad.naturalScrolling = true;
      };

      # Enable capabilities for mobile thethering
      # $ idevicepair pair
      usbmuxd.enable = true;

      # Enable printing
      printing.enable = lib.mkDefault false;

      # Enable SSH
      openssh.enable = lib.mkDefault false;
      # fprintd.enable = true;
    };

    # Enable Sound
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = false;
    };

    services.tlp.enable = true;

    # Install needed packages
    environment.systemPackages = with pkgs; [
      brightnessctl
      libimobiledevice
      pamixer
    ];

    # Enable Modules
    forgeOS = {
      desktop.enable = true;
      apps.enableGUIApps = true;
    };

    # Enable FIDO support
    forgeOS.system.yubikey.enable = true;
  };
}
