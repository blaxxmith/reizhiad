{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./docker.nix
    ./networking.nix
    ./nix.nix
    ./wm.nix
    ./yubikey.nix
  ];

  time.timeZone = "Europe/Paris";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };

  docker = {
    enable = lib.mkDefault true;
    dns = lib.mkDefault false;
    expose = lib.mkDefault false;
  };

  forgeOS.system.yubikey.enable = lib.mkDefault false;
  security.polkit.enable = true;
  security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      extraConfig = ''
        Defaults !pwfeedback
      '';
    };
  };

  programs.nano.enable = false;
  programs.zsh.enable = true;

  environment = {
    systemPackages = [pkgs.nfs-utils];
    defaultPackages = lib.mkForce [pkgs.rsync];
  };

  documentation = {
    enable = true;
    man.enable = true;
    doc.enable = true;
    info.enable = true;
    nixos.enable = true;
  };

  forgeOS.system.wm.enable = lib.mkDefault false;

  environment.etc.issue.text = ''
         __________   ______   .______      _______  _______   ______        _______.
        /  /   ____| /  __  \\  |   _  \\    /  _____||   ____| /  __  \\      /       |
       /  /|  |__   |  |  |  | |  |_)  |  |  |  __  |  |__   |  |  |  |    |   (----`
      /  / |   __|  |  |  |  | |      /   |  | |_ | |   __|  |  |  |  |     \\   \\
     /  /  |  |     |  `--'  | |  |\\  \\--.|  |__| | |  |____ |  `--'  | .----)   |
    /__/   |__|      \\______/  | _| `.___| \\______| |_______| \\______/  |_______/

    [32m<<< Welcome to \n (\l) >>>[0m

    <<< Current Version: \s \r >>>
    <<< Main IP: \4 >>>
    <<< Logged users: \U >>>

    [1;31m<<< Unauthorized access is prohibited and will be reported >>>[0m

  '';
}
