_: {
  flake.homeModules.shell = {
    config,
    lib,
    ...
  }: let
    cfg = config.govelTY.shell;
    editor = "nvim";
  in {
    options.govelTY.shell.enableAliases = lib.mkEnableOption "Shell aliases";

    config = lib.mkIf cfg.enableAliases {
      programs.zsh.shellAliases = {
        dk = "docker";
        dkc = "docker compose";
        k = "kubectl";
        tf = "terraform";
        ai = "ansible-inventory";
        ap = "ansible-playbook";
        nb = "netbird";
        mk = "make -Bj";
        v = "${editor}";
        vi = "${editor}";
        vim = "${editor}";

        # Oneliners
        pskill = "ps aux | sk --preview  '' | awk '{print $2}' | xargs -r kill";

        ":q" = "exit";
      };
    };
  };
}
