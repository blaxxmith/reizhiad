_: {
  flake.homeModules.shell = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.shell.aliases;
    editor = "nvim";
  in {
    options.forgeOS.shell.aliases = {
      enable = lib.mkEnableOption true;
    };

    config = lib.mkIf cfg.enable {
      programs.zsh.shellAliases = {
        mk = "${editor} Makefile";

        dk = "docker";
        dkc = "docker compose";
        k = "kubectl";
        tf = "terraform";
        ai = "ansible-inventory";
        ap = "ansible-playbook";
        nb = "netbird";
        make = "make -Bj";
        v = "${editor}";

        # Oneliners
        pskill = "ps aux | sk | awk '{print $2}' | xargs -r kill";

        ":q" = "exit";
      };
    };
  };
}
