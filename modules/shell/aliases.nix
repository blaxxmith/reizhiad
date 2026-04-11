_: {
  flake.nixosModules.shell = {
    config,
    lib,
    ...
  }: let
    cfg = config.forgeOS.shell;
    editor = "nvim";
  in {
    options.forgeOS.shell.enableAliases = lib.mkEnableOption "Shell aliases";

    config.home-manager.users.${config.forgeOS.profile.user} = lib.mkIf cfg.enableAliases {
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
