_: {
  flake.nixosModules.apps = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.apps.yazi;
  in {
    options.forgeOS.apps.yazi.enable = lib.mkEnableOption "Yazi TUI File Manager";

    config = lib.mkIf cfg.enable {
      environment.systemPackages = [pkgs.yazi];
      home-manager.sharedModules = [
        {
          programs.yazi = {
            enable = true;
            enableZshIntegration = true;
            shellWrapperName = "yy";
            settings = {
              mgr = {
                ratio = [1 3 3];
                linemode = "size";
                sort_by = "natural";
                show_hidden = true;
                show_symlink = true;
              };
              preview = {
                wrap = "no";
                tab_size = 2;
                max_width = 1200;
                max_height = 1000;
              };
              input = {
                cursor_blink = true;
              };
            };
          };
        }
      ];
    };
  };
}
