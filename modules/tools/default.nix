_: {
  flake.nixosModules.tools = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.tools;
  in {
    options.forgeOS.tools = {
      enable = lib.mkEnableOption "Tools and Utilities module";
      enableExtendedToolset = lib.mkEnableOption "extended set of tools and utilities. Otherswise, only a minimal set of tools will be enabled.";

      oxydize = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Replace tools by Rust alternatives when available.";
      };
    };

    config = lib.mkMerge [
      (lib.mkIf cfg.enable {
        forgeOS.tools = {
          eza = {
            enable = true;
            addAlias = true;
          };
          git.enable = true;
          zellij.enable = true;
        };

        environment.systemPackages = with pkgs; [
          wget
          htop
        ];
      })

      (lib.mkIf (cfg.enable && cfg.enableExtendedToolset) {
        forgeOS.tools = {
          ssh.enable = lib.mkDefault true;
          bat.enable = true;
          direnv.enable = true;
          fd.enable = true;
          ripgrep.enable = true;
          skim.enable = true;
          fastfetch.enable = true;
        };

        # MOVE TO A DEDICATED FILE
        # programs.btop.enable = true;

        environment.systemPackages = with pkgs; [
          dua
          dust
          presenterm
          btop
          # only work
          glab
          exegol
        ];
      })

      (lib.mkIf (cfg.enable && cfg.oxydize) {
        forgeOS.tools = {
          bat = {
            addAlias = true;
            man = true;
          };
          fd.addAlias = true;
          ripgrep.addAlias = true;
          skim.addAlias = true;
        };

        programs.zsh.shellAliases = {
          ncdu = "dua i";
          du = "dust --reverse";
        };
      })
    ];
  };
}
