{self, ...}: {
  flake.nixosModules.system = {
    lib,
    pkgs,
    ...
  }: {
    imports = with self.nixosModules; [docker];

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

    users.mutableUsers = false;

    documentation = {
      enable = true;
      man.enable = true;
      doc.enable = true;
      info.enable = true;
      nixos.enable = true;
    };

    forgeOS.desktop.enable = lib.mkDefault false;

    environment.etc.issue.text = ''
           _________/\\/\\__________________________________________________/\\/\\____/\\/\\/\\/\\/\\____/\\/\\____/\\/\\_
          _______/\\/\\______/\\/\\/\\/\\____/\\/\\/\\____/\\/\\__/\\/\\____/\\/\\/\\____/\\/\\____/\\/\\____/\\/\\__/\\/\\__/\\/\\___
         _____/\\/\\______/\\/\\__/\\/\\__/\\/\\__/\\/\\__/\\/\\__/\\/\\__/\\/\\/\\/\\/\\__/\\/\\____/\\/\\/\\/\\/\\____/\\/\\/\\/\\_____
        ___/\\/\\__________/\\/\\/\\/\\__/\\/\\__/\\/\\____/\\/\\/\\____/\\/\\________/\\/\\____/\\/\\__/\\/\\____/\\/\\__/\\/\\___
       _/\\/\\________________/\\/\\____/\\/\\/\\________/\\________/\\/\\/\\/\\__/\\/\\/\\__/\\/\\____/\\/\\__/\\/\\____/\\/\\_
      _______________/\\/\\/\\/\\___________________________________________________________________________

      [32m<<< Welcome to \n (\l) >>>[0m

      <<< Current Version: \s \r >>>
      <<< Main IP: \4 >>>
      <<< Logged users: \U >>>

      [1;31m<<< Unauthorized access is prohibited and will be reported >>>[0m

    '';
  };
}
