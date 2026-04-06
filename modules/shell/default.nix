_: {
  flake.homeModules.shell = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.shell;
  in {
    options.forgeOS.shell = {
      enable = lib.mkEnableOption "ZSH as main shell";
    };

    config = lib.mkIf cfg.enable {
      forgeOS.shell = {
        aliases.enable = lib.mkDefault true;
        prompt.enable = lib.mkDefault true;
      };

      programs.zsh = {
        enable = true;
        autocd = true;
        syntaxHighlighting.enable = true;
        autosuggestion.enable = false;
        enableCompletion = true;
        historySubstringSearch.enable = true;

        initContent = ''
          cd() {
          builtin cd "$@" && ${pkgs.eza}/bin/eza --icons=always --color=always --sort=type
          }
          if command -v kubectl >/dev/null 2>&1; then
            source <(${pkgs.kubectl}/bin/kubectl completion zsh)
          fi
          if command -v helm >/dev/null 2>&1; then
            source <(${pkgs.helm}/bin/helm completion zsh)
          fi
          if command -v hugo >/dev/null 2>&1; then
            source <(${pkgs.hugo}/bin/hugo completion zsh)
          fi

        '';

        history = {
          append = true;
          expireDuplicatesFirst = true;
          findNoDups = true;
          ignoreAllDups = true;
          ignoreDups = true;
          ignoreSpace = true;
          save = 10000;
          saveNoDups = true;
          share = false;
        };
      };
    };
  };
}
