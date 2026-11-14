_: {
  flake.homeModules.tools = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.govelTY.tools;
  in {
    options.govelTY.tools = {
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
        govelTY.tools = {
          eza = {
            enable = true;
            addAlias = true;
          };
          # git.enable = true;
          zellij.enable = true;
        };

        home.packages = with pkgs; [
          wget
          htop
        ];
      })

      (lib.mkIf (cfg.enable && cfg.enableExtendedToolset) {
        govelTY.tools = {
          # ssh.enable = lib.mkDefault true;
          bat.enable = true;
          direnv.enable = true;
          fd.enable = true;
          ripgrep.enable = true;
          skim.enable = true;
          fastfetch.enable = true;
          gpg.enable = true;
        };

        # MOVE TO A DEDICATED FILE
        # programs.btop.enable = true;

        home.packages = with pkgs; [
          dua
          dust
          presenterm
          btop
        ];
      })

      (lib.mkIf (cfg.enable && cfg.oxydize) {
        govelTY.tools = {
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
