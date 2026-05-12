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
      avahi.enable = lib.mkDefault false;

      # Enable SSH
      openssh.enable = lib.mkDefault false;
    };

    services = {
      upower.enable = true;
      tuned.enable = true;
    };

    services.fwupd.enable = true;

    # Install needed packages
    environment.systemPackages = with pkgs; [
      libimobiledevice
    ];

    # Enable Modules
    forgeOS = {
      boot = {
        enableSecureBoot = true;
        plymouth.enable = true;
      };
      desktop.enable = true;
      apps.enableGUIApps = true;
      tools = {
        oxydize = true;
        enableExtendedToolset = true;
      };
      # Enable FIDO support
      security.yubikey.enable = true;
    };
  };
}
