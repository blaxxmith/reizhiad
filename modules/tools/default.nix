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
        forgeOS.tools.eza.enable = true;
        forgeOS.tools.eza.addAlias = true;
        forgeOS.tools.git.enable = true;
        forgeOS.tools.zellij.enable = true;
        forgeOS.tools.ssh.enable = lib.mkDefault true;

        programs.htop.enable = true;

        home.packages = with pkgs; [
          wget
        ];
      })

      (lib.mkIf (cfg.enable && cfg.enableExtendedTools) {
        forgeOS.tools.bat.enable = true;
        forgeOS.tools.direnv.enable = true;
        forgeOS.tools.fd.enable = true;
        forgeOS.tools.ripgrep.enable = true;
        forgeOS.tools.skim.enable = true;
        forgeOS.tools.fastfetch.enable = true;
        programs.btop.enable = true;

        home.packages = with pkgs; [
          dua
          dust
          presenterm
          proton-pass-cli
          glab
          exegol
          devenv
        ];
      })

      (lib.mkIf (cfg.enable && cfg.oxydize) {
        forgeOS.tools.bat.addAlias = true;
        forgeOS.tools.bat.man = true;
        forgeOS.tools.fd.addAlias = true;
        forgeOS.tools.ripgrep.addAlias = true;
        forgeOS.tools.skim.addAlias = true;

        programs.zsh.shellAliases = {
          ncdu = "dua i";
          du = "dust";
        };
      })
    ];
  };
}
