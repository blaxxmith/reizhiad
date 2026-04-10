_: {
  flake.homeModules.tools = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.tools;
  in {
    options.forgeOS.tools = {
      enable = lib.mkEnableOption "Tools and Utilities module";
      enableEssentialTools = lib.mkEnableOption "essential set of tools and utilities";
      enableExtendedTools = lib.mkEnableOption "extended set of tools and utilities";

      oxydize = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Replace tools by Rust alternatives when available.";
      };
    };

    config = lib.mkMerge [
      (lib.mkIf (cfg.enable && cfg.enableEssentialTools) {
        forgeOS.tools = {
          eza = {
            enable = true;
            addAlias = true;
          };
          git.enable = true;
          zellij.enable = true;
          ssh.enable = lib.mkDefault true;
        };

        programs.htop.enable = true;

        home.packages = with pkgs; [
          wget
        ];
      })

      (lib.mkIf (cfg.enable && cfg.enableExtendedTools) {
        forgeOS.tools = {
          bat.enable = true;
          direnv.enable = true;
          fd.enable = true;
          ripgrep.enable = true;
          skim.enable = true;
          fastfetch.enable = true;
        };

        programs.btop.enable = true;

        home.packages = with pkgs; [
          dua
          dust
          presenterm
          proton-pass-cli
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
