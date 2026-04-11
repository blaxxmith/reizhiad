_: {
  flake.nixosModules.shell = {
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
        enableAliases = lib.mkDefault true;
        enablePrompt = lib.mkDefault true;
      };

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
      };

      home-manager.users.${config.forgeOS.profile.user} = {
        home.shell.enableZshIntegration = true;

        programs.zsh = {
          enable = true;
          package = pkgs.emptyDirectory;
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
  };
}
