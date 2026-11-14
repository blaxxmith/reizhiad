{
  inputs,
  self,
  ...
}: {
  imports = [inputs.nixvim.flakeModules.default];

  nixvim = {
    packages.enable = true;
    checks.enable = true;
  };

  perSystem = {system, ...}: {
    nixvimConfigurations.nvim = inputs.nixvim.lib.evalNixvim {
      inherit system;
      modules = [
        self.nixvimModules.default
        self.nixvimModules.plugins

        {
          nixpkgs.source = inputs.nixpkgs.outPath;
          enableMan = true;
        }
      ];
    };
  };

  flake.nixosModules.neovim = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.tools.nvim;
  in {
    options.forgeOS.tools.nvim.enable = lib.mkEnableOption "NeoVIM configuration";

    config = lib.mkIf cfg.enable {
      programs.nano.enable = false;
      environment = {
        systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.nvim];
        variables.EDITOR = "nvim";
      };
    };
  };
}
