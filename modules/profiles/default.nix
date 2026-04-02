{inputs, ...}: {
  flake.nixosModules.profiles = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.host;
    sops = config.sops;
    vars = {
      keymap = cfg.keymap;
      screenMode = cfg.screen.mode;
      screenPos = cfg.screen.position;
      screenScale = cfg.screen.scale;
    };
  in {
    imports = [
      inputs.sops.nixosModules.sops
      # inputs.home-manager.nixosModules.home-manager
    ];

    options.forgeOS.host = {
      keymap = lib.mkOption {
        type = lib.types.str;
        default = "linux";
        description = "Choose a `mac` or a `linux` keymap (and screen)";
        example = "mac";
      };
      screen = {
        scale = lib.mkOption {
          type = lib.types.str;
          description = "Set the scale of your primary screen";
          default = "1.00";
          example = "1.50";
        };
        mode = lib.mkOption {
          type = lib.types.str;
          description = "Sway mode of the primary screen";
          example = "1920x1080@60.000Hz";
        };
        position = lib.mkOption {
          type = lib.types.str;
          description = "Position of the primary screen";
          default = "0,0";
          example = "1111,2222";
        };
      };
    };

    config = {
      sops.age.keyFile = "/root/.sops/keys.txt";
      sops.secrets = let
        mode = "0400";
        format = "binary";
        owner = "eagle";
      in {
        work-gitconfig = {
          inherit owner mode format;
          sopsFile = ../../.secrets/work/gitconfig.sops;
        };
        epita-gitconfig = {
          inherit owner mode format;
          sopsFile = ../../.secrets/epita.gitconfig.sops;
        };
        github-gitconfig = {
          inherit owner mode format;
          sopsFile = ../../.secrets/github.gitconfig.sops;
        };
        glwork-ssh = {
          inherit owner mode format;
          sopsFile = ../../.secrets/work/gitlab.ssh.sops;
        };
        intra-ssh = {
          inherit owner mode format;
          sopsFile = ../../.secrets/school/intra.ssh.sops;
        };
        glcri-ssh = {
          inherit owner mode format;
          sopsFile = ../../.secrets/school/gitlab.ssh.sops;
        };
        github-ssh = {
          inherit owner mode format;
          sopsFile = ../../.secrets/github.ssh.sops;
        };
      };

      home-manager = {
        useGlobalPkgs = true;
        extraSpecialArgs = {inherit inputs vars sops;};
        backupFileExtension = "forgeos.bak";
      };
    };
  };
}
